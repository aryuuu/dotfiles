return {
  {
    "ThePrimeagen/harpoon",
    branch = "master",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local harpoon = require("harpoon")

      -- Keymaps
      ---- harpoon mark
      vim.keymap.set('n', "<leader>a", "<cmd>lua require('harpoon.mark').add_file()<CR>", {})
      vim.keymap.set('n', "<leader>m", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>", {})
      vim.keymap.set("n", "<leader>t1", "<cmd>lua require('harpoon.tmux').gotoTerminal(1)<CR>", {})
      vim.keymap.set("n", "<leader>t2", "<cmd>lua require('harpoon.tmux').gotoTerminal(2)<CR>", {})
      vim.keymap.set("n", "<leader>t3", "<cmd>lua require('harpoon.tmux').gotoTerminal(3)<CR>", {})
      -- execute selected text
      vim.keymap.set("n", "<leader>te", "<cmd>lua require('harpoon.tmux').gotoTerminal(3)<CR>", {})
      -- Harpoon jumps
      vim.keymap.set("n", "<leader>1", "<cmd>lua require('harpoon.ui').nav_file(1)<CR>", {})
      vim.keymap.set("n", "<leader>2", "<cmd>lua require('harpoon.ui').nav_file(2)<CR>", {})
      vim.keymap.set("n", "<leader>3", "<cmd>lua require('harpoon.ui').nav_file(3)<CR>", {})
      vim.keymap.set("n", "<leader>4", "<cmd>lua require('harpoon.ui').nav_file(4)<CR>", {})
      vim.keymap.set("n", "<leader>5", "<cmd>lua require('harpoon.ui').nav_file(5)<CR>", {})
    end,
  },
}
