-- -- require("user.winbar").get_winbar()

-- if vim.fn.has("nvim-0.8") == 1 then
-- 	vim.api.nvim_create_autocmd(
-- 		{ "CursorMoved", "CursorHold", "BufWinEnter", "BufFilePost", "InsertEnter", "BufWritePost", "TabClosed" },
-- 		{
-- 			callback = function()
-- 				require("user.winbar").get_winbar()
-- 			end,
-- 		}
-- 	)
-- end
-- -- require("user.winbar")

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup("HighlightYank", {})
autocmd("TextYankPost", {
	group = yank_group,
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({
			higroup = "IncSearch",
			timeout = 40,
		})
	end,
})

local wr_group = augroup('WinResize', { clear = true })
autocmd(
    'VimResized',
    {
        group = wr_group,
        pattern = '*',
        command = 'wincmd =',
        desc = 'Automatically resize windows when the host window size changes.'
    }
)

-- -- Add this temporarily to measure parsing time
-- vim.api.nvim_create_autocmd("BufReadPost", {
--   pattern = "*.zig",
--   callback = function()
--     local start = vim.loop.hrtime()
--     vim.cmd("TSBufEnable highlight")
--     local end_time = vim.loop.hrtime()
--     print(string.format("Treesitter parsing took: %.2f ms", (end_time - start) / 1000000))
--   end,
-- })

-- colorscheme_group
-- local colorscheme_group = augroup("Colorscheme", {})

-- autocmd("BufEnter", {
-- 	group = colorscheme_group,
-- 	pattern = "*.go",
-- 	callback = function()
-- 		vim.cmd("colorscheme catppuccin")
-- 	end,
-- })

-- autocmd("BufEnter", {
-- 	group = colorscheme_group,
-- 	pattern = "*.lua",
-- 	callback = function()
-- 		vim.cmd("colorscheme catppuccin")
-- 	end,
-- })

-- autocmd('ColorScheme', {
--   callback = function()
--     local highlights = {
--       'Normal',
--       'LineNr',
--       'Folded',
--       'NonText',
--       'SpecialKey',
--       'VertSplit',
--       'SignColumn',
--       'EndOfBuffer',
--       'TablineFill', -- this is specific to how I like my tabline to look like
--     }
--     for _, name in pairs(highlights) do vim.cmd.highlight(name .. ' guibg=none ctermbg=none') end 
-- end, 
-- })
