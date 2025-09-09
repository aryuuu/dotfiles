local opts = {
	settings = {
		json = {
			schemas = require("schemastore").json.schemas(),
			validate = { enable = true },
		},
		yaml = {
			schemas = {
				["/home/fatt/project/xendit/xendit-json-schema/schemas/helm-chart.json"] = {
					"**/.deployment/helm/**/*.yaml",
					"**/.deployment/helm/**/*.yml",
				},
				-- ["~/project/xendit/xendit-infrastructure/terraform/xendit/schemas/input-aws-route53-schema.json"] = {
				-- 	"**/input-r53*.yaml",
				-- 	"**/input-r53*.yml",
				-- },
				-- ["/home/fatt/project/xendit/xendit-json-schema/schema/buddyworks.json"] = { "**/.buddy/*.yaml" },
				-- ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*"
			},
		},
	},
	setup = {
		commands = {
			Format = {
				function()
					vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line("$"), 0 })
				end,
			},
		},
	},
}

return opts
