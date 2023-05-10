local function buf_only()
    vim.cmd([[%bdelete|edit #|normal `"]])
end
local function buf_none()
    vim.cmd([[%bdelete|normal `"]])
end

vim.api.nvim_create_user_command("BufNone", buf_none, { desc = "Close all buffers" })
vim.api.nvim_create_user_command("BufOnly", buf_only, { desc = "Close other buffers" })
local function hello()
    print("hello")
end
