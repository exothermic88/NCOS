return {
"catppuccin/nvim",
name = "catppuccin",
priority = 1000 ,

config = function()
--require catppuccin
require("catppuccin").setup()
--set the colorscheme to it!
vim.cmd.colorscheme "catppuccin"
end
}
