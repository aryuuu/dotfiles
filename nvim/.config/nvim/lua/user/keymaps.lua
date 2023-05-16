local opts = { noremap = true, silent = true }

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
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<C-S-+>", ":resize -2<CR>", opts)
keymap("n", "<C-S-->", ":resize +2<CR>", opts)
keymap("n", "<C-S-h>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-S-l>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Move text up and down
keymap("n", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
keymap("n", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)

-- Comment
keymap("n", "<C-_>", ":CommentToggle<CR>", opts)

-- tmux-sessionizer
keymap("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>", opts)
keymap("n", "<M-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>", opts)

-- non-disorienting half page jump
keymap("n", "<C-d>", "<C-d>zz", opts)
keymap("n", "<C-u>", "<C-u>zz", opts)

-- xml tag jump
keymap("n", "[t", "vato<Esc>", opts)
keymap("n", "]t", "vat<Esc>", opts)

-- better search navigation
keymap("n", "n", "nzz", opts)
keymap("n", "N", "Nzz", opts)

-- easy text substituon
keymap("n", "<leader>sx", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>", opts)

keymap("n", "gh", "<CMD>diffget //2<CR>", opts)
keymap("n", "gl", "<CMD>diffget //3<CR>", opts)

-- Insert --
-- Press jk fast to enter normal mode
keymap("i", "jk", "<ESC>", opts)
-- Comment line
keymap("i", "<C-_>", "<Esc>:CommentToggle<CR>i", opts)
-- insert in new line, without going to NORMAL mode first
keymap("i", "<M-o>", "<Esc>o", opts)
-- A, without going to NORMAL mode first
keymap("i", "<M-a>", "<Esc>A", opts)
-- I, without going to NORMAL mode first
keymap("i", "<M-i>", "<Esc>I", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts)

-- Comment
keymap("v", "<C-_>", ":'<,'>CommentToggle<CR>", opts)
-- keymap("v", "<leader>S", [[y/\V<C-R>=escape(@",'/\')<CR><CR>]], opts)
keymap("v", "<leader>S", "\"fy/\\V<C-R>f<CR>", opts)
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

-- Terminal --
-- Better terminal navigation
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

-- Nvimtree
-- keymap("n", "<leader>e", ":NvimTreeToggle<cr>", opts)
