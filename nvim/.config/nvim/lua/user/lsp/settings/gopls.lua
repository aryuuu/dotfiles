return {
	cmd = { "gopls", "serve" },
	settings = {
		gopls = {
			analyses = {
				unusedparams = true,
			},
			staticcheck = true,
			directoryFilters = {
				"-**/postgres-data",
			},
		},
	},
}
