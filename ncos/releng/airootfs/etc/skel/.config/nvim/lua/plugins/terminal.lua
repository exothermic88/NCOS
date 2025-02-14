return{
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    require("toggleterm").setup({
      size = 10, -- Height for horizontal terminal
      open_mapping = [[<C-\>]], -- Shortcut to toggle the terminal
      shade_terminals = true,
      direction = "float", -- Can be 'vertical', 'horizontal', 'tab', or 'float'
      float_opts = {
        border = "curved",
      },
    })
  end,

}
