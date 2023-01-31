-- VIMRC SETTINGS

-- OPTIONS & SETTINGS
require("config/settings")

vim.env.MYVIMRCDIR = vim.fs.dirname(vim.env.MYVIMRC)

-- MAPPINGS, COMMANDS & AUTOCOMMANDS
require("config/keymaps")

-- PLUGINS
-- Load plugins from plugins/init and sibling files
require("bootstrap")
require("lazy").setup({ import = "plugins" }, { change_detection = { notify = false } })

-- Colorscheme
vim.cmd("colorscheme molokai")

-- Temporary mappings during experimentation with these plugins
vim.keymap.set("n", "<F4>", ":Git blame<cr>")

vim.keymap.set("n", "<leader><leader>", ":WhichKey<cr>")

vim.keymap.set("n", "<leader>kp", ":CopyFilename<cr>")

vim.keymap.set("n", "<leader>s", ":Telescope grep_string<cr>")
vim.keymap.set("n", "<leader>t", ":Telescope<cr>")

vim.keymap.set("n", "<leader>xd", ":TroubleToggle document_diagnostics<cr>")
vim.keymap.set("n", "<leader>xq", ":TroubleToggle quickfix<cr>")
vim.keymap.set("n", "<leader>xx", ":TroubleToggle<cr>")
vim.keymap.set("n", "gR", ":TroubleToggle lsp_references<cr>")

vim.g.copilot_no_tab_map = true
vim.api.nvim_set_keymap("i", "<C-J>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
--
-- NOTES
--
-- TODO: Ännu snabbare mapping för viW och viw
-- TODO: Sortera inline ([a, c, b] -> [a, b, c])
-- TODO: Bättre text-obj för [{("'indent
-- TODO: Bättre shortcut for bokmärken
-- TODO: Bättre listning av saker som :reg och :ls
-- TODO: Better quickfix management
-- TODO: map for opening the plugin in github
-- TODO: Autoupdate settings files
-- TODO: require-if-exists('local')
-- TODO: require-if-exists('local-plugins')

-- STUDY: Multicursor
