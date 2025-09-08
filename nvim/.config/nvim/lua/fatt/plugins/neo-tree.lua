return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  lazy = false,
  keys = {
    { '\\', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
    { '<leader>e', ':Neotree toggle reveal<CR>', desc = 'NeoTree toggle reveal', silent = true },
  },
  opts = {
    filesystem = {
      hijack_netrw_behavior = "open_current", -- open Neo-tree at current file's dir
      filtered_items = {
        visible = true, -- show hidden files by default
      },
      window = {
        mappings = {
          ['\\'] = 'close_window',
          ['l'] = 'open',
          ["h"] = "close_node",   -- close dir
        },
      },
    },
  },
}
