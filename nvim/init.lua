-- VIMRC SETTINGS
require("config/settings")
require("config/keymaps")

require("bootstrap")
require("lazy").setup({
  { import = "plugins/init" },
  { import = "plugins/lsp" },
  { import = "plugins/colorschemes" },
}, require("lazy_options"))

-- Colorscheme
vim.cmd("silent! colorscheme molokai")

-- Override some Lazy.nvim colors to be less bright.
-- Needs to be done after the `require('lazy')` call,
-- see https://github.com/folke/lazy.nvim/discussions/1143
vim.api.nvim_set_hl(0, "LazyDimmed", { link = "Folded" })
vim.api.nvim_set_hl(0, "LazyProp", { link = "Number" })
