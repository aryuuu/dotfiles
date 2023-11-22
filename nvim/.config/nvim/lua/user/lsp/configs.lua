local status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not status_ok then
	return
end

-- disable this when not developing plugins, takes a lot of resources
-- require("neodev").setup()

local lspconfig = require("lspconfig")

local servers = {
	-- "bash-language-server",
	-- "clangd",
	-- "docker-compose-language-service",
	-- "dockerfile-language-server",
	-- "eslint-lsp",
	-- "gopls",
	-- "lua-language-server",
	-- "python-lsp-server",
	-- "rust-analyzer",
	-- "sqls",
	-- "typescript-language-server",

	"bashls",
	"clangd",
	"dockerls",
	"pyright",
	"rust_analyzer",
	"cmake",
	"lua_ls",
	"tsserver",
	"jsonls",
	"gopls",
	"eslint",
	"yamlls",
	-- "sqls",
	"sqlls",
	"terraformls",
	"jdtls",
	"zls",
	"svelte",
	"ocamllsp",
	"nil_ls",
}

-- mason_lspconfig.setup({
-- 	ensure_installed = servers,
-- })

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
