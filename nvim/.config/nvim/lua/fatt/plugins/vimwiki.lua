return {
	{
		"vimwiki/vimwiki",
		config = function()
			vim.g.vimwiki_list = {
				{
					path = "~/.vimwiki/",
					syntax = "markdown",
					ext = ".md",
				},
			}
			vim.g.vimwiki_global_ext = 0

			vim.keymap.set("n", "<leader>ni", "<cmd>VimwikiIndex 1<cr>", {})
			vim.keymap.set("n", "<leader>nI", "<cmd>VimwikiDiaryIndex 1<cr>", {})
			vim.keymap.set("n", "<leader>nd", "<cmd>VimwikiMakeDiaryNote 1<cr>", {})
		end,
	},
}
