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
	{
		"nvim-lua/plenary.nvim",
		lazy = true,
	}, -- Useful lua functions used ny lots of plugins
	{
		"windwp/nvim-autopairs",
		event = { "InsertEnter" },
	}, -- Autopairs, integrates with both cmp and treesitter
	{
		"numToStr/Comment.nvim",
		event = "InsertEnter",
	}, -- Easily comment stuff
	{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	{
		"terrortylor/nvim-comment",
		event = "InsertEnter",
	}, -- comment stuff the good way
	"akinsho/toggleterm.nvim", -- toggleterminal from inside nvim
	{
		"kyazdani42/nvim-web-devicons",
		lazy = true,
	},
	{
		"kyazdani42/nvim-tree.lua",
		commit = "bdb6d4a25410da35bbf7ce0dbdaa8d60432bc243",
		keys = "<leader>e",
	},
	"akinsho/bufferline.nvim",
	"moll/vim-bbye",
	{
		"nvim-lualine/lualine.nvim",
		event = { "BufReadPre", "BufNewFile" },
	},
	"arkav/lualine-lsp-progress",
	"folke/which-key.nvim",
	{ "folke/trouble.nvim" },

	-- Colorschemes
	"folke/tokyonight.nvim",
	{ "ellisonleao/gruvbox.nvim", lazy = true },
	{ "Mofiqul/dracula.nvim", lazy = true },
	{ "rebelot/kanagawa.nvim", lazy = true },
	{ "EdenEast/nightfox.nvim", lazy = true },
	{ "jacoborus/tender.vim", lazy = true },
	"rmehri01/onenord.nvim",
	{ "shaunsingh/nord.nvim", lazy = true },
	{
		"catppuccin/nvim",
		name = "catppuccin",
		version = "v0.2",
		lazy = true,
	},
	{
		"rose-pine/neovim",
		name = "rose-pine",
		lazy = true,
	},
	-- cmp plugins
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter", -- load cmp on InsertEnter
	}, -- The completion plugin
	{
		"hrsh7th/cmp-buffer",
		event = "InsertEnter", -- load cmp on InsertEnter
	}, -- buffer completions
	{
		"hrsh7th/cmp-path",
		event = "InsertEnter", -- load cmp on InsertEnter
	}, -- path completions
	{
		"hrsh7th/cmp-cmdline",
		event = "InsertEnter", -- load cmp on InsertEnter
	}, -- cmdline completions
	{
		"hrsh7th/cmp-nvim-lsp-signature-help",
		event = "InsertEnter", -- load cmp on InsertEnter
	}, -- signature help completions
	{
		"saadparwaiz1/cmp_luasnip",
		event = "InsertEnter", -- load cmp on InsertEnter
	}, -- snippet completions
	{
		"hrsh7th/cmp-nvim-lsp",
		event = "InsertEnter", -- load cmp on InsertEnter
	},

	"folke/neodev.nvim",

	-- snippets
	{
		"L3MON4D3/LuaSnip",
		event = "InsertEnter",
	}, --snippet engine
	{
		"rafamadriz/friendly-snippets",
		event = "InsertEnter",
	}, -- a bunch of snippets to use

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
		event = "BufRead",
	},
	"simrat39/rust-tools.nvim",
	"nanotee/sqls.nvim",
	"b0o/schemastore.nvim",
	"ray-x/go.nvim",
	"ray-x/guihua.lua",
	-- {
	-- 	"nvim-java/nvim-java",
	-- 	dependencies = {
	-- 		"nvim-java/lua-async-await",
	-- 		"nvim-java/nvim-java-core",
	-- 		"nvim-java/nvim-java-test",
	-- 		"nvim-java/nvim-java-dap",
	-- 		"MunifTanjim/nui.nvim",
	-- 		"neovim/nvim-lspconfig",
	-- 		"mfussenegger/nvim-dap",
	-- 		{
	-- 			"williamboman/mason.nvim",
	-- 			opts = {
	-- 				registries = {
	-- 					"github:nvim-java/mason-registry",
	-- 					"github:mason-org/mason-registry",
	-- 				},
	-- 			},
	-- 		},
	-- 	},
	-- },
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
	{
		"windwp/nvim-ts-autotag",
		event = { "InsertEnter" },
	},
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
			vim.g.vimwiki_global_ext = 0
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
	{ "eandrju/cellular-automaton.nvim", lazy = true },
	{ "laytan/cloak.nvim" },
	{ "jellydn/hurl.nvim", dependencies = { "MunifTanjim/nui.nvim" } },
}

local opts = {
	defaults = {},
}

require("lazy").setup(plugins, opts)
