require("hurl").setup({
	-- Toggle debugging information
	debug = false, -- If true, logs will be saved at ~/.local/state/nvim/hurl.nvim.log

	-- Set the display mode for the response: 'split' or 'popup'
	mode = "split",

	-- Split settings
	split_position = "bottom",
	split_size = "50%",

	-- Popup settings
	popup_position = "50%",
	popup_size = {
		width = 80,
		height = 40,
	},

	-- Default environment file name
	env_file = {
		"vars.env",
	},

	-- Specify formatters for different response types
	formatters = {
		json = { "jq" }, -- Uses jq to format JSON responses
		html = {
			"prettier", -- Uses prettier to format HTML responses
			"--parser",
			"html",
		},
	},
})
