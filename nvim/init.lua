-- VIMRC SETTINGS

-- OPTIONS & SETTINGS
require("config/settings")

vim.env.MYVIMRCDIR = vim.fs.dirname(vim.env.MYVIMRC)

-- MAPPINGS, COMMANDS & AUTOCOMMANDS
require("config/keymaps")

-- PLUGINS
-- Load plugins from plugins/init and sibling files
require("bootstrap")
require("lazy").setup({ { import = "plugins" } }, { change_detection = { notify = false } })

-- Colorscheme
vim.cmd("silent! colorscheme molokai")

--
-- NOTES
--
-- TODO: Ännu snabbare mapping för viW och viw
-- TODO: Sortera inline ([a, c, b] -> [a, b, c])
-- TODO: Bättre text-obj för [{("'indent
-- TODO: Bättre shortcut for bokmärken
-- TODO: Bättre listning av saker som :reg och :ls
-- TODO: Better quickfix management
-- TODO: cd into config for the vimrc window
-- TODO: map for opening the plugin in github
-- TODO: Autoupdate settings files
-- TODO: require-if-exists('local')
-- TODO: require-if-exists('local-plugins')

-- STUDY: Multicursor
