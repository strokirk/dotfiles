return {
  -- Update nvim settings on file change, but silently
  change_detection = { enabled = true, notify = false },
  -- Use Emoji instead of Nerd Fonts, to make it work without font installation
  ui = {
    icons = {
      cmd = "⌘",
      config = "🛠",
      event = "📅",
      ft = "📂",
      init = "⚙",
      keys = "🗝",
      plugin = "🔌",
      runtime = "💻",
      source = "📄",
      start = "🚀",
      task = "📌",
      lazy = "💤 ",
    },
  },
}
