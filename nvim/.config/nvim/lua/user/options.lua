local options = {
	backup = false, -- creates a backup file
	clipboard = "unnamedplus", -- allows neovim to access the system clipboard
	--  cmdheight = 2,                           -- more space in the neovim command line for displaying messages
	--  completeopt = { "menuone", "noselect" }, -- mostly just for cmp
	conceallevel = 0, -- so that `` is visible in markdown files
	fileencoding = "utf-8", -- the encoding written to a file
	hlsearch = true, -- highlight all matches on previous search pattern
	-- nohlsearch = true, --
	ignorecase = true, -- ignore case in search patterns
	autoread = true, -- reload files changed outside neovim
	mouse = "a", -- allow the mouse to be used in neovim
	--  pumheight = 10,                          -- pop up menu height
	--  showmode = false,                        -- we don't need to see things like -- INSERT -- anymore
	-- showtabline = 2, -- always show tabs
	smartcase = true, -- smart case
	smartindent = true, -- make indenting smarter again
	splitbelow = true, -- force all horizontal splits to go below current window
	splitright = true, -- force all vertical splits to go to the right of current window
	swapfile = false, -- creates a swapfile
	termguicolors = true, -- set term gui colors (most terminals support this)
	timeoutlen = 200, -- time to wait for a mapped sequence to complete (in milliseconds)
	undofile = true, -- enable persistent undo
	updatetime = 100, -- faster completion (4000ms default)
	writebackup = false, -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
	expandtab = true, -- convert tabs to spaces
	shiftwidth = 4, -- the number of spaces inserted for each indentation
	tabstop = 4, -- insert 2 spaces for a tab
	softtabstop = 4,
	cursorline = true, -- highlight the current line
	number = true, -- set numbered lines
	relativenumber = true, -- set relative numbered lines
	numberwidth = 4, -- set number column width to 2 {default 4}
	signcolumn = "yes", -- always show the sign column, otherwise it would shift the text each time
	wrap = false, -- display lines as one long line
	scrolloff = 8, -- is one of my fav
	sidescrolloff = 8,
	--  guifont = "monospace:h17",               -- the font used in graphical neovim applications
	spell = true,
	foldmethod = "syntax",
}

vim.opt.shortmess:append("c")

for k, v in pairs(options) do
	vim.opt[k] = v
end

-- vim.cmd("set foldmethod=syntax")
vim.cmd("set foldnestmax=10")
vim.cmd("set nofoldenable")
vim.cmd("set foldlevel=99")
-- vim.cmd("set foldmethod=syntax")
-- vim.cmd("set foldlevel=99")
vim.cmd("set whichwrap+=<,>,[,],h,l")
vim.cmd([[set iskeyword+=-]])
vim.cmd([[set formatoptions-=cro]]) -- TODO: this doesn't seem to work
vim.cmd([[let g:cheat_default_window_layout = 'split']])
-- vim.cmd([[let g:vimwiki_key_mappings = {'all_maps': 0, 'global': 0}]])
vim.cmd([[let g:vimwiki_map_prefix = '<leader>V']])
vim.cmd([[let g:vimwiki_global_ext = 0]])
vim.cmd([[let g:undotree_WindowLayout = 1]])
vim.cmd([[let g:undotree_SplitWidth = 50]])
vim.cmd([[ let g:vimwiki_list = [{'path': '~/.vimwiki/', 'syntax': 'markdown', 'ext': 'md', 'global_ext': 0}] ]])
-- vim.o.termguicolors = true

-- copilot remapping related options
-- vim.cmd([[let g:copilot_no_tab_map = v:true]])
-- vim.cmd([[let g:copilot_assume_mapped = v:true]])
vim.g["copilot_no_tab_map"] = false
vim.g["copilot_assume_mapped"] = false
