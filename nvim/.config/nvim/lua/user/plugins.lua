local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
	"nvim-lua/popup.nvim", -- An implementation of the Popup API from vim in Neovim
	"nvim-lua/plenary.nvim", -- Useful lua functions used ny lots of plugins
	"windwp/nvim-autopairs", -- Autopairs, integrates with both cmp and treesitter
	"numToStr/Comment.nvim", -- Easily comment stuff
	{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	"terrortylor/nvim-comment", -- comment stuff the good way
	"akinsho/toggleterm.nvim", -- toggleterminal from inside nvim
	"kyazdani42/nvim-web-devicons",
	{ "kyazdani42/nvim-tree.lua", commit = "bdb6d4a25410da35bbf7ce0dbdaa8d60432bc243" },
	"akinsho/bufferline.nvim",
	"moll/vim-bbye",
	"nvim-lualine/lualine.nvim",
	"arkav/lualine-lsp-progress",
	{ "goolord/alpha-nvim", commit = "ef27a59e5b4d7b1c2fe1950da3fe5b1c5f3b4c94" },
	"folke/which-key.nvim",
	{ "folke/trouble.nvim" },

	-- Colorschemes
	"folke/tokyonight.nvim",
	{ "ellisonleao/gruvbox.nvim" },
	"Mofiqul/dracula.nvim",
	"rebelot/kanagawa.nvim",
	"EdenEast/nightfox.nvim",
	"jacoborus/tender.vim",
	"rmehri01/onenord.nvim",
	"shaunsingh/nord.nvim",
	{
		"catppuccin/nvim",
		name = "catppuccin",
		version = "v0.2",
	},
	{ "rose-pine/neovim", name = "rose-pine" },
	-- cmp plugins
	"hrsh7th/nvim-cmp", -- The completion plugin
	"hrsh7th/cmp-buffer", -- buffer completions
	"hrsh7th/cmp-path", -- path completions
	"hrsh7th/cmp-cmdline", -- cmdline completions
	"hrsh7th/cmp-nvim-lsp-signature-help", -- signature help completions
	"saadparwaiz1/cmp_luasnip", -- snippet completions
	"hrsh7th/cmp-nvim-lsp",

	"folke/neodev.nvim",

	-- snippets
	"L3MON4D3/LuaSnip", --snippet engine
	"rafamadriz/friendly-snippets", -- a bunch of snippets to use

	-- LSP
	"neovim/nvim-lspconfig", -- enable LSP
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",
	"tamago324/nlsp-settings.nvim", -- language server settings defined in json for
	{
		"stevearc/conform.nvim",
		-- event = { "BufReadPre", "BufNewFile" },
		config = function()
			local formatting_config = require("user.formatting")
			require("conform").setup(formatting_config)
		end,
	},
	"MunifTanjim/eslint.nvim",
	{
		-- breadcrumbs
		"SmiteshP/nvim-navic",
		dependencies = "neovim/nvim-lspconfig",
	}, -- Lua
	{
		"SmiteshP/nvim-gps",
		dependencies = "nvim-treesitter/nvim-treesitter",
	},
	"simrat39/rust-tools.nvim",
	"nanotee/sqls.nvim",
	"b0o/schemastore.nvim",
	"ray-x/go.nvim",
	"ray-x/guihua.lua",
	-- Telescope
	-- use({ "nvim-telescope/telescope.nvim", commit = "d96eaa914aab6cfc4adccb34af421bdd496468b0" })
	{ "nvim-telescope/telescope.nvim", version = "0.1.4" },
	{ "ThePrimeagen/harpoon", branch = "master" },
	{ "zbirenbaum/copilot.lua", dependencies = "zbirenbaum/copilot-cmp" },
	{
		"zbirenbaum/copilot-cmp",
		config = function()
			require("copilot_cmp").setup()
		end,
	},
	-- Treesitter
	-- use {
	--     "nvim-treesitter/nvim-treesitter",
	--     run = ":TSUpdate",
	-- }
	{
		"nvim-treesitter/nvim-treesitter",
		build = function()
			require("nvim-treesitter.install").update({ with_sync = true })
		end,
	},
	"nvim-treesitter/nvim-treesitter-context",
	"nvim-treesitter/playground",
	"nvim-treesitter/nvim-treesitter-textobjects",
	"JoosepAlviste/nvim-ts-context-commentstring",
	{
		"ckolkey/ts-node-action",
		dependencies = { "nvim-treesitter" },
		config = function()
			require("ts-node-action").setup({})
		end,
	},
	"windwp/nvim-ts-autotag",
	"theprimeagen/jvim.nvim",

	-- Git
	"lewis6991/gitsigns.nvim",
	{
		"ruifm/gitlinker.nvim",
		dependencies = "nvim-lua/plenary.nvim",
	},
	"tpope/vim-fugitive",
	"tpope/vim-rhubarb",
	"ThePrimeagen/git-worktree.nvim",

	-- winbar
	{ "fgheng/winbar.nvim" },
	-- Jest
	-- {
	-- 	"David-Kunz/jester",
	-- 	ft = { "javascript", "typescript" },
	-- 	config = {
	-- 		function()
	-- 			local jester_status_ok, jester = pcall(require, "jester")
	-- 			if not jester_status_ok then
	-- 				return
	-- 			end
	-- 			jester.setup({
	-- 				path_to_jest_run = "./node_modules/.bin/jest", -- used to run tests
	-- 				path_to_jest_debug = "./node_modules/.bin/jest", -- used for debugging
	-- 			})
	-- 		end,
	-- 	},
	-- },
	-- Debugging
	{
		"mfussenegger/nvim-dap",
		lazy = true,
		event = "BufReadPre",
		dependencies = {
			{ "Pocco81/DAPInstall.nvim", commit = "24923c3819a450a772bb8f675926d530e829665f" },
			"theHamsta/nvim-dap-virtual-text",
			"rcarriga/nvim-dap-ui",
			"mfussenegger/nvim-dap-python",
			"nvim-telescope/telescope-dap.nvim",
			{ "leoluz/nvim-dap-go" },
			{ "jbyuki/one-small-step-for-vimkind" },
		},
		config = function()
			require("user.dap").setup()
		end,
	},

	-- taking notes
	{
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
	},
	"ElPiloto/telescope-vimwiki.nvim",
	"mg979/vim-visual-multi",

	"jbyuki/venn.nvim",

	"ThePrimeagen/vim-be-good",
	"tpope/vim-surround",
	"mbbill/undotree",
	{ "mzlogin/vim-markdown-toc" },
	{ "Darazaki/indent-o-matic" },
	{ "xiyaowong/transparent.nvim" },
	{ "eandrju/cellular-automaton.nvim" },
	{ "laytan/cloak.nvim" },
	{ "jellydn/hurl.nvim", dependencies = { "MunifTanjim/nui.nvim" } },
}

local opts = {}
require("lazy").setup(plugins, opts)
