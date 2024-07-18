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
	-- key_labels = {
	-- 	-- override the label used to display some keys. It doesn't effect WK in any other way.
	-- 	-- For example:
	-- 	-- ["<space>"] = "SPC",
	-- 	-- ["<cr>"] = "RET",
	-- 	-- ["<tab>"] = "TAB",
	-- },
	icons = {
		breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
		separator = "➜", -- symbol used between a key and it's label
		group = "+", -- symbol prepended to a group
	},
	-- popup_mappings = {
	-- 	scroll_down = "<c-d>", -- binding to scroll down inside the popup
	-- 	scroll_up = "<c-u>", -- binding to scroll up inside the popup
	-- },
	-- window = {
	-- 	border = "rounded", -- none, single, double, shadow
	-- 	position = "bottom", -- bottom, top
	-- 	margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
	-- 	padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
	-- 	winblend = 0,
	-- },
	layout = {
		height = { min = 4, max = 25 }, -- min and max height of the columns
		width = { min = 20, max = 50 }, -- min and max width of the columns
		spacing = 3, -- spacing between columns
		align = "left", -- align columns left, center or right
	},
	-- ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
	-- hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
	show_help = true, -- show help message on the command line when the popup is visible
	triggers = "auto", -- automatically setup triggers
	-- triggers = {"<leader>"} -- or specify a list manually
	-- triggers_blacklist = {
	-- 	-- list of mode / prefixes that should never be hooked by WhichKey
	-- 	-- this is mostly relevant for key maps that start with a native binding
	-- 	-- most people should not need to change this
	-- 	i = { "j", "k" },
	-- 	v = { "j", "k" },
	-- },
}

local opts = {
	mode = "n", -- NORMAL mode
	prefix = "<leader>",
	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
	nowait = true, -- use `nowait` when creating keymaps
}

-- local opts_vis = {
-- 	mode = "v", -- VISUAL mode
-- 	prefix = "<leader>",
-- 	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
-- 	silent = true, -- use `silent` when creating keymaps
-- 	noremap = true, -- use `noremap` when creating keymaps
-- 	nowait = true, -- use `nowait` when creating keymaps
-- }

local mappings = {
	["1"] = { "<cmd>lua require('harpoon.ui').nav_file(1)<CR>", "goto file 1" },
	["2"] = { "<cmd>lua require('harpoon.ui').nav_file(2)<CR>", "goto file 2" },
	["3"] = { "<cmd>lua require('harpoon.ui').nav_file(3)<CR>", "goto file 3" },
	["4"] = { "<cmd>lua require('harpoon.ui').nav_file(4)<CR>", "goto file 4" },
	["5"] = { "<cmd>lua require('harpoon.ui').nav_file(5)<CR>", "goto file 5" },
	["A"] = { "<cmd>Alpha<cr>", "Alpha" },
	["b"] = {
		"<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<cr>",
		"Buffers",
	},
	["e"] = { "<cmd>NvimTreeToggle<cr>", "Explorer" },
	["u"] = { "<cmd>UndotreeToggle<cr><CMD>UndotreeFocus<CR>", "Undotree" },
	-- ["u"] = { "<cmd>lua require('undotree').toggle()<CR>", "Undotree" },
	["r"] = { "<cmd>lua require('telescope.builtin').resume()<cr>", "Resume last picker" },
	["R"] = { "<cmd>lua require('telescope.builtin').pickers()<cr>", "Pickers" },
	["w"] = { "<cmd>w!<CR>", "Save" },
	["q"] = { "<cmd>q!<CR>", "Quit" },
	["x"] = { "<cmd>Bdelete!<CR>", "Close Buffer" },
	["X"] = { [[<cmd>%bdelete|edit #|normal `"<CR>]], "Close other buffers" },
	["z"] = { "<cmd>Centerpad 60<CR>", "Center a lone buffer" },
	["h"] = { "<cmd>nohlsearch<CR>", "No Highlight" },
	["H"] = { "<cmd>CloakToggle<CR>", "Toggle Cloak"},
	-- ["H"] = {
	-- 	name = "Harpoon",
	-- 	m = { "<cmd>lua require('harpoon.mark').add_file()<CR>", "Add file" },
	-- 	u = { "<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>", "Toggle quick menu" },
	-- 	["1"] = { "<cmd>lua require('harpoon.ui').nav_file(1)<CR>", "goto file 1" },
	-- 	["2"] = { "<cmd>lua require('harpoon.ui').nav_file(2)<CR>", "goto file 2" },
	-- 	["3"] = { "<cmd>lua require('harpoon.ui').nav_file(3)<CR>", "goto file 3" },
	-- 	t = {
	-- 		name = "tmux",
	-- 		["1"] = { "<cmd>lua require('harpoon.tmux').gotoTerminal('1')<CR>", "goto tmux win 1" },
	-- 		["2"] = { "<cmd>lua require('harpoon.tmux').gotoTerminal(2)<CR>", "goto tmux win 2" },
	-- 		["3"] = { "<cmd>lua require('harpoon.tmux').gotoTerminal(3)<CR>", "goto tmux win 3" },
	-- 	},
	-- },
	["f"] = {
		"<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false})<cr>",
		-- "<cmd>lua require('telescope.builtin').find_files()<cr>",
		-- "<cmd>Telescope find_files<cr>",
		"Find files",
	},
	["F"] = { "<cmd>Telescope grep_string search= theme=ivy only_sort_text=true<cr>", "Find Text" },
	-- TODO: make this fuzzy
	["/"] = { "<cmd>Telescope live_grep search='' theme=ivy only_sort_text=true search_dirs={'%:p'}<cr>", "Find Text" },
	["?"] = { "<cmd>Telescope grep_string search='' theme=ivy only_sort_text=true search_dirs={'%:p'}<cr>", "Find Text" },
	["T"] = { "<cmd>TransparentToggle<cr>", "Toggle Transparency" },
	-- ["F"] = { "<cmd>Telescope live_grep search= theme=ivy<cr>", "Find Text" },
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
	["c"] = { "<CMD>lua require('harpoon.cmd-ui').toggle_quick_menu()<CR>", "harpoon cmd" },

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
		-- g = { "<cmd>lua _LAZYGIT_TOGGLE()<CR>", "Lazygit" },
		g = { "<cmd>Git<CR>", "Fugitive" },
		j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
		k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
		l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
		p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
		P = { "<cmd>Git pull<cr>", "Pull" },
		H = { "<cmd>Git push -u origin HEAD<cr>", "Push HEAD" },
		e = { "<cmd>Git commit --allow-empty -m 'empty commit'<cr>", "Push HEAD" },
		-- r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
		r = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
		R = { "<cmd>lua require 'gitsigns'.refresh()<cr>", "Refresh buffers" },
		-- s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
		s = { "<cmd>Telescope git_stash<cr>", "Git stashes" },
		u = {
			"<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
			"Undo Stage Hunk",
		},
		o = { "<cmd>Telescope git_status<cr>", "Status" },
		-- b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
		b = {
			"<cmd>lua require('telescope.builtin').git_branches(require('telescope.themes').get_dropdown{previewer = false})<cr>",
			"Git branch",
		},
		c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
		C = { "<cmd>Telescope git_bcommits<cr>", "Checkout commit of this file" },
		d = {
			"<cmd>Gitsigns diffthis HEAD<cr>",
			"Diff",
		},
		w = {
			name = "Worktree",
			s = { "<cmd>Telescope git_worktree git_worktrees theme=dropdown<cr>", "List worktrees" },
			c = { "<cmd>Telescope git_worktree create_git_worktree<cr>", "Create worktree" },
			-- c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
		},
	},

	l = {
		name = "LSP",
		-- a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
		a = { "<cmd>lua require('actions-preview').code_actions()<cr>", "Code Action" },
		d = {
			"<cmd>Telescope diagnostics bufnr=0<cr>",
			"Document Diagnostics",
		},
		w = {
			"<cmd>Telescope diagnostics<cr>",
			"Workspace Diagnostics",
		},
		-- f = { "<cmd>lua vim.lsp.buf.format{async=true}<cr>", "Format" },
		f = { "<cmd>lua require('conform').format()<cr>", "Format" },
		i = { "<cmd>LspInfo<cr>", "Info" },
		I = { "<cmd>Mason<cr>", "Installer Info" },
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
		n = {
			[[<cmd>lua require('ts-node-action').node_action()<CR>]],
			"TS Node Action",
		},
		c = {
			name = "Copilot",
			c = {
				"<cmd>lua require('copilot').toggle_auto_trigger()<CR>",
				"Toggle auto trigger",
			},
			r = {
				"<cmd>lua require('copilot.panel').refresh()<CR>",
				"Refresh panel",
			},
		},
		o = {
			"<CMD>lua vim.lsp.buf.outgoing_calls()<CR>",
			"Show outgoing calls",
		},
	},
	S = { ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>", "Substitute word" },
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
		-- ["F"] = { "<cmd>Telescope live_grep search= theme=ivy<cr>", "Find Text" },
		f = {
			"<cmd>Telescope live_grep search= theme=ivy<cr>",
			"Live grep",
		},
		d = {
			"<CMD>lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>",
			"Live grep args",
		},
		-- f = {
		-- 	"<cmd>Telescope find_files hidden=true no_ignore=true<cr>",
		-- 	"Find files",
		-- },
		k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
		c = { "<cmd>Telescope commands theme=dropdown<cr>", "Commands" },
	},

	t = {
		name = "Terminal",
		n = { "<cmd>lua _NODE_TOGGLE()<cr>", "Node" },
		u = { "<cmd>lua _NCDU_TOGGLE()<cr>", "NCDU" },
		p = { "<cmd>lua _PYTHON_TOGGLE()<cr>", "Python" },
		f = { "<cmd>ToggleTerm direction=float<cr>", "Float" },
		h = { "<cmd>ToggleTerm direction=horizontal<cr>", "Horizontal" },
		v = { "<cmd>ToggleTerm direction=vertical<cr>", "Vertical" },
		["1"] = { "<cmd>lua require('harpoon.tmux').gotoTerminal(1)<CR>", "goto tmux win 1" },
		["2"] = { "<cmd>lua require('harpoon.tmux').gotoTerminal(2)<CR>", "goto tmux win 2" },
		["3"] = { "<cmd>lua require('harpoon.tmux').gotoTerminal(3)<CR>", "goto tmux win 3" },
	},

	a = { "<cmd>lua require('harpoon.mark').add_file()<CR>", "mark file" },

	m = { "<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>", "Toggle quick menu" },

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

-- local mappings = {
--     { "<leader>/", "<cmd>Telescope live_grep search='' theme=ivy only_sort_text=true search_dirs={'%:p'}<cr>", desc = "Find Text", nowait = true, remap = false },
--     { "<leader>1", "<cmd>lua require('harpoon.ui').nav_file(1)<CR>", desc = "goto file 1", nowait = true, remap = false },
--     { "<leader>2", "<cmd>lua require('harpoon.ui').nav_file(2)<CR>", desc = "goto file 2", nowait = true, remap = false },
--     { "<leader>3", "<cmd>lua require('harpoon.ui').nav_file(3)<CR>", desc = "goto file 3", nowait = true, remap = false },
--     { "<leader>4", "<cmd>lua require('harpoon.ui').nav_file(4)<CR>", desc = "goto file 4", nowait = true, remap = false },
--     { "<leader>5", "<cmd>lua require('harpoon.ui').nav_file(5)<CR>", desc = "goto file 5", nowait = true, remap = false },
--     { "<leader>?", "<cmd>Telescope grep_string search='' theme=ivy only_sort_text=true search_dirs={'%:p'}<cr>", desc = "Find Text", nowait = true, remap = false },
--     { "<leader>A", "<cmd>Alpha<cr>", desc = "Alpha", nowait = true, remap = false },
--     { "<leader>F", "<cmd>Telescope grep_string search= theme=ivy only_sort_text=true<cr>", desc = "Find Text", nowait = true, remap = false },
--     { "<leader>G", "<cmd>Git<CR>", desc = "Fugitive", nowait = true, remap = false },
--     { "<leader>H", "<cmd>CloakToggle<CR>", desc = "Toggle Cloak", nowait = true, remap = false },
--     { "<leader>R", "<cmd>lua require('telescope.builtin').pickers()<cr>", desc = "Pickers", nowait = true, remap = false },
--     { "<leader>S", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>", desc = "Substitute word", nowait = true, remap = false },
--     { "<leader>T", "<cmd>TransparentToggle<cr>", desc = "Toggle Transparency", nowait = true, remap = false },
--     { "<leader>X", '<cmd>%bdelete|edit #|normal `"<CR>', desc = "Close other buffers", nowait = true, remap = false },
--     { "<leader>a", "<cmd>lua require('harpoon.mark').add_file()<CR>", desc = "mark file", nowait = true, remap = false },
--     { "<leader>b", "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<cr>", desc = "Buffers", nowait = true, remap = false },
--     { "<leader>c", "<CMD>lua require('harpoon.cmd-ui').toggle_quick_menu()<CR>", desc = "harpoon cmd", nowait = true, remap = false },
--     { "<leader>d", group = "Debug", nowait = true, remap = false },
--     { "<leader>dC", "<cmd>lua require'dap'.set_breakpoint(vim.fn.input '[Condition] > ')<cr>", desc = "Conditional Breakpoint", nowait = true, remap = false },
--     { "<leader>dE", "<cmd>lua require'dapui'.eval(vim.fn.input '[Expression] > ')<cr>", desc = "Evaluate Input", nowait = true, remap = false },
--     { "<leader>dR", "<cmd>lua require'dap'.run_to_cursor()<cr>", desc = "Run to Cursor", nowait = true, remap = false },
--     { "<leader>dS", "<cmd>lua require'dap.ui.widgets'.scopes()<cr>", desc = "Scopes", nowait = true, remap = false },
--     { "<leader>dU", "<cmd>lua require'dapui'.toggle()<cr>", desc = "Toggle UI", nowait = true, remap = false },
--     { "<leader>db", "<cmd>lua require'dap'.step_back()<cr>", desc = "Step Back", nowait = true, remap = false },
--     { "<leader>dc", "<cmd>lua require'dap'.continue()<cr>", desc = "Continue", nowait = true, remap = false },
--     { "<leader>dd", "<cmd>lua require'dap'.disconnect()<cr>", desc = "Disconnect", nowait = true, remap = false },
--     { "<leader>de", "<cmd>lua require'dapui'.eval()<cr>", desc = "Evaluate", nowait = true, remap = false },
--     { "<leader>dg", "<cmd>lua require'dap'.session()<cr>", desc = "Get Session", nowait = true, remap = false },
--     { "<leader>dh", "<cmd>lua require'dap.ui.widgets'.hover()<cr>", desc = "Hover Variables", nowait = true, remap = false },
--     { "<leader>di", "<cmd>lua require'dap'.step_into()<cr>", desc = "Step Into", nowait = true, remap = false },
--     { "<leader>do", "<cmd>lua require'dap'.step_over()<cr>", desc = "Step Over", nowait = true, remap = false },
--     { "<leader>dp", "<cmd>lua require'dap'.pause.toggle()<cr>", desc = "Pause", nowait = true, remap = false },
--     { "<leader>dq", "<cmd>lua require'dap'.close()<cr>", desc = "Quit", nowait = true, remap = false },
--     { "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>", desc = "Toggle Repl", nowait = true, remap = false },
--     { "<leader>ds", "<cmd>lua require'dap'.continue()<cr>", desc = "Start", nowait = true, remap = false },
--     { "<leader>dt", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", desc = "Toggle Breakpoint", nowait = true, remap = false },
--     { "<leader>du", "<cmd>lua require'dap'.step_out()<cr>", desc = "Step Out", nowait = true, remap = false },
--     { "<leader>dx", "<cmd>lua require'dap'.terminate()<cr>", desc = "Terminate", nowait = true, remap = false },
--     { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Explorer", nowait = true, remap = false },
--     { "<leader>f", "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false})<cr>", desc = "Find files", nowait = true, remap = false },
--     { "<leader>g", group = "Git", nowait = true, remap = false },
--     { "<leader>gC", "<cmd>Telescope git_bcommits<cr>", desc = "Checkout commit of this file", nowait = true, remap = false },
--     { "<leader>gH", "<cmd>Git push -u origin HEAD<cr>", desc = "Push HEAD", nowait = true, remap = false },
--     { "<leader>gP", "<cmd>Git pull<cr>", desc = "Pull", nowait = true, remap = false },
--     { "<leader>gR", "<cmd>lua require 'gitsigns'.refresh()<cr>", desc = "Refresh buffers", nowait = true, remap = false },
--     { "<leader>gb", "<cmd>lua require('telescope.builtin').git_branches(require('telescope.themes').get_dropdown{previewer = false})<cr>", desc = "Git branch", nowait = true, remap = false },
--     { "<leader>gc", "<cmd>Telescope git_commits<cr>", desc = "Checkout commit", nowait = true, remap = false },
--     { "<leader>gd", "<cmd>Gitsigns diffthis HEAD<cr>", desc = "Diff", nowait = true, remap = false },
--     { "<leader>ge", "<cmd>Git commit --allow-empty -m 'empty commit'<cr>", desc = "Push HEAD", nowait = true, remap = false },
--     { "<leader>gg", "<cmd>Git<CR>", desc = "Fugitive", nowait = true, remap = false },
--     { "<leader>gj", "<cmd>lua require 'gitsigns'.next_hunk()<cr>", desc = "Next Hunk", nowait = true, remap = false },
--     { "<leader>gk", "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", desc = "Prev Hunk", nowait = true, remap = false },
--     { "<leader>gl", "<cmd>lua require 'gitsigns'.blame_line()<cr>", desc = "Blame", nowait = true, remap = false },
--     { "<leader>go", "<cmd>Telescope git_status<cr>", desc = "Status", nowait = true, remap = false },
--     { "<leader>gp", "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", desc = "Preview Hunk", nowait = true, remap = false },
--     { "<leader>gr", "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", desc = "Reset Buffer", nowait = true, remap = false },
--     { "<leader>gs", "<cmd>Telescope git_stash<cr>", desc = "Git stashes", nowait = true, remap = false },
--     { "<leader>gu", "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>", desc = "Undo Stage Hunk", nowait = true, remap = false },
--     { "<leader>gw", group = "Worktree", nowait = true, remap = false },
--     { "<leader>gwc", "<cmd>Telescope git_worktree create_git_worktree<cr>", desc = "Create worktree", nowait = true, remap = false },
--     { "<leader>gws", "<cmd>Telescope git_worktree git_worktrees theme=dropdown<cr>", desc = "List worktrees", nowait = true, remap = false },
--     { "<leader>h", "<cmd>nohlsearch<CR>", desc = "No Highlight", nowait = true, remap = false },
--     { "<leader>j", group = "Jester", nowait = true, remap = false },
--     { "<leader>jd", group = "Debug", nowait = true, remap = false },
--     { "<leader>jdf", "<cmd>lua require('jester').debug_file()<cr>", desc = "Debug file", nowait = true, remap = false },
--     { "<leader>jdj", "<cmd>lua require('jester').debug()<cr>", desc = "Debug one", nowait = true, remap = false },
--     { "<leader>jdl", "<cmd>lua require('jester').debug_last()<cr>", desc = "Debug last test", nowait = true, remap = false },
--     { "<leader>jf", "<cmd>lua require('jester').run_file()<cr>", desc = "Run file", nowait = true, remap = false },
--     { "<leader>jj", "<cmd>lua require('jester').run()<cr>", desc = "Run one", nowait = true, remap = false },
--     { "<leader>jl", "<cmd>lua require('jester').run_last()<cr>", desc = "Run last test", nowait = true, remap = false },
--     { "<leader>l", group = "LSP", nowait = true, remap = false },
--     { "<leader>lI", "<cmd>Mason<cr>", desc = "Installer Info", nowait = true, remap = false },
--     { "<leader>lR", "<cmd>Telescope lsp_references<cr>", desc = "References", nowait = true, remap = false },
--     { "<leader>lS", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", desc = "Workspace Symbols", nowait = true, remap = false },
--     { "<leader>la", "<cmd>lua require('actions-preview').code_actions()<cr>", desc = "Code Action", nowait = true, remap = false },
--     { "<leader>lc", group = "Copilot", nowait = true, remap = false },
--     { "<leader>lcc", "<cmd>lua require('copilot').toggle_auto_trigger()<CR>", desc = "Toggle auto trigger", nowait = true, remap = false },
--     { "<leader>lcr", "<cmd>lua require('copilot.panel').refresh()<CR>", desc = "Refresh panel", nowait = true, remap = false },
--     { "<leader>ld", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Document Diagnostics", nowait = true, remap = false },
--     { "<leader>lf", "<cmd>lua require('conform').format()<cr>", desc = "Format", nowait = true, remap = false },
--     { "<leader>li", "<cmd>LspInfo<cr>", desc = "Info", nowait = true, remap = false },
--     { "<leader>lj", "<cmd>lua vim.diagnostic.goto_next()<CR>zz", desc = "Next Diagnostic", nowait = true, remap = false },
--     { "<leader>lk", "<cmd>lua vim.diagnostic.goto_prev()<cr>zz", desc = "Prev Diagnostic", nowait = true, remap = false },
--     { "<leader>ll", "<cmd>lua vim.lsp.codelens.run()<cr>", desc = "CodeLens Action", nowait = true, remap = false },
--     { "<leader>ln", "<cmd>lua require('ts-node-action').node_action()<CR>", desc = "TS Node Action", nowait = true, remap = false },
--     { "<leader>lo", "<CMD>lua vim.lsp.buf.outgoing_calls()<CR>", desc = "Show outgoing calls", nowait = true, remap = false },
--     { "<leader>lq", "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>", desc = "Quickfix", nowait = true, remap = false },
--     { "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", desc = "Rename", nowait = true, remap = false },
--     { "<leader>ls", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Document Symbols", nowait = true, remap = false },
--     { "<leader>lw", "<cmd>Telescope diagnostics<cr>", desc = "Workspace Diagnostics", nowait = true, remap = false },
--     { "<leader>lx", "<cmd>lua vim.diagnostic.open_float()<CR>", desc = "Diagnostic Open Float", nowait = true, remap = false },
--     { "<leader>m", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>", desc = "Toggle quick menu", nowait = true, remap = false },
--     { "<leader>n", group = "Notes | Vimwiki", nowait = true, remap = false },
--     { "<leader>nF", "<cmd>Telescope vimwiki live_grep<cr>", desc = "Search text in wiki", nowait = true, remap = false },
--     { "<leader>nI", "<cmd>VimwikiDiaryIndex 1<cr>", desc = "Go to diary index", nowait = true, remap = false },
--     { "<leader>nT", "<cmd>VimwikiTabIndex 1<cr>", desc = "Go to index", nowait = true, remap = false },
--     { "<leader>nd", "<cmd>VimwikiMakeDiaryNote 1<cr>", desc = "Make today's diary note", nowait = true, remap = false },
--     { "<leader>nf", "<cmd>Telescope vimwiki<cr>", desc = "Find wiki", nowait = true, remap = false },
--     { "<leader>ni", "<cmd>VimwikiIndex 1<cr>", desc = "Go to index", nowait = true, remap = false },
--     { "<leader>nt", "<cmd>VimwikiTabIndex 1<cr>", desc = "Go to index", nowait = true, remap = false },
--     { "<leader>p", group = "Packer", nowait = true, remap = false },
--     { "<leader>pS", "<cmd>PackerStatus<cr>", desc = "Status", nowait = true, remap = false },
--     { "<leader>pc", "<cmd>PackerCompile<cr>", desc = "Compile", nowait = true, remap = false },
--     { "<leader>pi", "<cmd>PackerInstall<cr>", desc = "Install", nowait = true, remap = false },
--     { "<leader>ps", "<cmd>PackerSync<cr>", desc = "Sync", nowait = true, remap = false },
--     { "<leader>pu", "<cmd>PackerUpdate<cr>", desc = "Update", nowait = true, remap = false },
--     { "<leader>q", "<cmd>q!<CR>", desc = "Quit", nowait = true, remap = false },
--     { "<leader>r", "<cmd>lua require('telescope.builtin').resume()<cr>", desc = "Resume last picker", nowait = true, remap = false },
--     { "<leader>s", group = "Search", nowait = true, remap = false },
--     { "<leader>sC", "<cmd>Telescope colorscheme<cr>", desc = "Colorscheme", nowait = true, remap = false },
--     { "<leader>sM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages", nowait = true, remap = false },
--     { "<leader>sR", "<cmd>Telescope registers<cr>", desc = "Registers", nowait = true, remap = false },
--     { "<leader>sb", "<cmd>Telescope git_branches<cr>", desc = "Checkout branch", nowait = true, remap = false },
--     { "<leader>sc", "<cmd>Telescope commands theme=dropdown<cr>", desc = "Commands", nowait = true, remap = false },
--     { "<leader>sd", "<CMD>lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>", desc = "Live grep args", nowait = true, remap = false },
--     { "<leader>sf", "<cmd>Telescope live_grep search= theme=ivy<cr>", desc = "Live grep", nowait = true, remap = false },
--     { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Find Help", nowait = true, remap = false },
--     { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Keymaps", nowait = true, remap = false },
--     { "<leader>sm", "<cmd>Telescope harpoon marks<cr>", desc = "harpoon marks", nowait = true, remap = false },
--     { "<leader>sr", "<cmd>Telescope oldfiles<cr>", desc = "Open Recent File", nowait = true, remap = false },
--     { "<leader>ss", "<cmd>Telescope grep_string<cr>", desc = "Find all occurrences", nowait = true, remap = false },
--     { "<leader>t", group = "Terminal", nowait = true, remap = false },
--     { "<leader>t1", "<cmd>lua require('harpoon.tmux').gotoTerminal(1)<CR>", desc = "goto tmux win 1", nowait = true, remap = false },
--     { "<leader>t2", "<cmd>lua require('harpoon.tmux').gotoTerminal(2)<CR>", desc = "goto tmux win 2", nowait = true, remap = false },
--     { "<leader>t3", "<cmd>lua require('harpoon.tmux').gotoTerminal(3)<CR>", desc = "goto tmux win 3", nowait = true, remap = false },
--     { "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", desc = "Float", nowait = true, remap = false },
--     { "<leader>th", "<cmd>ToggleTerm direction=horizontal<cr>", desc = "Horizontal", nowait = true, remap = false },
--     { "<leader>tn", "<cmd>lua _NODE_TOGGLE()<cr>", desc = "Node", nowait = true, remap = false },
--     { "<leader>tp", "<cmd>lua _PYTHON_TOGGLE()<cr>", desc = "Python", nowait = true, remap = false },
--     { "<leader>tu", "<cmd>lua _NCDU_TOGGLE()<cr>", desc = "NCDU", nowait = true, remap = false },
--     { "<leader>tv", "<cmd>ToggleTerm direction=vertical<cr>", desc = "Vertical", nowait = true, remap = false },
--     { "<leader>u", "<cmd>UndotreeToggle<cr><CMD>UndotreeFocus<CR>", desc = "Undotree", nowait = true, remap = false },
--     { "<leader>w", "<cmd>w!<CR>", desc = "Save", nowait = true, remap = false },
--     { "<leader>x", "<cmd>Bdelete!<CR>", desc = "Close Buffer", nowait = true, remap = false },
--     { "<leader>z", "<cmd>Centerpad 60<CR>", desc = "Center a lone buffer", nowait = true, remap = false },
--   }

which_key.setup(setup)
which_key.register(mappings, opts)
