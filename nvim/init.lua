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
