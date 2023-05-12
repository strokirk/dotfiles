-- VIMRC SETTINGS

require("config/settings")
require("config/keymaps")

-- PLUGINS: Loads all modules from ./plugins directory:
-- nvim/lua/plugins/init.lua
-- nvim/lua/plugins/lsp.lua
require("bootstrap")
require("lazy").setup({ import = "plugins" }, require("lazy_options"))

-- Colorscheme
vim.cmd("colorscheme molokai")

-- Temporary mappings during experimentation with these plugins
vim.keymap.set("n", "<leader>s", ":Telescope grep_string<cr>")
vim.keymap.set("n", "<leader>t", ":Telescope<cr>")

vim.keymap.set("n", "<leader>xd", ":TroubleToggle document_diagnostics<cr>")
vim.keymap.set("n", "<leader>xq", ":TroubleToggle quickfix<cr>")
vim.keymap.set("n", "<leader>xx", ":TroubleToggle<cr>")
vim.keymap.set("n", "gR", ":TroubleToggle lsp_references<cr>")

vim.keymap.set("n", "<leader>w", "viw")
vim.keymap.set("n", "<leader>W", "viW")
