local status_ok, harpoon = pcall(require, "harpoon")
if not status_ok then
    return
end

harpoon.setup({
    -- enter_on_sendcmd = true,
    -- mark_branch = true,
})

local tele_status_ok, telescope = pcall(require, "telescope")
if not tele_status_ok then
	return
end
telescope.load_extension("harpoon")

-- -- from harpoon2 branch
-- local status_ok, harpoon = pcall(require("harpoon"))
-- if not status_ok then
-- 	return
-- end
-- harpoon:setup({ settings = {}, global_settings = {} })

-- -- basic telescope configuration
-- local conf = require("telescope.config").values
-- local function toggle_telescope(harpoon_files)
-- 	local file_paths = {}
-- 	for _, item in ipairs(harpoon_files.items) do
-- 		table.insert(file_paths, item.value)
-- 	end

-- 	require("telescope.pickers")
-- 		.new({}, {
-- 			prompt_title = "Harpoon",
-- 			finder = require("telescope.finders").new_table({
-- 				results = file_paths,
-- 			}),
-- 			previewer = conf.file_previewer({}),
-- 			sorter = conf.generic_sorter({}),
-- 		})
-- 		:find()
-- end

-- -- vim.keymap.set("n", "<C-e>", function() toggle_telescope(harpoon:list()) end,
-- --     { desc = "Open harpoon window" })

-- -- local harpoon = require("harpoon")

-- -- -- REQUIRED
-- -- harpoon:setup()
-- -- -- REQUIRED

-- -- vim.keymap.set("n", "<leader>a", function() harpoon:list():append() end)
-- -- vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

-- -- vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end)
-- -- vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end)
-- -- vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end)
-- -- vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end)
-- -- vim.keymap.set("n", "<leader>5", function() harpoon:list():select(5) end)

-- -- -- Toggle previous & next buffers stored within Harpoon list
-- -- vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end)
-- -- vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end)
