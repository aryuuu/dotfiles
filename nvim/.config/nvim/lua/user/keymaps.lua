local opts = { noremap = true, silent = true, nowait = false }
local opts_quick = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- "smooth" scrolling
-- keymap("n", "j", "jzz", opts)
-- keymap("n", "k", "kzz", opts)


-----------------
-- NAVIGATIONS --
-----------------

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- quicklist navigation
keymap("n", "]q", ":cnext<CR>", opts)
keymap("n", "[q", ":cprev<CR>", opts)

-- Resize with arrows
keymap("n", "<C-S-+>", ":resize -2<CR>", opts)
keymap("n", "<C-S-->", ":resize +2<CR>", opts)
keymap("n", "<C-S-h>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-S-l>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Harpoon jumps
keymap("n", "<leader>1", "<cmd>lua require('harpoon.ui').nav_file(1)<CR>", opts)
keymap("n", "<leader>2", "<cmd>lua require('harpoon.ui').nav_file(2)<CR>", opts)
keymap("n", "<leader>3", "<cmd>lua require('harpoon.ui').nav_file(3)<CR>", opts)
keymap("n", "<leader>4", "<cmd>lua require('harpoon.ui').nav_file(4)<CR>", opts)
keymap("n", "<leader>5", "<cmd>lua require('harpoon.ui').nav_file(5)<CR>", opts)

-- tmux-sessionizer
-- keymap("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>", opts)
keymap("n", "<M-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>", opts)

-- non-disorienting half page jump
keymap("n", "<C-d>", "<C-d>zz", opts)
keymap("n", "<C-u>", "<C-u>zz", opts)

keymap("n", "G", "Gzz", opts)

-- xml tag jump
keymap("n", "[t", "vato<Esc>", opts)
keymap("n", "]t", "vat<Esc>", opts)

-- better search navigation
keymap("n", "n", "nzz", opts)
keymap("n", "N", "Nzz", opts)

-- Define key mappings
keymap('n', '<left>', ':lua require("yvim").to_parent()<CR>', opts)
keymap('n', '<right>', ':lua require("yvim").descend()<CR>', opts)
keymap('n', '<up>', ':lua require("yvim").prev_sibling()<CR>', opts)
keymap('n', '<down>', ':lua require("yvim").next_sibling()<CR>', opts)

-- Better terminal navigation
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
-- keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

------------------------
-- TEXT MANIPULATIONS --
------------------------

-- Move text up and down
keymap("n", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
keymap("n", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)

-- Comment
keymap("n", "<C-_>", ":CommentToggle<CR>", opts)
keymap("i", "<C-_>", "<Esc>:CommentToggle<CR>i", opts)
keymap("v", "<C-_>", ":'<,'>CommentToggle<CR>", opts)

-- easy text substituon
keymap("n", "<leader>sx", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>", opts)

keymap("n", "J", "mzJ`z", opts)

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts)

keymap("n", "gh", "<CMD>diffget //2<CR>", opts)
keymap("n", "gl", "<CMD>diffget //3<CR>", opts)

-- Visual --

-- subs
keymap(
	"n",
	"<leader>y",
	[[:lua vim.cmd('let @" = escape(vim.fn.getreg("\""), "\\/.*$^~[]")') | %s/\V<c-r>//new_text/g<CR>]],
	{ noremap = true, silent = true }
)

-- Comment
keymap("v", "<leader>S", '"fy/\\V<C-R>f<CR>', opts)
-- vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR> -- TODO: add this for easy search

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>==gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>==gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- json formatting
keymap("x", "<leader>jp", ":'<,'>!jq<CR>", opts)
keymap("x", "<leader>jP", ":'<,'>!jq -c<CR>", opts)
keymap("n", "<leader>jp", ":'<,'>!jq<CR>", opts)
-- TODO: fix this
keymap("n", "<leader>jP", ":'<,'>!jq -c<CR>", opts)

-- Replace \n with actual newlines
keymap("x", "<leader>N", ":s/\\\\n/\\r/g<CR>", opts)
keymap("n", "<leader>N", "V:s/\\\\n/\\r/g<CR>", opts)

-- markdown check
keymap("x", "<leader>tc", ":'<,'>s/\\[\\]\\|\\[ \\]/[x]<CR>", opts)

--------------
-- SEARCHES --
--------------

-- Telescopes

keymap("n", "<leader>f", "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false})<cr>", opts)
keymap("n", "<leader>F", "<cmd>Telescope grep_string search= theme=ivy only_sort_text=true<cr>", opts)
keymap("n", "<leader>/", "<cmd>Telescope live_grep search='' theme=ivy only_sort_text=true search_dirs={'%:p'}<cr>", opts)
keymap("n", "<leader>?", "<cmd>Telescope grep_string search='' theme=ivy only_sort_text=true search_dirs={'%:p'}<cr>", opts)
keymap("n", "<leader>b", "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<cr>", opts)
keymap("n", "<leader>r", "<cmd>lua require('telescope.builtin').resume()<cr>", opts)
keymap("n", "<leader>r", "<cmd>lua require('telescope.builtin').resume()<cr>", opts)
keymap("n", "<leader>R", "<cmd>lua require('telescope.builtin').pickers()<cr>", opts)
keymap("n", "<leader>sc", "<cmd>Telescope commands<cr>", opts)
keymap("n", "<leader>so", "<cmd>Telescope colorscheme<cr>", opts)
keymap("n", "<leader>sh", "<cmd>Telescope help_tags<cr>", opts)
keymap("n", "<leader>sM", "<cmd>Telescope man_pages<cr>", opts)
-- keymap("n", "<leader>sm", "<cmd>Telescope harpoon marks<cr>", opts)
keymap("n", "<leader>sm", "<cmd>Telescope grep_string<cr>", opts)
keymap("n", "<leader>ss", "<cmd>Telescope grep_string<cr>", opts)
keymap("n", "<leader>sy", "<cmd>Telescope grep_string search= only_sort_text=true<cr>", opts)
-- keymap("n", "<leader>ss", "<cmd>Telescope live_string search= theme=ivy<cr>", opts)
-- keymap("n", "<leader>sf", "<cmd>Telescope live_grep search= theme=ivy<cr>", opts)
keymap("n", "<leader>sf", "<cmd>Telescope live_grep search= <cr>", opts)
keymap("n", "<leader>sd", "<CMD>lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>", opts)
keymap("n", "<leader>sk", "<CMD>Telescope keymaps<CR>", opts)

-----------
-- MISCS --
-----------

-- Press jk fast to enter normal mode
keymap("i", "jk", "<ESC>", opts_quick)

-- harpoon mark
keymap('n', "<leader>a", "<cmd>lua require('harpoon.mark').add_file()<CR>", opts)
keymap('n', "<leader>m", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>", opts)

-- debugger mappings
keymap('n', "<F9>", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", opts)
keymap('n', "<F5>", "<cmd>lua require'dap'.continue()<cr>", opts)
keymap('n', "<F3>", "<cmd>lua require'dap'.step_into()<cr>", opts)
keymap('n', "<F4>", "<cmd>lua require'dap'.step_over()<cr>", opts)
keymap('n', "<F2>", "<cmd>lua require'dap'.step_back()<cr>", opts)
keymap('n', "<F8>", "<cmd>lua require'dap'.step_out()<cr>", opts)
keymap('n', "<F7>", "<cmd>lua print('test')<CR>", opts)

-- Copilots
keymap("i", "<C-/>", "copilot#Accept(“<CR>”)", { expr = true, silent = true })
keymap("i", "<C-CR>", "copilot#Accept(“<CR>”)", { expr = true, silent = true })

-- nvimtree
keymap("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", opts)
keymap("n", "<leader>u", "<cmd>UndotreeToggle<cr><CMD>UndotreeFocus<CR>", opts)

-- notes
keymap("n", "<leader>ni", "<cmd>VimwikiIndex 1<cr>", opts)
keymap("n", "<leader>nI", "<cmd>VimwikiDiaryIndex 1<cr>", opts)
keymap("n", "<leader>nd", "<cmd>VimwikiMakeDiaryNote 1<cr>", opts)
keymap("n", "<leader>nf", "<cmd>Telescope vimwiki<cr>", opts)
keymap("n", "<leader>nF", "<cmd>Telescope vimwiki live_grep<cr>", opts)


-- buffer manipulations
keymap("n", "<leader>w", "<cmd>w!<CR>", opts)
keymap("n", "<leader>q", "<cmd>q!<CR>", opts)
keymap("n", "<leader>x", "<cmd>Bdelete!<CR>", opts)
keymap("n", "<leader>X", [[<cmd>%bdelete|edit #|normal `"<CR>]], opts)

keymap("n", "<leader>h", "<cmd>nohlsearch<CR>", opts)

keymap("n", "<leader>H", "<cmd>CloakToggle<CR>", opts)
keymap("n", "<leader>T", "<cmd>TransparentToggle<CR>", opts)

keymap("n", "<leader>c", "<CMD>lua require('harpoon.cmd-ui').toggle_quick_menu()<CR>", opts)

--------------------------------
-- PACKAGE AND LSP MANAGEMENT --
--------------------------------

---------
-- GIT --
---------

keymap("n", "<leader>G", "<cmd>Git<CR>", opts)
keymap("n", "<leader>gg", "<cmd>Git<CR>", opts)
keymap("n", "<leader>gm", "<cmd>Git<CR>", opts)
keymap("n", "<leader>gj", "<cmd>lua require 'gitsigns'.next_hunk()<cr>", opts)
keymap("n", "<leader>gk", "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", opts)
keymap("n", "<leader>gl", "<cmd>lua require 'gitsigns'.blame_line()<cr>", opts)
keymap("n", "<leader>gp", "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", opts)
keymap("n", "<leader>gP", "<cmd>Git pull<cr>", opts)
keymap("n", "<leader>gH", "<cmd>Git push -u origin HEAD<cr>", opts)
keymap("n", "<leader>ge", "<cmd>Git commit --allow-empty -m 'empty commit'<cr>", opts)
keymap("n", "<leader>gr", "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", opts)
keymap("n", "<leader>gR", "<cmd>lua require 'gitsigns'.refresh()<cr>", opts)
keymap("n", "<leader>gs", "<cmd>Telescope git_stash<cr>", opts)
keymap("n", "<leader>gu", "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>", opts)
keymap("v", "<leader>ga", ":'<,'>Gitsigns stage_hunk { range = true }<CR>", opts)
keymap("n", "<leader>go", "<cmd>Telescope git_status<cr>", opts)
keymap("n", "<leader>gb", "<cmd>lua require('telescope.builtin').git_branches(require('telescope.themes').get_dropdown{previewer = false})<cr>", opts)
keymap("n", "<leader>gc", "<cmd>Telescope git_commits<cr>", opts)
keymap("n", "<leader>gC", "<cmd>Telescope git_bcommits<cr>", opts)
keymap("n", "<leader>gd", "<cmd>Gitsigns diffthis HEAD<cr>", opts)
keymap("n", "<leader>gws", "<cmd>Telescope git_worktree git_worktrees theme=dropdown<cr>", opts)
keymap("n", "<leader>gwc", "<cmd>Telescope git_worktree create_git_worktree<cr>", opts)

---------
-- LSP --
---------

keymap("n", "<leader>la", "<cmd>lua require('actions-preview').code_actions()<cr>", opts)
keymap("n", "<leader>ld", "<cmd>Telescope diagnostics bufnr=0<cr>", opts)
keymap("n", "<leader>lw", "<cmd>Telescope diagnostics<cr>", opts)
keymap("n", "<leader>lf", "<cmd>lua require('conform').format()<cr>", opts)
keymap("n", "<leader>li", "<cmd>LspInfo<cr>", opts)
keymap("n", "<leader>lR", "<cmd>LspRestart<cr>", opts)
keymap("n", "<leader>lI", "<cmd>Mason<cr>", opts)
keymap("n", "<leader>lj", "<cmd>lua vim.diagnostic.goto_next()<CR>zz", opts)
keymap("n", "<leader>lk", "<cmd>lua vim.diagnostic.goto_prev()<CR>zz", opts)
keymap("n", "<leader>lk", "<cmd>lua vim.diagnostic.goto_prev()<CR>zz", opts)
keymap("n", "<leader>ll", "<cmd>lua vim.lsp.codelens.run()<cr>", opts)
keymap("n", "<leader>lq", "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>", opts)
keymap("n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
keymap("n", "<leader>lR", "<cmd>Telescope lsp_references<cr>", opts)
keymap("n", "<leader>ls", "<cmd>Telescope lsp_document_symbols<cr>", opts)
keymap("n", "<leader>lS", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", opts)
keymap("n", "<leader>ln", "<cmd>lua require('ts-node-action').node_action()<CR>", opts)

--------------
-- TERMINAL --
--------------

keymap("n", "<leader>th", "<cmd>ToggleTerm direction=horizontal<cr>", opts)
keymap("n", "<leader>tv", "<cmd>ToggleTerm direction=vertical<cr>", opts)
keymap("n", "<leader>tp", "<cmd>ToggleTerm direction=vertical<cr>", opts)
keymap("n", "<leader>t1", "<cmd>lua require('harpoon.tmux').gotoTerminal(1)<CR>", opts)
keymap("n", "<leader>t2", "<cmd>lua require('harpoon.tmux').gotoTerminal(2)<CR>", opts)
keymap("n", "<leader>t3", "<cmd>lua require('harpoon.tmux').gotoTerminal(3)<CR>", opts)

----------
-- VENN --
----------

-- venn.nvim: enable or disable keymappings
function _G.Toggle_venn()
    local venn_enabled = vim.inspect(vim.b.venn_enabled)
    if venn_enabled == "nil" then
        vim.b.venn_enabled = true
        vim.cmd[[setlocal ve=all]]
        -- draw a line on HJKL keystokes
        vim.api.nvim_buf_set_keymap(0, "n", "J", "<C-v>j:VBox<CR>", {noremap = true})
        vim.api.nvim_buf_set_keymap(0, "n", "K", "<C-v>k:VBox<CR>", {noremap = true})
        vim.api.nvim_buf_set_keymap(0, "n", "L", "<C-v>l:VBox<CR>", {noremap = true})
        vim.api.nvim_buf_set_keymap(0, "n", "H", "<C-v>h:VBox<CR>", {noremap = true})
        -- draw a box by pressing "f" with visual selection
        vim.api.nvim_buf_set_keymap(0, "v", "f", ":VBox<CR>", {noremap = true})
    else
        vim.cmd[[setlocal ve=]]
        vim.api.nvim_buf_del_keymap(0, "n", "J")
        vim.api.nvim_buf_del_keymap(0, "n", "K")
        vim.api.nvim_buf_del_keymap(0, "n", "L")
        vim.api.nvim_buf_del_keymap(0, "n", "H")
        vim.api.nvim_buf_del_keymap(0, "v", "f")
        vim.b.venn_enabled = nil
    end
end
-- toggle keymappings for venn using <leader>v
vim.api.nvim_set_keymap('n', '<leader>v', ":lua Toggle_venn()<CR>", { noremap = true})
