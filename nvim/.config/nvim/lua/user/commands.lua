local function buf_only()
    vim.cmd([[%bdelete|edit #|normal `"]])
end

local function buf_none()
    vim.cmd([[%bdelete|normal `"]])
end

local function call_tree()
    vim.cmd([[luafile ~/project/nvim-treesitter-lua-test/lua/run.lua]])
end

vim.api.nvim_create_user_command("BufNone", buf_none, { desc = "Close all buffers" })
vim.api.nvim_create_user_command("BufOnly", buf_only, { desc = "Close other buffers" })
vim.api.nvim_create_user_command("CallTree", call_tree, { desc = "Show call tree" })
