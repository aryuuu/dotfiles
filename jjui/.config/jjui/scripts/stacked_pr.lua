local function notify(msg)
	os.execute("notify-send -a jjui 'Stacked PR' '" .. msg:gsub("'", "'\\''") .. "'")
end

-- Step 1: Get selected revision
local change_id = revisions.current()
if not change_id then
	flash("No revision selected")
	return
end

-- Step 2: Walk descendants
local revset = change_id .. "::"
local output, err = jj("log", "-r", revset, "--reversed", "--no-graph", "--template", [[change_id.shortest() ++ ',']])
if err then
	flash("Error getting descendants: " .. err)
	return
end
local change_ids = {}
for v in output:gmatch("[^,]+") do
	table.insert(change_ids, v)
end
notify("Found " .. #change_ids .. " descendants: " .. table.concat(change_ids, ", "))
if #change_ids == 0 then
	flash("No revisions found")
	return
end

-- Step 3: Collect bookmarks per change, preserving stack order
local stack_raw = {}
for _, cid in ipairs(change_ids) do
	local bm_out, bm_err = jj("bookmark", "list", "-r", cid, "--template", [[name ++ ',']])
	local bm = nil
	if not bm_err and bm_out ~= "" then
		for v in bm_out:gmatch("[^,]+") do
			bm = v
			break
		end
	end
	table.insert(stack_raw, { cid = cid, bookmark = bm })
end

local raw_dbg = {}
for _, sr in ipairs(stack_raw) do
	table.insert(raw_dbg, sr.cid .. "=" .. (sr.bookmark or "none"))
end
notify("Raw stack: " .. table.concat(raw_dbg, ", "))

-- Trim trailing entries with no bookmark, error on gaps in middle
local last_with_bm = 0
for i = #stack_raw, 1, -1 do
	if stack_raw[i].bookmark then
		last_with_bm = i
		break
	end
end
if last_with_bm == 0 then
	flash("No bookmarks found on any descendant")
	return
end

local stack_trimmed = {}
for i = 1, last_with_bm do
	if not stack_raw[i].bookmark then
		flash("Change " .. stack_raw[i].cid .. " in middle of stack has no bookmark — breaks the chain")
		return
	end
	table.insert(stack_trimmed, stack_raw[i])
end

-- Step 4: Detect trunk branch
local trunk = "main"
local all_bm_out, all_bm_err = jj("bookmark", "list", "--template", "name ++ ','")
if not all_bm_err then
	local all_bm_set = {}
	for b in all_bm_out:gmatch("[^,]+") do
		all_bm_set[b] = true
	end
	for _, candidate in ipairs({ "argo-fawkes", "master", "main", "dev" }) do
		if all_bm_set[candidate] then
			trunk = candidate
			break
		end
	end
end
notify("Trunk branch: " .. trunk)

-- Step 5: Build stack metadata
local stack = {}
for i, entry in ipairs(stack_trimmed) do
	local parent_base = (i == 1) and trunk or stack_trimmed[i - 1].bookmark
	local h = io.popen("gh pr list --head '" .. entry.bookmark .. "' --json number,baseRefName --jq '.[0]' 2>/dev/null")
	local pr_json = h:read("*a"):gsub("%s+$", "")
	h:close()

	local pr_number = nil
	local current_base = nil
	if pr_json ~= "" and pr_json ~= "null" then
		pr_number = tonumber(pr_json:match('"number":(%d+)'))
		current_base = pr_json:match('"baseRefName":"([^"]*)"')
	end

	local action = "NEW"
	if pr_number then
		if current_base == parent_base then
			action = "OK"
		else
			action = "RETARGET"
		end
	end

	table.insert(stack, {
		cid = entry.cid,
		bookmark = entry.bookmark,
		parent_base = parent_base,
		pr_number = pr_number,
		current_base = current_base,
		action = action,
	})
end

local dbg = {}
for _, e in ipairs(stack) do
	table.insert(dbg, e.bookmark .. "(" .. e.action .. ", base:" .. e.parent_base .. ")")
end
notify("Stack: " .. table.concat(dbg, " → "))

-- Step 6: Build confirmation summary
local new_lines, retarget_lines, ok_lines, bm_names = {}, {}, {}, {}
for _, e in ipairs(stack) do
	table.insert(bm_names, e.bookmark)
	if e.action == "NEW" then
		table.insert(new_lines, "  " .. e.bookmark .. " → base: " .. e.parent_base)
	elseif e.action == "RETARGET" then
		table.insert(
			retarget_lines,
			"  #" .. e.pr_number .. " " .. e.bookmark .. ": " .. (e.current_base or "?") .. " → " .. e.parent_base
		)
	else
		table.insert(ok_lines, "  #" .. e.pr_number .. " " .. e.bookmark)
	end
end

if #new_lines == 0 and #retarget_lines == 0 then
	flash("All PRs up to date")
	return
end

local summary = "Push & Create Stacked PRs (bookmark)\\n\\nBookmarks to push: " .. table.concat(bm_names, ", ")
summary = summary .. "\\n\\nNew PRs:\\n" .. (#new_lines > 0 and table.concat(new_lines, "\\n") or "  (none)")
summary = summary
	.. "\\n\\nRetarget PRs:\\n"
	.. (#retarget_lines > 0 and table.concat(retarget_lines, "\\n") or "  (none)")
summary = summary .. "\\n\\nAlready up to date:\\n" .. (#ok_lines > 0 and table.concat(ok_lines, "\\n") or "  (none)")

-- local choice = choose({ options = { "Yes, proceed", "Cancel" }, title = summary })
-- if not choice or choice == "Cancel" then
-- 	flash("Cancelled")
-- 	return
-- end

-- -- Step 7: Synchronous push
-- local push_args = { "git", "push", "--allow-new" }
-- for _, entry in ipairs(stack) do
-- 	table.insert(push_args, "--bookmark")
-- 	table.insert(push_args, entry.bookmark)
-- end
-- flash("Pushing " .. #stack .. " bookmarks...")
-- local push_out, push_err = jj(push_args)
-- if push_err then
-- 	flash("Push failed: " .. push_err)
-- 	return
-- end

-- Step 8: Bottom-up PR processing (Pass 1)
local created, retargeted = {}, {}
for _, entry in ipairs(stack) do
	if entry.action == "NEW" then
		notify("Creating PR for " .. entry.bookmark .. "...")
		local desc_out, desc_err = jj("log", "-r", entry.cid, "--no-graph", "-T", "description.first_line()")
		local pr_title = (not desc_err and desc_out ~= "") and desc_out:gsub("%s+$", "") or entry.bookmark
		local h = io.popen(
			"gh pr create --draft --base '"
				.. entry.parent_base
				.. "' --head '"
				.. entry.bookmark
				.. "' --title '"
				.. pr_title:gsub("'", "'\\''")
				.. "' --body '' 2>&1"
		)
		local result = h:read("*a")
		h:close()
		local num = result:match("/pull/(%d+)")
		if not num then
			flash("Failed to create PR for " .. entry.bookmark .. ": " .. result)
			return
		end
		entry.pr_number = tonumber(num)
		table.insert(created, entry)
		notify("Created PR #" .. entry.pr_number .. " for " .. entry.bookmark)
	elseif entry.action == "RETARGET" then
		notify("Retargeting #" .. entry.pr_number .. " to " .. entry.parent_base .. "...")
		local h = io.popen("gh pr edit " .. entry.pr_number .. " --base '" .. entry.parent_base .. "' 2>&1")
		local result = h:read("*a")
		h:close()
		if result:match("error") or result:match("failed") then
			flash("Retarget failed for #" .. entry.pr_number .. ": " .. result)
			return
		end
		table.insert(retargeted, entry)
		notify("Retargeted #" .. entry.pr_number .. " to " .. entry.parent_base)
	end
end

local function splice_stack_section(existing_body, new_stack_content)
	local marked = "<!-- stack-start -->\n" .. new_stack_content .. "<!-- stack-end -->"
	if not existing_body or existing_body == "" then
		return marked
	end
	local s_start = string.find(existing_body, "<!-- stack-start -->", 1, true)
	local s_end = string.find(existing_body, "<!-- stack-end -->", 1, true)
	if s_start and s_end then
		local before = string.sub(existing_body, 1, s_start - 1)
		local after = string.sub(existing_body, s_end + #"<!-- stack-end -->")
		return before .. marked .. after
	end
	return existing_body .. "\n\n" .. marked
end

-- Step 9: Update bodies for all PRs in the stack
local repo_h = io.popen("gh repo view --json url --jq '.url' 2>/dev/null")
local repo_url = repo_h:read("*a"):gsub("%s+$", "")
repo_h:close()

-- Collect current stack PR numbers
local current_pr_set = {}
for _, e in ipairs(stack) do
	if e.pr_number then
		current_pr_set[e.pr_number] = true
	end
end

-- Find merged ancestor PRs from existing stack sections
local merged_ancestors = {}
for _, e in ipairs(stack) do
	if e.pr_number then
		local bh = io.popen("gh pr view " .. e.pr_number .. " --json body --jq '.body' 2>/dev/null")
		local existing_body = bh:read("*a"):gsub("%s+$", "")
		bh:close()
		if existing_body ~= "" then
			local s_start = string.find(existing_body, "<!-- stack-start -->", 1, true)
			local s_end = string.find(existing_body, "<!-- stack-end -->", 1, true)
			if s_start and s_end then
				local section = string.sub(existing_body, s_start, s_end)
				for num in section:gmatch("/pull/(%d+)") do
					local n = tonumber(num)
					if n and not current_pr_set[n] then
						merged_ancestors[n] = true
					end
				end
			end
		end
		break -- only need to check one existing PR
	end
end

-- Verify they're actually merged and build ordered list
local merged_list = {}
for num, _ in pairs(merged_ancestors) do
	local mh = io.popen("gh pr view " .. num .. " --json state --jq '.state' 2>/dev/null")
	local state = mh:read("*a"):gsub("%s+$", "")
	mh:close()
	if state == "MERGED" then
		table.insert(merged_list, num)
	end
end
table.sort(merged_list)

local stack_content = "PR stack:\n"
for _, num in ipairs(merged_list) do
	stack_content = stack_content .. "- " .. repo_url .. "/pull/" .. num .. "\n"
end
for _, e in ipairs(stack) do
	if e.pr_number then
		stack_content = stack_content .. "- " .. repo_url .. "/pull/" .. e.pr_number .. "\n"
	end
end
local tmpfile = os.tmpname()
for _, e in ipairs(stack) do
	if e.pr_number then
		local bh = io.popen("gh pr view " .. e.pr_number .. " --json body --jq '.body' 2>/dev/null")
		local existing_body = bh:read("*a"):gsub("%s+$", "")
		bh:close()
		local new_body = splice_stack_section(existing_body, stack_content)
		local f = io.open(tmpfile, "w")
		f:write(new_body)
		f:close()
		local h = io.popen("gh pr edit " .. e.pr_number .. " --body-file '" .. tmpfile .. "' 2>&1")
		h:read("*a")
		h:close()
	end
end
os.remove(tmpfile)

-- Step 10: Flash success
flash("Stacked PRs created/updated: " .. #created .. " new, " .. #retargeted .. " retargeted")
