return {
	{
		"numToStr/Comment.nvim",
		event = "InsertEnter",
	}, -- Easily comment stuff
	{
		"terrortylor/nvim-comment",
		-- event = "InsertEnter",
		config = function()
			local comment = require('nvim_comment')
			comment.setup({
				comment_empty = false
			})
			vim.keymap.set("n", "<C-_>", ":CommentToggle<CR>", {})
			vim.keymap.set("i", "<C-_>", "<Esc>:CommentToggle<CR>i", {})
			vim.keymap.set("v", "<C-_>", ":'<,'>CommentToggle<CR>", {})
		end,
	}, -- comment stuff the good way
}
