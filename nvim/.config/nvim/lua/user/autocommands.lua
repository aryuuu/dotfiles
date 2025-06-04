local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup("HighlightYank", {})
autocmd("TextYankPost", {
	group = yank_group,
	pattern = "*",
	callback = function()
		vim.hl.on_yank({
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
