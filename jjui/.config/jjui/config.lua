function setup(config)
	local function ctc()
		local id = context.change_id()
		if id then
			copy_to_clipboard(id)
			flash("Copied: " .. id)
		end
	end

	local function push_with_descendants()
		-- Push current changeset and all descendants with bookmarks
		local change_id = revisions.current()
		if not change_id then
			flash("No revision selected")
			return
		end

		-- Get all descendants including current
		local revset = change_id .. "::"
		local output, err = jj("log", "-r", revset, "--no-graph", "--template", [[change_id ++ ',']])
		if err then
			flash("Error getting descendants: " .. err)
			return
		end

		local change_ids = {}
		for v in output:gmatch("[^,]+") do
			table.insert(change_ids, v)
		end
		if #change_ids == 0 then
			flash("No revisions found")
			return
		end

		-- Get bookmarks for all these revisions
		local bookmarks = {}
		local bookmark_set = {}
		for _, cid in ipairs(change_ids) do
			local bookmark_output, bookmark_err = jj("bookmark", "list", "-r", cid, "--template", [[name ++ ',']])
			if not bookmark_err and bookmark_output ~= "" then
				for name in bookmark_output:gmatch("[^,]+") do
					if name ~= "" and not bookmark_set[name] then
						bookmark_set[name] = true
						table.insert(bookmarks, name)
					end
				end
			end
		end

		if #bookmarks == 0 then
			flash("No bookmarks found on current revision or descendants")
			return
		end

		-- Build git push command with all bookmarks
		local args = { "git", "push", "--allow-new" }
		for _, bookmark in ipairs(bookmarks) do
			table.insert(args, "--bookmark")
			table.insert(args, bookmark)
		end

		-- Show what we're about to push
		local bookmark_list = table.concat(bookmarks, ", ")
		flash("Pushing bookmarks: " .. bookmark_list)

		-- Execute the push
		jj_async(args)
		revisions.refresh()
	end

	local function new_before()
		local change_id = revisions.current()
		if not change_id then
			flash("No revision selected")
			return
		end
		jj({ "new", "-B", change_id })
		revisions.refresh()
	end

	local function new_after()
		local change_id = revisions.current()
		if not change_id then
			flash("No revision selected")
			return
		end
		jj({ "new", "-A", change_id })
		revisions.refresh()
	end

	local function push_with_descendants_bare()
		local change_id = revisions.current()
		if not change_id then
			flash("No revision selected")
			return
		end

		-- Get all descendants including current
		local revset = change_id .. "::"
		local output, err = jj("log", "-r", revset, "--no-graph", "--template", [[change_id ++ ',']])
		if err then
			flash("Error getting descendants: " .. err)
			return
		end

		local change_ids = {}
		for v in output:gmatch("[^,]+") do
			table.insert(change_ids, v)
		end
		if #change_ids == 0 then
			flash("No revisions found")
			return
		end

		-- Build git push command with all change ids
		local args = { "git", "push" }
		for _, cid in ipairs(change_ids) do
			table.insert(args, "--change")
			table.insert(args, cid)
		end

		-- Show what we're about to push
		local cid_list = table.concat(change_ids, ", ")
		flash("Pushing changes: " .. cid_list)

		-- Execute the push
		jj_async(args)
		revisions.refresh()
	end

	local function stacked_pr()
		local function notify(msg)
			os.execute("notify-send -a jjui 'Stacked PR' '" .. msg:gsub("'", "'\\''") .. "'")
		end

		local function shell(cmd)
			local h = io.popen(cmd)
			local out = h:read("*a"):gsub("%s+$", "")
			h:close()
			return out
		end

		-- Step 1: Get selected revision
		local change_id = revisions.current()
		if not change_id then
			flash("No revision selected")
			return
		end

		-- Step 2+3: Walk descendants and collect bookmarks in one jj call
		local revset = change_id .. "::"
		local output, err = jj(
			"log",
			"-r",
			revset,
			"--reversed",
			"--no-graph",
			"--template",
			[[change_id ++ '~' ++ bookmarks.map(|b| b.name()).join(",") ++ '~']]
		)
		if err then
			flash("Error getting descendants: " .. err)
			return
		end

		local stack_raw = {}
		for cid, bm in output:gmatch("([^~]+)~([^~]*)~") do
			local bookmark = (bm ~= "") and bm:match("^([^,]+)") or nil
			table.insert(stack_raw, { cid = cid, bookmark = bookmark })
		end
		if #stack_raw == 0 then
			flash("No revisions found")
			return
		end

		-- Trim trailing entries with no bookmark, error on gaps
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

		-- Step 5: Batch PR lookup via GraphQL
		local repo_url = shell("gh repo view --json url --jq '.url' 2>/dev/null")
		local owner_repo = repo_url:match("github%.com/(.+)$") or ""
		local owner, repo_name = owner_repo:match("^([^/]+)/(.+)$")

		local pr_by_head = {}
		if owner and repo_name then
			local fields = {}
			for i, e in ipairs(stack_trimmed) do
				table.insert(
					fields,
					string.format(
						'b%d: pullRequests(headRefName: "%s", states: OPEN, first: 1) { nodes { number baseRefName } }',
						i,
						e.bookmark
					)
				)
			end
			local query = string.format(
				'query { repository(owner: "%s", name: "%s") { %s } }',
				owner,
				repo_name,
				table.concat(fields, " ")
			)
			local gql_out = shell("gh api graphql -f query='" .. query:gsub("'", "'\\''") .. "' 2>/dev/null")
			-- Parse each bookmark's result
			for i, e in ipairs(stack_trimmed) do
				local pattern = '"b'
					.. i
					.. '":%s*{%s*"nodes":%s*%[%s*{%s*"number":%s*(%d+).-"baseRefName":%s*"([^"]*)"'
				local num, base = gql_out:match(pattern)
				if num then
					pr_by_head[e.bookmark] = { number = tonumber(num), base = base }
				end
			end
		end

		-- Build stack metadata
		local stack = {}
		for i, entry in ipairs(stack_trimmed) do
			local parent_base = (i == 1) and trunk or stack_trimmed[i - 1].bookmark
			local pr = pr_by_head[entry.bookmark]
			local pr_number = pr and pr.number or nil
			local current_base = pr and pr.base or nil

			local action = "NEW"
			if pr_number then
				action = (current_base == parent_base) and "OK" or "RETARGET"
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

		-- Step 6: Create/retarget PRs (these must be sequential)
		local created, retargeted = {}, {}
		for _, entry in ipairs(stack) do
			if entry.action == "NEW" then
				notify("Creating PR for " .. entry.bookmark .. "...")
				local desc_out, desc_err = jj("log", "-r", entry.cid, "--no-graph", "-T", "description.first_line()")
				local pr_title = (not desc_err and desc_out ~= "") and desc_out:gsub("%s+$", "") or entry.bookmark
				local result = shell(
					"gh pr create --draft --base '"
						.. entry.parent_base
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
				entry.pr_number = tonumber(num)
				table.insert(created, entry)
			elseif entry.action == "RETARGET" then
				notify("Retargeting #" .. entry.pr_number .. " to " .. entry.parent_base .. "...")
				local result = shell("gh pr edit " .. entry.pr_number .. " --base '" .. entry.parent_base .. "' 2>&1")
				if result:match("error") or result:match("failed") then
					flash("Retarget failed for #" .. entry.pr_number .. ": " .. result)
					return
				end
				table.insert(retargeted, entry)
			end
		end

		-- Step 7: Batch-fetch all PR bodies + find merged ancestors via single GraphQL query
		local current_pr_set = {}
		local pr_numbers = {}
		for _, e in ipairs(stack) do
			if e.pr_number then
				current_pr_set[e.pr_number] = true
				table.insert(pr_numbers, e.pr_number)
			end
		end

		local body_cache = {}
		if #pr_numbers > 0 then
			for _, num in ipairs(pr_numbers) do
				body_cache[num] = shell("gh pr view " .. num .. " --json body --jq '.body' 2>/dev/null")
			end
		end

		-- Find merged ancestors from first existing PR's body
		local merged_ancestors = {}
		for _, e in ipairs(stack) do
			if e.pr_number and body_cache[e.pr_number] then
				local existing_body = body_cache[e.pr_number]
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
				break
			end
		end

		-- Batch-verify merged state via GraphQL
		local ancestor_nums = {}
		for num in pairs(merged_ancestors) do
			table.insert(ancestor_nums, num)
		end
		local merged_list = {}
		if #ancestor_nums > 0 and owner and repo_name then
			local fields = {}
			for i, num in ipairs(ancestor_nums) do
				table.insert(fields, string.format("anc%d: pullRequest(number: %d) { number state }", i, num))
			end
			local query = string.format(
				'query { repository(owner: "%s", name: "%s") { %s } }',
				owner,
				repo_name,
				table.concat(fields, " ")
			)
			local gql_out = shell("gh api graphql -f query='" .. query:gsub("'", "'\\''") .. "' 2>/dev/null")
			for num, state in gql_out:gmatch('"number":(%d+).-"state":"(%w+)"') do
				if state == "MERGED" then
					table.insert(merged_list, tonumber(num))
				end
			end
			table.sort(merged_list)
		end

		-- Step 8: Build stack content and update all PR bodies
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
				local existing_body = body_cache[e.pr_number] or ""
				local new_body = splice_stack_section(existing_body, stack_content)
				local f = io.open(tmpfile, "w")
				f:write(new_body)
				f:close()
				shell("gh pr edit " .. e.pr_number .. " --body-file '" .. tmpfile .. "' 2>&1")
			end
		end
		os.remove(tmpfile)

		flash("Stacked PRs: " .. #created .. " new, " .. #retargeted .. " retargeted")
	end

	config.action("push-with-descendants", push_with_descendants, {
		desc = "Push revision with descendants",
		scope = "revisions",
		key = "P",
	})

	config.action("push-with-descendants-bare", push_with_descendants_bare, {
		desc = "Push revision with descendants bare",
		scope = "revisions",
		key = "alt+p",
	})

	config.action("new-before", new_before, {
		desc = "Create new changeset before this revision",
		scope = "revisions",
		key = "alt+b",
	})

	config.action("new-after", new_after, {
		desc = "Create new changeset after this revision",
		scope = "revisions",
		key = "alt+a",
	})

	config.action("stacked-pr", stacked_pr, {
		desc = "Create stacked PR starting from this revision",
		scope = "revisions",
		key = "alt+s",
	})

	config.action("copy-change-id", ctc, {
		desc = "copy change id to clipboard",
		scope = "revisions",
		key = "Y",
	})

	config.action("command-palette", function()
		local choice = choose(
			"push-with-descendants",
			"push-with-descendants-bare",
			"new-before",
			"new-after",
			"stacked-pr",
			"copy-change-id"
		)
		if not choice then
			return
		end
		local commands = {
			["push-with-descendants"] = push_with_descendants,
			["push-with-descendants-bare"] = push_with_descendants_bare,
			["new-before"] = new_before,
			["new-after"] = new_after,
			["stacked-pr"] = stacked_pr,
			["copy-change-id"] = ctc,
		}
		if commands[choice] then
			commands[choice]()
		end
	end, {
		desc = "command palette",
		scope = "revisions",
		key = "\\",
	})
end
