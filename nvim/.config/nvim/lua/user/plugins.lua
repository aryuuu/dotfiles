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
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		opts = {
			styles = {},
			bigfile = { enabled = true },
			notifier = { enabled = false },
			quickfile = { enabled = true },
			statuscolumn = { enabled = false },
			words = { enabled = false },
		},
	},
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
	{ "nvim-telescope/telescope-fzf-writer.nvim" },
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
		-- keys = "<leader>e",
	},
	{
		"stevearc/oil.nvim",
		---@module 'oil'
		---@type oil.SetupOpts
		opts = {},
		-- Optional dependencies
		dependencies = { { "echasnovski/mini.icons", opts = {} } },
		-- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
	},
	"akinsho/bufferline.nvim",
	"moll/vim-bbye",
	{
		"nvim-lualine/lualine.nvim",
		event = { "BufReadPre", "BufNewFile" },
	},
	"arkav/lualine-lsp-progress",
	{ "folke/trouble.nvim" },
	{ "tanvirtin/monokai.nvim" },
	-- Colorschemes
	"folke/tokyonight.nvim",
	{
		"ellisonleao/gruvbox.nvim",
		lazy = false,
		keys = { "<leader>sC" },
	},
	{
		"Mofiqul/dracula.nvim",
		lazy = false,
		keys = { "<leader>sC" },
	},
	{
		"rebelot/kanagawa.nvim",
		lazy = false,
		keys = { "<leader>sC" },
	},
	{
		"EdenEast/nightfox.nvim",
	},
	{
		"jacoborus/tender.vim",
		lazy = false,
		keys = { "<leader>sC" },
	},
	"rmehri01/onenord.nvim",
	{ "shaunsingh/nord.nvim" },
	{
		"catppuccin/nvim",
		name = "catppuccin",
		version = "v0.2",
		lazy = false,
		keys = { "<leader>sC" },
	},
	{
		"rose-pine/neovim",
		name = "rose-pine",
		lazy = false,
		keys = { "<leader>sC" },
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
	"simrat39/rust-tools.nvim",
	"nanotee/sqls.nvim",
	"b0o/schemastore.nvim",
	"ray-x/guihua.lua",
	-- Telescope
	{
		"nvim-telescope/telescope.nvim",
		-- version = "0.1.8",
		commit = "2eca9ba22002184ac05eddbe47a7fe2d5a384dfc",
		dependencies = {
			{
				"nvim-telescope/telescope-live-grep-args.nvim",
				-- This will not install any breaking changes.
				-- For major updates, this must be adjusted manually.
				version = "^1.0.0",
			},
		},
	},
	{ "ThePrimeagen/harpoon", branch = "master" },
	-- AIs
	{ "zbirenbaum/copilot.lua", dependencies = "zbirenbaum/copilot-cmp" },
	{
		"zbirenbaum/copilot-cmp",
		config = function()
			require("copilot_cmp").setup()
		end,
	},
	{ "supermaven-inc/supermaven-nvim" },
	{
	  "yetone/avante.nvim",
	  event = "VeryLazy",
	  lazy = false,
	  version = false, -- Set this to "*" to always pull the latest release version, or set it to false to update to the latest code changes.
	  opts = {
		-- add any opts here
		provider = "deepseek",
		vendors = {
		  deepseek = {
			__inherited_from = "openai",
			api_key_name = "DEEPSEEK_API_KEY",
			endpoint = "https://api.deepseek.com",
			model = "deepseek-coder",
		  },
		},
	  },
	  -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
	  build = "make",
	  -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
	  dependencies = {
		"stevearc/dressing.nvim",
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		--- The below dependencies are optional,
		"echasnovski/mini.pick", -- for file_selector provider mini.pick
		"nvim-telescope/telescope.nvim", -- for file_selector provider telescope
		"hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
		"ibhagwan/fzf-lua", -- for file_selector provider fzf
		"nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
		"zbirenbaum/copilot.lua", -- for providers='copilot'
		{
		  -- support for image pasting
		  "HakonHarnes/img-clip.nvim",
		  event = "VeryLazy",
		  opts = {
			-- recommended settings
			default = {
			  embed_image_as_base64 = false,
			  prompt_for_file_name = false,
			  drag_and_drop = {
				insert_mode = true,
			  },
			  -- required for Windows users
			  use_absolute_path = true,
			},
		  },
		},
		{
		  -- Make sure to set this up properly if you have lazy=true
		  'MeanderingProgrammer/render-markdown.nvim',
		  opts = {
			file_types = { "markdown", "Avante", "vimwiki" },
		  },
		  ft = { "markdown", "Avante" },
		},
	  },
	},
	-- Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		-- version = "v0.9.3",
		commit = "cfc6f2c117aaaa82f19bcce44deec2c194d900ab",
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
	{ dir = "~/project/yvim.nvim" },

	-- Git
	"lewis6991/gitsigns.nvim",
	{
		"linrongbin16/gitlinker.nvim",
		cmd = "GitLink",
		opts = {},
		keys = {
			{ "<leader>gy", "<cmd>GitLink<cr>", mode = { "n", "v" }, desc = "Yank git link" },
			{ "<leader>gY", "<cmd>GitLink!<cr>", mode = { "n", "v" }, desc = "Open git link" },
		},
	},
	"tpope/vim-fugitive",
	"tpope/vim-rhubarb",
	"ThePrimeagen/git-worktree.nvim",
	-- { "akinsho/git-conflict.nvim", version = "*", config = true },

	-- winbar
	{ "fgheng/winbar.nvim" },
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-treesitter/nvim-treesitter",
			-- runners
			"nvim-neotest/neotest-go",
			"nvim-neotest/neotest-jest",
		},
	},
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

	"tpope/vim-surround",
	"tpope/vim-abolish",
	"mbbill/undotree",
	{ "mzlogin/vim-markdown-toc" },
	{ "Darazaki/indent-o-matic" },
	{ "xiyaowong/transparent.nvim" },
	{ "eandrju/cellular-automaton.nvim", lazy = true },
	{ "laytan/cloak.nvim" },
	{ "jellydn/hurl.nvim", dependencies = { "MunifTanjim/nui.nvim" } },
	{ "kevinhwang91/nvim-bqf", ft = "qf" },
	{ "aznhe21/actions-preview.nvim" },
	{
		"salkin-mada/openscad.nvim",
		config = function()
			require("openscad")
			-- load snippets, note requires
			vim.g.openscad_load_snippets = true
		end,
		dependencies = "L3MON4D3/LuaSnip",
	},
	{ "jbyuki/venn.nvim" },
}

local opts = {
	defaults = {},
}

require("lazy").setup(plugins, opts)
