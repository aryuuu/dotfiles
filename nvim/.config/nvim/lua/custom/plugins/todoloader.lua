local function read_file(file)
	local f = io.open(file, "r")
	if f then
		local content = f:read("*all")
		f:close()
		return content
	end
end

local function load_todo()
	local current_date = os.date('%Y-%m-%d')

	local dates = {}
	local files = vim.fn.readdir(vim.fn.expand('~/.vimwiki/diary'))
	for _, file in ipairs(files) do
		local clean_file = file:gsub('.md', '')
		local year, month, day = clean_file:match('(%d%d%d%d)%-(%d%d)%-(%d%d)$')

		local date
		if year and month and day then
			table.insert(dates, clean_file)
		end
		table.sort(dates, function(a, b)
			return a > b
		end)
	end

	local closest_date = dates[1]
	local content = read_file(vim.fn.expand('~/.vimwiki/diary/' .. closest_date .. '.md'))
	print(content)
	-- vim.api.nvim_buf_set_lines(0, 0, 0, false, content)

end

load_todo()
