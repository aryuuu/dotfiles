local status_ok, gitsigns = pcall(require, "gitsigns")
if not status_ok then
	return
end

-- add hl
vim.api.nvim_set_hl(0, "GitSignsAdd", { link = "@diff.plus" })
vim.api.nvim_set_hl(0, "GitSignsAddLn", { link = "@diff.plus" })
vim.api.nvim_set_hl(0, "GitSignsAddNr", { link = "@diff.plus" })

-- change hl
vim.api.nvim_set_hl(0, "GitSignsChange", { link = "@diff.delta" })
vim.api.nvim_set_hl(0, "GitSignsChangeLn", { link = "@diff.delta" })
vim.api.nvim_set_hl(0, "GitSignsChangeNr", { link = "@diff.delta" })

-- changedelete hl
vim.api.nvim_set_hl(0, "GitSignsChangedelete", { link = "@diff.delta" })
vim.api.nvim_set_hl(0, "GitSignsChangedeleteLn", { link = "@diff.delta" })
vim.api.nvim_set_hl(0, "GitSignsChangedeleteNr", { link = "@diff.delta" })

-- delete hl
vim.api.nvim_set_hl(0, "GitSignsDelete", { link = "@diff.minus" })
vim.api.nvim_set_hl(0, "GitSignsDeleteLn", { link = "@diff.minus" })
vim.api.nvim_set_hl(0, "GitSignsDeleteNr", { link = "@diff.minus" })

-- topdelete hl
vim.api.nvim_set_hl(0, "GitSignsTopdelete", { link = "@diff.minus" })
vim.api.nvim_set_hl(0, "GitSignsTopdeleteLn", { link = "@diff.minus" })
vim.api.nvim_set_hl(0, "GitSignsTopdeleteNr", { link = "@diff.minus" })

gitsigns.setup({
	signs = {
		add = { text = "+" },
		-- add = { text = "┃" },
		-- change = { text = "┃" },
		change = { text = "~" },
		delete = { text = "-" },
		topdelete = { text = "--" },
		changedelete = { text = "~-" },
		untracked = { text = "┆" },
	},
	-- signs = {
	--     add = { hl = "GitSignsAdd", text = "+", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
	--     change = { hl = "GitSignsChange", text = "~", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
	--     delete = { hl = "GitSignsDelete", text = "-", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
	--     topdelete = { hl = "GitSignsDelete", text = "--", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
	--     changedelete = { hl = "GitSignsChange", text = "~-", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
	-- },
	signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
	numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
	linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
	word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
	watch_gitdir = {
		interval = 1000,
		follow_files = true,
	},
	attach_to_untracked = true,
	current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
	current_line_blame_opts = {
		virt_text = true,
		virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
		delay = 1000,
		ignore_whitespace = false,
	},
	-- current_line_blame_formatter_opts = {
	--     relative_time = false,
	-- },
	sign_priority = 6,
	update_debounce = 100,
	status_formatter = nil, -- Use default
	max_file_length = 40000,
	preview_config = {
		-- Options passed to nvim_open_win
		border = "single",
		style = "minimal",
		relative = "cursor",
		row = 0,
		col = 1,
	},
})
