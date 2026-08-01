return function()
	local function notify(msg)
		os.execute("notify-send -a jjui 'Stacked PR (gh stack)' '" .. msg:gsub("'", "'\\''") .. "'")
	end

	local function shell(cmd)
		local h = io.popen(cmd)
		local out = h:read("*a"):gsub("%s+$", "")
		h:close()
		return out
	end

	local change_id = revisions.current()
	if not change_id then
		flash("No revision selected")
		return
	end

	local revset = change_id .. "::"
	local output, err = jj(
		"log",
		"-r",
		revset,
		"--reversed",
		"--no-graph",
		"--template",
		[[change_id.shortest() ++ '~' ++ bookmarks.map(|b| b.name()).join(",") ++ '~' ++ description.first_line() ++ '~']]
	)
	if err then
		flash("Error getting descendants: " .. err)
		return
	end

	local stack_raw = {}
	for cid, bm, desc in output:gmatch("([^~]+)~([^~]*)~([^~]*)~") do
		local bookmark = (bm ~= "") and bm:match("^([^,]+)") or nil
		table.insert(stack_raw, { cid = cid, bookmark = bookmark, description = desc })
	end
	if #stack_raw == 0 then
		flash("No revisions found")
		return
	end

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

	local push_args = { "git", "push" }
	for _, entry in ipairs(stack_trimmed) do
		table.insert(push_args, "--bookmark")
		table.insert(push_args, entry.bookmark)
	end

	notify("Pushing " .. #stack_trimmed .. " bookmarks...")
	local push_out, push_err = jj(push_args)
	if push_err then
		flash("Push failed: " .. push_err)
		return
	end

	local owner = shell("gh repo view --json owner --jq '.owner.login' 2>/dev/null")
	local repo_name = shell("gh repo view --json name --jq '.name' 2>/dev/null")

	local pr_numbers = {}
	for i, entry in ipairs(stack_trimmed) do
		local parent_base = (i == 1) and trunk or stack_trimmed[i - 1].bookmark
		local existing_pr = shell("gh pr list --head '" .. entry.bookmark .. "' --state open --json number --jq '.[0].number' 2>/dev/null")

		if existing_pr ~= "" then
			local current_base = shell("gh pr view " .. existing_pr .. " --json baseRefName --jq '.baseRefName' 2>/dev/null")
			if current_base ~= parent_base then
				shell("gh pr edit " .. existing_pr .. " --base '" .. parent_base .. "' 2>&1")
			end
			table.insert(pr_numbers, tonumber(existing_pr))
		else
			local pr_title = entry.description ~= "" and entry.description or entry.bookmark
			local result = shell(
				"gh pr create --draft --base '"
					.. parent_base
					.. "' --head '"
					.. entry.bookmark
					.. "' --title '"
					.. pr_title:gsub("'", "'\\''")
					.. "' --body '' 2>&1"
			)
			local num = result:match("/pull/(%d+)")
			if not num then
				flash("Failed to create PR for " .. entry.bookmark .. ": " .. result)
				return
			end
			table.insert(pr_numbers, tonumber(num))
		end
	end

	local stack_num = shell(
		"gh api repos/" .. owner .. "/" .. repo_name .. "/pulls/" .. pr_numbers[1] .. " --jq '.stack.number' 2>/dev/null"
	)
	if stack_num ~= "" and stack_num ~= "null" then
		notify("Unstacking existing stack #" .. stack_num .. "...")
		shell("gh stack unstack " .. stack_num .. " 2>&1")
	end

	local link_args = {}
	for _, num in ipairs(pr_numbers) do
		table.insert(link_args, tostring(num))
	end
	local link_cmd = "gh stack link --base '" .. trunk .. "' " .. table.concat(link_args, " ") .. " 2>&1"

	notify("Linking stack...")
	local result = shell(link_cmd)

	if result:match("error") or result:match("failed") then
		flash("gh stack link failed: " .. result)
		return
	end

	notify(result)
	flash("gh stack: " .. #pr_numbers .. " PRs linked")
end
