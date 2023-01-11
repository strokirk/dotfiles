-- VIMRC SETTINGS

-- OPTIONS & SETTINGS
require("config/settings")

-- MAPPINGS, COMMANDS & AUTOCOMMANDS
require("config/keymaps")

require("bootstrap")
require("lazy").setup({ { import = "plugins" } }, { change_detection = { notify = false } })

-- Colorscheme
vim.cmd("silent! colorscheme molokai")

vim.keymap.set("n", "<leader><leader>", ":WhichKey<cr>")
vim.keymap.set("n", "<leader>cc", ":e init.lua<cr>")
vim.keymap.set("n", "<leader>cp", ":e lua/plugins/init.lua<cr>")

--
-- NOTES
--
-- TODO: Ännu snabbare mapping för viW och viw
-- TODO: Sortera inline ([a, c, b] -> [a, b, c])
-- TODO: Bättre text-obj för [{("'indent
-- TODO: Bättre shortcut for bokmärken
-- TODO: Bättre listning av saker som :reg och :ls
-- TODO: Multicursor
-- TODO: Better quickfix management

-- TODO: map for opening the plugin in github
-- TODO: Structure
-- TODO: Autoupdate settings files
-- TODO: require-if-exists('local')
-- TODO: require-if-exists('local-plugins')
