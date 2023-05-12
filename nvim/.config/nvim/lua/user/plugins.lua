local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

-- Install your plugins here
return packer.startup(function(use)
	-- My plugins here
	use("wbthomason/packer.nvim") -- Have packer manage itself
	use("nvim-lua/popup.nvim") -- An implementation of the Popup API from vim in Neovim
	use("nvim-lua/plenary.nvim") -- Useful lua functions used ny lots of plugins
	use("windwp/nvim-autopairs") -- Autopairs, integrates with both cmp and treesitter
	use("numToStr/Comment.nvim") -- Easily comment stuff
	use("ahmedkhalf/project.nvim") -- switch between projects
	use("jvgrootveld/telescope-zoxide")
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
	use("terrortylor/nvim-comment") -- comment stuff the good way
	use("akinsho/toggleterm.nvim") -- toggleterminal from inside nvim
	use("kyazdani42/nvim-web-devicons")
	use({ "kyazdani42/nvim-tree.lua", commit = "bdb6d4a25410da35bbf7ce0dbdaa8d60432bc243" })
	use("akinsho/bufferline.nvim")
	use("moll/vim-bbye")
	use("nvim-lualine/lualine.nvim")
	use("arkav/lualine-lsp-progress")
	use({ "goolord/alpha-nvim", commit = "ef27a59e5b4d7b1c2fe1950da3fe5b1c5f3b4c94" })
	use("folke/which-key.nvim")

	-- Colorschemes
	-- use "lunarvim/colorschemes" -- A bunch of colorschemes you can try out
	use("lunarvim/darkplus.nvim")
	use("folke/tokyonight.nvim")
	use({ "ellisonleao/gruvbox.nvim" })
	use("Mofiqul/dracula.nvim")
    use ("rebelot/kanagawa.nvim")
	use("EdenEast/nightfox.nvim")
	use("jacoborus/tender.vim")
	use("rmehri01/onenord.nvim")
	use("shaunsingh/nord.nvim")
	use({
		"catppuccin/nvim",
		as = "catppuccin",
		tag = "v0.2",
	})
	-- cmp plugins
	use("hrsh7th/nvim-cmp") -- The completion plugin
	use("hrsh7th/cmp-buffer") -- buffer completions
	use("hrsh7th/cmp-path") -- path completions
	use("hrsh7th/cmp-cmdline") -- cmdline completions
	use("hrsh7th/cmp-nvim-lsp-signature-help") -- signature help completions
	use("saadparwaiz1/cmp_luasnip") -- snippet completions
	use("hrsh7th/cmp-nvim-lsp")

	-- snippets
	use("L3MON4D3/LuaSnip") --snippet engine
	use("rafamadriz/friendly-snippets") -- a bunch of snippets to use

	-- LSP
	use("neovim/nvim-lspconfig") -- enable LSP
	use("williamboman/mason.nvim")
	use("williamboman/mason-lspconfig.nvim")
	use("tamago324/nlsp-settings.nvim") -- language server settings defined in json for
	use("jose-elias-alvarez/null-ls.nvim") -- for formatters and linters
	use("MunifTanjim/eslint.nvim")
	use({ -- breadcrumbs
		"SmiteshP/nvim-navic",
		requires = "neovim/nvim-lspconfig",
	}) -- Lua
	use({
		"SmiteshP/nvim-gps",
		requires = "nvim-treesitter/nvim-treesitter",
	})
	use("simrat39/rust-tools.nvim")
	use("nanotee/sqls.nvim")
    use("b0o/schemastore.nvim")
	-- use("nvim-lua/lsp-status.nvim")
	-- Comment
	-- Telescope
	use({ "nvim-telescope/telescope.nvim", commit = "d96eaa914aab6cfc4adccb34af421bdd496468b0" })
	use { "LinArcX/telescope-env.nvim" }
	use({ "ThePrimeagen/harpoon" })

	-- Treesitter
	-- use {
	--     "nvim-treesitter/nvim-treesitter",
	--     run = ":TSUpdate",
	-- }
	use({
		"nvim-treesitter/nvim-treesitter",
		run = function()
			require("nvim-treesitter.install").update({ with_sync = true })
		end,
	})
	use("nvim-treesitter/nvim-treesitter-context")
	use("nvim-treesitter/playground")
    use("nvim-treesitter/nvim-treesitter-textobjects")
	use("JoosepAlviste/nvim-ts-context-commentstring")
    use({
        'ckolkey/ts-node-action',
         requires = { 'nvim-treesitter' },
         config = function()
             require("ts-node-action").setup({})
         end
    })

	-- Git
	use("lewis6991/gitsigns.nvim")
	use({
		"ruifm/gitlinker.nvim",
		requires = "nvim-lua/plenary.nvim",
	})
	use({
		"pwntester/octo.nvim",
		requires = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
			"kyazdani42/nvim-web-devicons",
		},
		-- config = function ()
		--   require"octo".setup()
		-- end
	})
	use("tpope/vim-fugitive")
	use("ThePrimeagen/git-worktree.nvim")

	-- winbar
	use({ "fgheng/winbar.nvim" })
	-- Jest
	use({
		"David-Kunz/jester",
		ft = { "javascript", "typescript" },
		-- config = {
		-- 	function()
		-- 		local jester_status_ok, jester = pcall(require, "jester")
		-- 		if not jester_status_ok then
		-- 			return
		-- 		end
		-- 		jester.setup({
		-- 			path_to_jest_run = "./node_modules/jest", -- used to run tests
		-- 			path_to_jest_debug = "./node_modules/jest", -- used for debugging
		-- 		})
		-- 	end,
		-- },
	})
	-- Debugging
	use({
		"mfussenegger/nvim-dap",
		opt = true,
		event = "BufReadPre",
		module = { "dap" },
		wants = { "nvim-dap-virtual-text", "DAPInstall.nvim", "nvim-dap-ui", "nvim-dap-python", "which-key.nvim" },
		requires = {
			{ "Pocco81/DAPInstall.nvim", commit = "24923c3819a450a772bb8f675926d530e829665f" },
			"theHamsta/nvim-dap-virtual-text",
			"rcarriga/nvim-dap-ui",
			"mfussenegger/nvim-dap-python",
			"nvim-telescope/telescope-dap.nvim",
			{ "leoluz/nvim-dap-go", module = "dap-go" },
			{ "jbyuki/one-small-step-for-vimkind", module = "osv" },
		},
		config = function()
			require("user.dap").setup()
		end,
	})

	-- taking notes
	use("oberblastmeister/neuron.nvim")
	use({
		"vimwiki/vimwiki",
		config = function()
			vim.g.vimwiki_list = {
				{
					path = "~/.vimwiki/",
					syntax = "markdown",
					ext = ".md",
				},
			}
		end,
	})
	use("ElPiloto/telescope-vimwiki.nvim")
	use("mg979/vim-visual-multi")

	-- cheatsheet
	use("RishabhRD/popfix")
	use("RishabhRD/nvim-cheat.sh")

	use("tami5/sqlite.lua")
	use("nvim-telescope/telescope-cheat.nvim")

	use("jbyuki/venn.nvim")

	use("ThePrimeagen/vim-be-good")
	use("tpope/vim-surround")
	use("mbbill/undotree")
    use {"ellisonleao/glow.nvim"}
    use {"mzlogin/vim-markdown-toc"}
    use {"Darazaki/indent-o-matic"}
	use { 'smithbm2316/centerpad.nvim' }
	use { 'xiyaowong/transparent.nvim' }


	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
