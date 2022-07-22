-- local navic = require("nvim-navic")
local navic_status_ok, navic = pcall(require, "nvim-navic")
if not navic_status_ok then
	return
end

-- require("lspconfig").clangd.setup {
--     on_attach = function(client, bufnr)
--         navic.attach(client, bufnr)
--     end
-- }

navic.setup()
