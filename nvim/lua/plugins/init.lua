-- See also:
-- lua/plugins/testing.lua
-- lua/plugins/lsp.lua

local utils = require("utils")

local plugins = utils.PluginList()

plugins.add({
  "djoshea/vim-autoread", -- Automatically reload files when they change on disk, on more than just BufEnter
  "isobit/vim-caddyfile", -- Syntax highlighting for Caddyfile
  "johmsalas/text-case.nvim", -- Convert text to different cases
  "mg979/vim-visual-multi", -- Multicursor with <c-n>
  "michaeljsmith/vim-indent-object", -- Adds ii ai aI indent-based text objects
  "sjl/clam.vim", -- Easily run Shell commands with :Clam
  "tpope/vim-commentary", -- Adds gc, which toggles line comments on and off
  "tpope/vim-eunuch", -- Adds :Remove, :Move and other useful file management commands
  "tpope/vim-fugitive", -- Adds git integration with :Git blame and :Git write
  "tpope/vim-repeat", -- Adds . to repeat other tpope plugin mappings
  "tpope/vim-surround", -- Adds mappings for changing 'surrounding' characters, like ds( ...
  "wellle/targets.vim", -- Adds more text objects, like aa (arguments), aq (general quotes), ab (general brackets), etc.
})

plugins.add({
  "nvim-neo-tree/neo-tree.nvim",
  "nvim-telescope/telescope.nvim", -- ThePrimaeagen screamed, so I installed it
  { "nvim-lualine/lualine.nvim", opts = { options = { theme = "onedark" } } },
})

plugins.add({
  "github/copilot.vim", -- Github :Copilot
  "ruifm/gitlinker.nvim", -- gitlinker.txt: Copy Github link to file line with <leader>gy
  {
    "haya14busa/vim-asterisk", -- Adds z* anv x_* mappings. 🔍️
    config = function()
      vim.keymap.set("", "*", "<Plug>(asterisk-z*)", { remap = true })
      vim.keymap.set("", "#", "<Plug>(asterisk-z#)", { remap = true })
      vim.keymap.set("", "g*", "<Plug>(asterisk-gz*)", { remap = true })
      vim.keymap.set("", "g#", "<Plug>(asterisk-gz#)", { remap = true })
    end,
  },
})

-- Quickfix related
plugins.add({
  { "fcpg/vim-kickfix", ft = "qf" }, -- Adds 'dd' to discard and entries from the quickfix list
  { "kevinhwang91/nvim-bqf", ft = "qf" }, -- Adds a preview window for the selected quickfix item
  "romainl/vim-qf", -- Adds mappings to toggle quickfix list, and more
  { "folke/trouble.nvim", opts = { auto_preview = false } }, -- Adds :Trouble, another take on the quickfix list
})

-- Lazy loaded
plugins.add({
  "junegunn/vim-easy-align", -- Adds :EasyAlign, that aligns columns of text
  "lewis6991/gitsigns.nvim", -- Adds Git status in sign column
  "stevearc/conform.nvim", -- 🏎️ Blazingly Fast Formatter that Just Works™️
  "stevearc/overseer.nvim", -- Adds :OverseerRun, a code runner
  { "FooSoft/vim-argwrap", cmd = "ArgWrap" }, -- Adds :ArgWrap, which 'unfolds' lists and arguments
  { "ThePrimeagen/refactoring.nvim", lazy = true }, -- Adds lua functions and telescope extensions to extract functions & variables, etc.
  { "andythigpen/nvim-coverage", cmd = "Coverage", config = true }, -- Adds :Coverage, displays code coverage
  { "folke/twilight.nvim", cmd = "Twilight" }, -- Adds :Twilight, a code flashlight
  { "mattn/emmet-vim", cmd = "Emmet" }, -- Adds :Emmet, a HTML boilerplate generator
  { "sQVe/sort.nvim", cmd = "Sort", opts = {} }, -- Adds :Sort, for sorting inside lines
})

--
-- Config
--

vim.g.kickfix_zebra = 0
vim.g.argwrap_tail_comma = 1

-- EasyAlign:
plugins.configure("junegunn/vim-easy-align", {
  cmd = "EasyAlign",
  keys = {
    { "<leader>=", "<Plug>(EasyAlign)", mode = { "x", "n" }, desc = "EasyAlign <motion>" },
  },
})

plugins.configure("lewis6991/gitsigns.nvim", {
  config = true,
  lazy = true,
  event = { "BufReadPre", "BufNewFile" },
})
plugins.configure("ruifm/gitlinker.nvim", {
  dependencies = { "nvim-lua/plenary.nvim" },
  config = true,
})
plugins.configure("stevearc/overseer.nvim", {
  cmd = { "OverseerRun", "OverseerToggle" },
  config = true,
})
plugins.configure("stevearc/conform.nvim", {
  event = { "BufWritePre" },
  cmd = { "ConformInfo", "AutoformatEnable", "AutoformatDisable" },
  keys = {
    { "<F9>", function() require("conform").format() end, desc = "Format document" },
  },
  config = function()
    require("conform").setup({
      formatters_by_ft = {
        javascript = { "prettier" },
        lua = { "stylua" },
        python = { "ruff_fix", "black" },
        typescript = { "prettier" },
        vue = { "prettier" },
        rust = { "rustfmt" },
      },
      format_on_save = function()
        -- Disable with a global or buffer-local variable
        if not vim.g.enable_autoformat then return end
        return { timeout_ms = 500, lsp_fallback = true }
      end,
    })
    -- https://github.com/stevearc/conform.nvim/blob/master/doc/recipes.md#command-to-toggle-format-on-save
    local set_autoformat = function(value)
      return function()
        vim.g.enable_autoformat = value
        local action = vim.g.enable_autoformat and "enabled" or "disabled"
        vim.notify("Autoformat on save " .. action, vim.log.levels.INFO, { title = "conform.nvim" })
      end
    end
    local cmd = vim.api.nvim_create_user_command
    cmd("AutoformatEnable", set_autoformat(true), { desc = "Enable autoformat" })
    cmd("AutoformatDisable", set_autoformat(false), { desc = "Disable autoformat" })
  end,
})
plugins.configure("github/copilot.vim", {
  config = function()
    -- Replace the default <Tab> mapping, since that conflicts with nvim-cmp
    vim.g.copilot_no_tab_map = true
    vim.api.nvim_set_keymap("i", "<C-J>", 'copilot#Accept("<CR>")', { silent = true, expr = true })

    -- Add aliases for mappings require alt key
    vim.keymap.set("i", "ø", "<M-[>", { remap = true }) -- next suggestion
    vim.keymap.set("i", "æ", "<M-]>", { remap = true }) -- prev suggestion
    vim.keymap.set("i", "é", "<M-Right>", { remap = true }) -- accept word from suggestion
  end,
})
plugins.configure("nvim-neo-tree/neo-tree.nvim", {
  dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons", "MunifTanjim/nui.nvim" },
  opts = {
    window = {
      mappings = {
        ["+"] = "expand_all_nodes",
      },
    },
    filesystem = {
      filtered_items = {
        hide_dotfiles = false,
        hide_gitignored = false,
      },
    },
  },
})
plugins.configure("nvim-telescope/telescope.nvim", {
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local ts = require("telescope")
    pcall(function() ts.load_extension("refactoring") end)
    pcall(function()
      ts.load_extension("textcase") -- Convert text to different cases with :TextCaseOpenTelescope
      ts.extensions.textcase.textcase = ts.extensions.textcase.normal_mode -- https://github.com/johmsalas/text-case.nvim/issues/42
    end)
    ts.setup({
      extensions = {
        ast_grep = {
          command = {
            "sg",
            "--json=stream",
          }, -- must have --json=stream
          grep_open_files = false, -- search in opened files
          lang = nil, -- string value, specify language for ast-grep `nil` for default
        },
      },
    })
    local builtin = require("telescope.builtin")
    vim.keymap.set("n", "<C-p>", builtin.git_files, {})
    vim.keymap.set("n", "<leader>s", ":Telescope grep_string<cr>", {})
    vim.keymap.set("n", "<leader>t", function() builtin.builtin({ include_extensions = true }) end)
  end,
})

return plugins.values
