local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
	return
end

local lspconfig = require("lspconfig")

local servers = {
	"bashls",
	"clangd",
	"dockerls",
	"pyright",
	"rust_analyzer",
	"cmake",
	"sumneko_lua",
	-- "lua_ls",
	"tsserver",
	"jsonls",
	"gopls",
	"eslint",
	"yamlls",
	"sqls",
	"terraformls",
	"jdtls",
}

lsp_installer.setup({
	ensure_installed = servers,
})

local function dump(o)
	if type(o) == "table" then
		local s = "{ "
		for k, v in pairs(o) do
			if type(k) ~= "number" then
				k = '"' .. k .. '"'
			end
			s = s .. "[" .. k .. "] = " .. dump(v) .. ","
		end
		return s .. "} "
	else
		return tostring(o)
	end
end

for _, server in pairs(servers) do
	local opts = {
		on_attach = require("user.lsp.handlers").on_attach,
		capabilities = require("user.lsp.handlers").capabilities,
	}
	local has_custom_opts, server_custom_opts = pcall(require, "user.lsp.settings." .. server)
	if has_custom_opts then
		opts = vim.tbl_deep_extend("force", opts, server_custom_opts)
		-- dump(print("opts: ", dump(opts)))
	end
	lspconfig[server].setup(opts)
end
