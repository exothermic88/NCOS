return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
    -- {"3rd/image.nvim", opts = {}}, -- Optional image support in preview window: See `# Preview Mode` for more information
  },
  

config = function()
require("neo-tree").setup({      
  filesystem = {
      follow_current_file = {
          enabled = true, -- Update Neo-tree when switching buffers
        },
    use_libuv_file_watcher = true, -- Auto-refresh when files change
    hijack_netrw_behavior = "open_current", -- Ensures Neo-tree respects the current directory
    cwd_target = {
      sidebar = "current", -- Shows the current working directory
      tab = "current",
      win = "current",
    },
  }, 
})
vim.keymap.set('n', '<C-n>', ':Neotree toggle filesystem reveal right<CR>', { noremap = true, silent = true })

end

}
