local status_ok, mason = pcall(require, "mason")
if not status_ok then
	return
end

mason.setup({
    ui = {
        icons = {
            package_installed = "✓"
        }
    }
})

local status_mason_lspconfig_ok, mason_lspconfig = pcall(require, "mason-lspconfig")

-- if not status_mason_lspconfig_ok then
-- 	return
-- end
-- mason_lspconfig.setup({
--     ensure_installed = { "lua_ls" },
-- })
