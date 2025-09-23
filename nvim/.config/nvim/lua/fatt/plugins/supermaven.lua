return {
  {
	'supermaven-inc/supermaven-nvim',
	config = function()
	  require("supermaven-nvim").setup({
		keymaps = {
		  accept_suggestion = "<M-o>",
		  clear_suggestion = "<C-]>",
		  accept_word = "<C-j>",
		},
		ignore_filetypes = { cpp = false },
		color = {
		  suggestion_color = "#ffffff",
		  cterm = 244,
		},
		log_level = "info", -- set to "off" to disable logging completely
		disable_inline_completion = false, -- disables inline completion for use with cmp
		disable_keymaps = false, -- disables built in keymaps for more manual control
	  })
	end
  }
}
