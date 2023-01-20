local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
	return
end

local setup = {
	plugins = {
		marks = true, -- shows a list of your marks on ' and `
		registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
		spelling = {
			enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
			suggestions = 20, -- how many suggestions should be shown in the list?
		},
		-- the presets plugin, adds help for a bunch of default keybindings in Neovim
		-- No actual key bindings are created
		presets = {
			operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
			motions = true, -- adds help for motions
			text_objects = true, -- help for text objects triggered after entering an operator
			windows = true, -- default bindings on <c-w>
			nav = true, -- misc bindings to work with windows
			z = true, -- bindings for folds, spelling and others prefixed with z
			g = true, -- bindings for prefixed with g
		},
	},
	-- add operators that will trigger motion and text object completion
	-- to enable all native operators, set the preset / operators plugin above
	-- operators = { gc = "Comments" },
	key_labels = {
		-- override the label used to display some keys. It doesn't effect WK in any other way.
		-- For example:
		-- ["<space>"] = "SPC",
		-- ["<cr>"] = "RET",
		-- ["<tab>"] = "TAB",
	},
	icons = {
		breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
		separator = "➜", -- symbol used between a key and it's label
		group = "+", -- symbol prepended to a group
	},
	popup_mappings = {
		scroll_down = "<c-d>", -- binding to scroll down inside the popup
		scroll_up = "<c-u>", -- binding to scroll up inside the popup
	},
	window = {
		border = "rounded", -- none, single, double, shadow
		position = "bottom", -- bottom, top
		margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
		padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
		winblend = 0,
	},
	layout = {
		height = { min = 4, max = 25 }, -- min and max height of the columns
		width = { min = 20, max = 50 }, -- min and max width of the columns
		spacing = 3, -- spacing between columns
		align = "left", -- align columns left, center or right
	},
	ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
	hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
	show_help = true, -- show help message on the command line when the popup is visible
	triggers = "auto", -- automatically setup triggers
	-- triggers = {"<leader>"} -- or specify a list manually
	triggers_blacklist = {
		-- list of mode / prefixes that should never be hooked by WhichKey
		-- this is mostly relevant for key maps that start with a native binding
		-- most people should not need to change this
		i = { "j", "k" },
		v = { "j", "k" },
	},
}

local opts = {
	mode = "n", -- NORMAL mode
	prefix = "<leader>",
	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
	nowait = true, -- use `nowait` when creating keymaps
}

local opts_vis = {
	mode = "v", -- VISUAL mode
	prefix = "<leader>",
	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
	nowait = true, -- use `nowait` when creating keymaps
}

local mappings = {
	["1"] = { "<cmd>lua require('harpoon.ui').nav_file(1)<CR>", "goto file 1" },
	["2"] = { "<cmd>lua require('harpoon.ui').nav_file(2)<CR>", "goto file 2" },
	["3"] = { "<cmd>lua require('harpoon.ui').nav_file(3)<CR>", "goto file 3" },
	["4"] = { "<cmd>lua require('harpoon.ui').nav_file(4)<CR>", "goto file 4" },
	["A"] = { "<cmd>Alpha<cr>", "Alpha" },
	["b"] = {
		"<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<cr>",
		"Buffers",
	},
	["e"] = { "<cmd>NvimTreeToggle<cr>", "Explorer" },
	["u"] = { "<cmd>UndotreeToggle<cr><CMD>UndotreeFocus<CR>", "Undotree" },
	["r"] = { "<cmd>lua require('telescope.builtin').resume()<cr>", "Resume last picker" },
	["R"] = { "<cmd>lua require('telescope.builtin').pickers()<cr>", "Pickers" },
	["w"] = { "<cmd>w!<CR>", "Save" },
	["q"] = { "<cmd>q!<CR>", "Quit" },
	["x"] = { "<cmd>Bdelete!<CR>", "Close Buffer" },
	["h"] = { "<cmd>nohlsearch<CR>", "No Highlight" },
	["H"] = {
		name = "Harpoon",
		m = { "<cmd>lua require('harpoon.mark').add_file()<CR>", "Add file" },
		u = { "<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>", "Toggle quick menu" },
		["1"] = { "<cmd>lua require('harpoon.ui').nav_file(1)<CR>", "goto file 1" },
		["2"] = { "<cmd>lua require('harpoon.ui').nav_file(2)<CR>", "goto file 2" },
		["3"] = { "<cmd>lua require('harpoon.ui').nav_file(3)<CR>", "goto file 3" },
		t = {
			name = "tmux",
			["1"] = { "<cmd>lua require('harpoon.tmux').gotoTerminal('1')<CR>", "goto tmux win 1" },
			-- ["1"] = { "<cmd>lua require('harpoon.tmux').gotoTerminal(1)<CR>", "goto tmux win 1" },
			["2"] = { "<cmd>lua require('harpoon.tmux').gotoTerminal(2)<CR>", "goto tmux win 2" },
			["3"] = { "<cmd>lua require('harpoon.tmux').gotoTerminal(3)<CR>", "goto tmux win 3" },
		},
	},
	["f"] = {
		"<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false})<cr>",
		"Find files",
	},
	["F"] = { "<cmd>Telescope grep_string search= theme=ivy<cr>", "Find Text" },
	-- ["P"] = { "<cmd>lua require('telescope').extensions.projects.projects()<cr>", "Projects" },
	-- ["P"] = { "<cmd>Telescope zoxide list<cr>", "zoxide" },
	-- ["R"] = { "<cmd>luafile ~/.config/nvim/init.lua<cr>", "Reload Config" },
	-- ["c"] = {
	-- 	name = "Cheat",
	-- 	c = { "<cmd>Cheat<CR>", "Quick Search" },
	-- 	l = { "<cmd>CheatList<CR>", "Cheatlist" },
	-- },
	-- ["c"] = {
	-- 	name = "harpoon commands",
	-- 	c = { "<cmd>Cheat<CR>", "Quick Search" },
	-- 	l = { "<cmd>CheatList<CR>", "Cheatlist" },
	-- },
    ["c"] = { "<CMD>lua require('harpoon.cmd-ui').toggle_quick_menu()<CR>", "harpoon cmd"},

	p = {
		name = "Packer",
		c = { "<cmd>PackerCompile<cr>", "Compile" },
		i = { "<cmd>PackerInstall<cr>", "Install" },
		s = { "<cmd>PackerSync<cr>", "Sync" },
		S = { "<cmd>PackerStatus<cr>", "Status" },
		u = { "<cmd>PackerUpdate<cr>", "Update" },
	},

	["G"] = { "<cmd>Git<CR>", "Fugitive" },

	g = {
		name = "Git",
		g = { "<cmd>lua _LAZYGIT_TOGGLE()<CR>", "Lazygit" },
		j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
		k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
		l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
		p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
		P = { "<cmd>Git pull<cr>", "Pull" },
		-- r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
		r = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
		R = { "<cmd>lua require 'gitsigns'.refresh()<cr>", "Refresh buffers" },
		s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
		u = {
			"<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
			"Undo Stage Hunk",
		},
		o = { "<cmd>Telescope git_status<cr>", "Status" },
		b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
		c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
		d = {
			"<cmd>Gitsigns diffthis HEAD<cr>",
			"Diff",
		},
	},

	l = {
        name = "LSP",
		a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
		d = {
			"<cmd>Telescope diagnostics bufnr=0<cr>",
			"Document Diagnostics",
		},
		w = {
			"<cmd>Telescope diagnostics<cr>",
			"Workspace Diagnostics",
		},
		f = { "<cmd>lua vim.lsp.buf.format{async=true}<cr>", "Format" },
		i = { "<cmd>LspInfo<cr>", "Info" },
		I = { "<cmd>LspInstallInfo<cr>", "Installer Info" },
		j = {
			"<cmd>lua vim.diagnostic.goto_next()<CR>zz",
			"Next Diagnostic",
		},
		k = {
			"<cmd>lua vim.diagnostic.goto_prev()<cr>zz",
			"Prev Diagnostic",
		},
		l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
		q = { "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>", "Quickfix" },
		r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
		-- R = { "<cmd>lua vim.lsp.buf.references()<cr>", "References" },
		R = { "<cmd>Telescope lsp_references<cr>", "References" },
		s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
		S = {
			"<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
			"Workspace Symbols",
		},
		x = {
			"<cmd>lua vim.diagnostic.open_float()<CR>",
			"Diagnostic Open Float",
		},
        N = {
            "<cmd>lua require('ts-node-action').node_action()<CR>",
            "TS Node Action"
        }
	},
	s = {
		name = "Search",
		b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
		C = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
		h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
		M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
		m = { "<cmd>Telescope harpoon marks<cr>", "harpoon marks" },
		r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
		R = { "<cmd>Telescope registers<cr>", "Registers" },
		s = { "<cmd>Telescope grep_string<cr>", "Find all occurrences" },
		f = {
			"<cmd>Telescope find_files hidden=true no_ignore=true<cr>",
			"Find files",
		},
		k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
		c = { "<cmd>Telescope commands<cr>", "Commands" },
	},

	t = {
		name = "Terminal",
		n = { "<cmd>lua _NODE_TOGGLE()<cr>", "Node" },
		u = { "<cmd>lua _NCDU_TOGGLE()<cr>", "NCDU" },
		t = { "<cmd>lua _HTOP_TOGGLE()<cr>", "Htop" },
		p = { "<cmd>lua _PYTHON_TOGGLE()<cr>", "Python" },
		f = { "<cmd>ToggleTerm direction=float<cr>", "Float" },
		h = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "Horizontal" },
		v = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", "Vertical" },
		["1"] = { "<cmd>lua require('harpoon.tmux').gotoTerminal(1)<CR>", "goto tmux win 1" },
		["2"] = { "<cmd>lua require('harpoon.tmux').gotoTerminal(2)<CR>", "goto tmux win 2" },
		["3"] = { "<cmd>lua require('harpoon.tmux').gotoTerminal(3)<CR>", "goto tmux win 3" },
	},

	a = { "<cmd>lua require('harpoon.mark').add_file()<CR>", "mark file" },

	m = { "<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>", "Toggle quick menu" },
	-- m = { "<cmd>Telescope harpoon marks<CR>", "Marks" },

	j = {
		name = "Jester",
		j = { "<cmd>lua require('jester').run()<cr>", "Run one" },
		f = {
			"<cmd>lua require('jester').run_file()<cr>",
			"Run file",
		},
		l = {
			"<cmd>lua require('jester').run_last()<cr>",
			"Run last test",
		},
		d = {
			name = "Debug",
			j = {
				"<cmd>lua require('jester').debug()<cr>",
				"Debug one",
			},
			f = {
				"<cmd>lua require('jester').debug_file()<cr>",
				"Debug file",
			},
			l = {
				"<cmd>lua require('jester').debug_last()<cr>",
				"Debug last test",
			},
		},
	},

	n = {
		name = "Notes | Vimwiki",
		i = { "<cmd>VimwikiIndex 1<cr>", "Go to index" },
		I = { "<cmd>VimwikiDiaryIndex 1<cr>", "Go to diary index" },
		t = { "<cmd>VimwikiTabIndex 1<cr>", "Go to index" },
		T = { "<cmd>VimwikiTabIndex 1<cr>", "Go to index" },
		d = { "<cmd>VimwikiMakeDiaryNote 1<cr>", "Make today's diary note" },
		f = { "<cmd>Telescope vimwiki<cr>", "Find wiki" },
		F = { "<cmd>Telescope vimwiki live_grep<cr>", "Search text in wiki" },
		-- n = { "<cmd>lua require'neuron/cmd'.new_edit(require'neuron'.config.neuron_dir)<CR>", "New" },

		-- -- find your notes, click enter to create the note if there are not notes that match
		-- z = { "<cmd>lua require'neuron/telescope'.find_zettels()<CR>", "Find zettels" },
		-- -- insert the id of the note that is found
		-- Z = { "<cmd>lua require'neuron/telescope'.find_zettels {insert = true}<CR>", "Find zettels insert" },
		-- --" find the backlinks of the current note all the note that link this note
		-- b = { "<cmd>lua require'neuron/telescope'.find_backlinks()<CR>", "Backlinks" },
		-- --" same as above but insert the found id
		-- B = { "<cmd>lua require'neuron/telescope'.find_backlinks {insert = true}<CR>", "Backlinks insert" },
		-- --" find all tags and insert
		-- t = { "<cmd>lua require'neuron/telescope'.find_tags()<CR>", "Tags" },
		-- --" start the neuron server and render markdown, auto reload on save
		-- s = { "<cmd>lua require'neuron'.rib {address = '127.0.0.1:8200', verbose = true}<CR>", "Start server" },
		-- --" go to next [[my_link]] or [[[my_link]]]
		-- j = { "<cmd>lua require'neuron'.goto_next_extmark()<CR>", "Next link" },
		-- --" go to previous
		-- k = { "<cmd>lua require'neuron'.goto_prev_extmark()<CR>]]", "Previous link" },
	},

	d = {
		name = "Debug",
		R = { "<cmd>lua require'dap'.run_to_cursor()<cr>", "Run to Cursor" },
		E = { "<cmd>lua require'dapui'.eval(vim.fn.input '[Expression] > ')<cr>", "Evaluate Input" },
		C = { "<cmd>lua require'dap'.set_breakpoint(vim.fn.input '[Condition] > ')<cr>", "Conditional Breakpoint" },
		U = { "<cmd>lua require'dapui'.toggle()<cr>", "Toggle UI" },
		b = { "<cmd>lua require'dap'.step_back()<cr>", "Step Back" },
		c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
		d = { "<cmd>lua require'dap'.disconnect()<cr>", "Disconnect" },
		e = { "<cmd>lua require'dapui'.eval()<cr>", "Evaluate" },
		g = { "<cmd>lua require'dap'.session()<cr>", "Get Session" },
		h = { "<cmd>lua require'dap.ui.widgets'.hover()<cr>", "Hover Variables" },
		S = { "<cmd>lua require'dap.ui.widgets'.scopes()<cr>", "Scopes" },
		i = { "<cmd>lua require'dap'.step_into()<cr>", "Step Into" },
		o = { "<cmd>lua require'dap'.step_over()<cr>", "Step Over" },
		p = { "<cmd>lua require'dap'.pause.toggle()<cr>", "Pause" },
		q = { "<cmd>lua require'dap'.close()<cr>", "Quit" },
		r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Toggle Repl" },
		s = { "<cmd>lua require'dap'.continue()<cr>", "Start" },
		t = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle Breakpoint" },
		x = { "<cmd>lua require'dap'.terminate()<cr>", "Terminate" },
		u = { "<cmd>lua require'dap'.step_out()<cr>", "Step Out" },
	},
}

local visual_mapping = {
	["F"] = { '"zy<cmd>Telescope live_grep theme=ivy<cr>', "Find Text" },
}

which_key.setup(setup)
which_key.register(mappings, opts)
