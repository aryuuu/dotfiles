return {
	"nvim-treesitter/nvim-treesitter-context",
	config = function()
		require("treesitter-context").setup({
			enable = true, -- Enable this plugin (can be enabled/disabled later via commands)
			max_lines = 0, -- How many lines the window should span. 0 = no limit
			trim_scope = "outer", -- Which context lines to discard if max_lines is exceeded
			patterns = {
				default = {
					"class",
					"function",
					"method",
					"for",
					"while",
					"if",
					"switch",
					"case",
				},
			},
			exact_patterns = {
				-- rust = true, -- Example: treat rust patterns as Lua regex
			},
			zindex = 20, -- Z-index of the context window
			mode = "cursor", -- Line used to calculate context. 'cursor' or 'topline'
			separator = nil, -- Separator character (e.g. "-") or nil for none
		})
	end,
}
