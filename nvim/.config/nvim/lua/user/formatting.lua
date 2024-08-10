return {
	formatters_by_ft = {
		javascript = { "prettier" },
		typescript = { "prettier" },
		javascriptreact = { "prettier" },
		typescriptreact = { "prettier" },
		svelte = { "prettier" },
		html = { "prettier" },
		css = { "prettier" },
		json = { "prettier" },
		yaml = { "prettier" },
		markdown = { "prettier" },
		lua = { "stylua" },
		python = { "isort", "black" },
		go = { "gofmt", "goimports" },
		rust = { "rustfmt" },
		zig = { "zigfmt" }
	},
	-- @type table
	formatters = {
		zigfmt = {
			cmd = "zig",
			args = { "fmt", "--stdin", "$FILENAME" },
			stdin = true,
		},
	},
	-- format_on_save = {
	-- 	false,
	-- 	lsp_fallback = true,
	-- 	async = false,
	-- 	timeout_ms = 500,
	-- },
}
