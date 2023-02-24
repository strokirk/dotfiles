-- Disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

return {
  "mbbill/undotree",
  "FooSoft/vim-argwrap", -- Adds :ArgWrap, which 'unfolds' lists and arguments
  "folke/trouble.nvim", -- Adds :Trouble, another take on the quickfix list
  "isobit/vim-caddyfile", -- Syntax highlighting for Caddyfile
  "johmsalas/text-case.nvim", -- Convert text to different cases
  "mg979/vim-visual-multi", -- Multicursor with <c-n>
  "michaeljsmith/vim-indent-object", -- Adds ii ai aI indent-based text objects
  "sQVe/sort.nvim", -- Sort inside lines with :Sort
  "tomasr/molokai", -- Colorful colorscheme
  "tpope/vim-commentary", -- Adds gc, which toggles line comments on and off
  "tpope/vim-eunuch", -- Adds :Remove, :Move and other useful file management commands
  "tpope/vim-fugitive", -- Adds git integration with :Git blame and :Git write
  "tpope/vim-surround", -- Adds mappings for changing 'surrounding' characters, like ds( ...
  "wellle/targets.vim", -- Adds more text objects, like aa (arguments), aq (general quotes), ab (general brackets), etc.
  {
    "github/copilot.vim", -- Github :Copilot
    config = function()
      -- Replace the default <Tab> mapping, since that conflicts with nvim-cmp
      vim.g.copilot_no_tab_map = true
      vim.api.nvim_set_keymap("i", "<C-J>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
    end,
  },
  {
    "ruifm/gitlinker.nvim", -- gitlinker.txt: Copy Github link to file line with <leader>gy
    dependencies = { "nvim-lua/plenary.nvim" },
    config = true,
  },
  { "nvim-lualine/lualine.nvim", opts = { options = { theme = "onedark" } } },
  {
    "goolord/alpha-nvim", -- Welcome Screen
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local alpha = require("alpha")
      local theme = require("alpha.themes.startify")
      theme.section.bottom_buttons.val = {
        theme.button("c", "  Configuration", ":e $MYVIMRC <CR>"),
        theme.button("q", "  Quit Neovim", ":qa<CR>"),
      }
      alpha.setup(theme.config)
    end,
  },
  {
    "nvim-telescope/telescope.nvim", -- ThePrimaeagen screamed, so I installed it
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<C-p>", builtin.git_files, {})
    end,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
  },
  {
    "haya14busa/vim-asterisk", -- Adds z* anv x_* mappings. 🔍️
    config = function()
      vim.keymap.set("", "*", "<Plug>(asterisk-z*)", { remap = true })
      vim.keymap.set("", "#", "<Plug>(asterisk-z#)", { remap = true })
      vim.keymap.set("", "g*", "<Plug>(asterisk-gz*)", { remap = true })
      vim.keymap.set("", "g#", "<Plug>(asterisk-gz#)", { remap = true })
    end,
  },

  -- Lazy loaded
  { "folke/twilight.nvim", cmd = "Twilight" }, -- Adds :Twilight, a code flashlight
  { "junegunn/vim-easy-align", cmd = "EasyAlign" }, -- Adds :EasyAlign, that aligns columns of text
  { "mattn/emmet-vim", cmd = "Emmet" }, -- Adds :Emmet, a HTML boilerplate generator
  {
    "folke/which-key.nvim", -- Adds :WhichKey, showing keybindings
    cmd = "WhichKey",
    config = function()
      local wk = require("which-key")
      wk.setup()
      local group = function(name, keys) wk.register(keys, { prefix = name }) end
      group("<leader>", {
        [","] = { name = "Neovim config" },
      })
    end,
  },
}
