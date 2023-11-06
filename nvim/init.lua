-- VIMRC SETTINGS

require("config/settings")
require("config/keymaps")

-- PLUGINS: Loads all modules from ./plugins directory:
-- nvim/lua/plugins/init.lua
-- nvim/lua/plugins/lsp.lua
require("bootstrap")
require("lazy").setup({ import = "plugins" }, require("lazy_options"))

-- Colorscheme
vim.cmd("silent! colorscheme molokai")

-- Override some Lazy.nvim colors to be less bright.
-- Needs to be done after the `require('lazy')` call,
-- see https://github.com/folke/lazy.nvim/discussions/1143
vim.api.nvim_set_hl(0, "LazyDimmed", { link = "Folded" })
vim.api.nvim_set_hl(0, "LazyProp", { link = "Number" })
