local function buf_only()
    vim.cmd([[%bdelete|edit #|normal `"]])
end

local function buf_none()
    vim.cmd([[%bdelete|normal `"]])
end

local function call_tree()
    vim.cmd([[luafile ~/project/nvim-treesitter-lua-test/lua/run.lua]])
end

local status_ok, telescope = pcall(require, "telescope.builtin")
if not status_ok then
	return
end

-- Custom function to prompt for glob pattern first, then open live_grep
local function live_grep_with_pre_glob()
  -- First prompt: Glob pattern
  vim.ui.input({ prompt = 'Enter glob pattern (e.g., *.lua): ' }, function(glob_pattern)
    if not glob_pattern then return end

    -- os.execute([[ notify-send "Searching for: ]] .. glob_pattern .. [[" ]])
    -- Open live_grep with the specified glob pattern
    telescope.live_grep({
            glob_pattern = glob_pattern,
      -- additional_args = function(opts)
      --   return { "-g", glob_pattern }
      -- end,
    })
  end)
end

vim.api.nvim_create_user_command("BufNone", buf_none, { desc = "Close all buffers" })
vim.api.nvim_create_user_command("BufOnly", buf_only, { desc = "Close other buffers" })
vim.api.nvim_create_user_command("CallTree", call_tree, { desc = "Show call tree" })
vim.api.nvim_create_user_command("TelescopeLiveGrepWithGlob", live_grep_with_pre_glob, { desc = "Telescope live grep with glob" })
