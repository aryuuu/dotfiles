return {
	formatters_by_ft = {
		css = { "prettier" },
		go = { "gofmt", "goimports" },
		html = { "prettier" },
		javascript = { "prettier" },
		javascriptreact = { "prettier" },
		json = { "prettier" },
		lua = { "stylua" },
		markdown = { "prettier" },
		nix = { "nixpkgs_fmt" },
		python = { "isort", "black" },
		rust = { "rustfmt" },
		svelte = { "prettier" },
		typescript = { "prettier" },
		terraform = { "terrafmt" },
		typescriptreact = { "prettier" },
		yaml = { "prettier" },
		zig = { "zigfmt" },
	},
	-- @type table
	formatters = {
		zigfmt = {
			command = "zig",
			args = { "fmt" },
			stdin = false,
			require_cwd = false,
		},
		terrafmt = {
			command = "terraform",
			args = { "fmt", "-" },
			stdin = false,
			require_cwd = false,
		},
	},
	-- format_on_save = {
	-- 	false,
	-- 	lsp_fallback = true,
	-- 	async = false,
	-- 	timeout_ms = 500,
	-- },
}
