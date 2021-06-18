# Comments via :'<,'>!xargs -n1 -I+ sh -c 'echo brew \"+\" "\#" $(brew info --json + | jq .[0].desc)'

#
# Taps
#

tap "caskformula/caskformula"
tap "caskroom/cask"
tap "homebrew/bundle"
tap "homebrew/cask"
tap "homebrew/core"
tap "homebrew/services"

tap "c-bata/kube-prompt"
tap "cristianoliveira/tap"
tap "derailed/k9s"
tap "edgedb/tap"
tap "github/gh"
tap "loadimpact/k6"
tap "sass/sass"
tap "saulpw/vd"
tap "timberio/brew"
tap "universal-ctags/universal-ctags"

#
# Languages
#

brew "crystal"    # "Fast and statically typed, compiled language with Ruby-like syntax"
brew "elm"        # "Functional programming language for building browser-based GUIs"
brew "elm-format" # "Elm source code formatter, inspired by gofmt"
brew "ghc"        # "Glorious Glasgow Haskell Compilation System"
brew "hadolint"   # "Smarter Dockerfile linter to validate best practices"
brew "janet"      # "Dynamic language and bytecode vm"
brew "kotlin"     # "Statically typed programming language for the JVM"
brew "luarocks"   # "Package manager for the Lua programming language"
brew "nim"        # "Statically typed compiled systems programming language"
brew "openjdk"    # "Development kit for the Java programming language"
brew "pyenv"
brew "pyenv-virtualenv", link: false
brew "shellcheck" # "Static analysis and lint tool, for (ba)sh scripts"
brew "tidy-html5" # "Granddaddy of HTML tools, with support for modern standards"
brew "typescript"
brew "vnu"        # "Nu Markup Checker: command-line and server HTML validator"
brew "yarn"       # "JavaScript package manager"
brew "zig"        # "Programming language designed for robustness, optimality, and clarity"

#
# CLI tools
#

brew "bat"                 # "Clone of cat(1) with syntax highlighting and Git integration"
brew "broot"               # New way to see and navigate directory trees
brew "buku"                # "Powerful command-line bookmark manager"
brew "derailed/k9s/k9s"    # "Kubernetes CLI To Manage Your Clusters In Style!"
brew "dtrx"                # "Intelligent archive extraction"
brew "emojify"             # "Emoji on the command-line :scream:"
brew "entr"                # "Run arbitrary commands when files change"
brew "exa"                 # "Modern replacement for 'ls'"
brew "fd"                  # "Simple, fast and user-friendly alternative to find"
brew "fzf"                 # "Command-line fuzzy finder written in Go"
brew "gnu-sed"             # "GNU implementation of the famous stream editor"
brew "htop"                # "Improved top (interactive process viewer)"
brew "httpie"              # "User-friendly cURL replacement (command-line HTTP client)"
brew "jq"                  # "Lightweight and flexible command-line JSON processor"
brew "just"                # "Handy way to save and run project-specific commands"
brew "lazydocker"          # "Lazier way to manage everything docker"
brew "ncdu"                # "NCurses Disk Usage"
brew "neovim", args: ["HEAD"]
brew "pipx"                # "Execute binaries from Python packages in isolated environments"
brew "pstree"              # "Show ps output as a tree"
brew "pup"                 # "Parse HTML at the command-line"
brew "ranger"              # "File browser"
brew "rename"              # "Perl-powered file rename script with many helpful built-ins"
brew "ripgrep"             # "Search tool like grep and The Silver Searcher"
brew "task"                # "Feature-rich console based todo list manager"
brew "tealdeer"            # "Very fast implementation of tldr in Rust"
brew "the_silver_searcher" # "Code-search similar to ack"
brew "tokei"               # "Program that allows you to count code, quickly"
brew "tree"                # "Display directories as trees (with optional color/HTML output)"
brew "watch"               # "Executes a program periodically, showing output fullscreen"
brew "xsv"                 # "Fast CSV toolkit written in Rust"
brew "youtube-dl"          # "Download YouTube videos from the command-line"
brew "yq"                  # "Process YAML documents from the CLI"

#
# CLI tools - git
#

brew "gh"            # "GitHub command-line tool"
brew "ghi"           # "Work on GitHub issues on the command-line"
brew "git"           # "Distributed revision control system"
brew "git-delta"     # "Syntax-highlighting pager for git and diff output"
brew "colordiff"     # "Color-highlighted diff(1) output"
brew "diff-so-fancy" # "Good-lookin' diffs with diff-highlight and more"
brew "hub"           # "Add GitHub support to git on the command-line"
brew "tig"           # "Text interface for Git repositories"

#
# Other
#

brew "lftp"                 # "Sophisticated file transfer program"
brew "loadimpact/k6/k6"     # "Load testing for the 21st century"
brew "mitmproxy"            # "Intercept, modify, replay, save HTTP/S traffic"
brew "saulpw/vd/visidata"   # "Terminal utility for exploring and arranging tabular data"

brew "caddy"                # "Powerful, enterprise-ready, open source web server with automatic HTTPS"
brew "nginx"                # "HTTP(S) server and reverse proxy, and IMAP/POP3 proxy server"

brew "hstr"                 # "Bash and zsh history suggest box"
brew "zplug"                # "Next-generation plugin manager for zsh"
brew "zsh"
brew "zsh-syntax-highlighting"

brew "coreutils"            # "GNU File, Shell, and Text utilities"
brew "dbmate"               # "Lightweight, framework-agnostic database migration tool"
brew "exercism"             # "Command-line tool to interact with exercism.io"
brew "neomutt"              # "E-mail reader with support for Notmuch, NNTP and much more"
brew "pandoc"               # "Swiss-army knife of markup format conversion"
brew "qemu"                 # "Emulator for x86 and PowerPC"
brew "snapcraft"            # "Package any app for every Linux desktop, server, cloud or device"
brew "terminal-notifier"    # "Send macOS User Notifications from the command-line"
brew "timberio/brew/vector" # "A High-Performance Log, Metrics, and Events Router"
brew "tmux"                 # "Terminal multiplexer"
brew "ansible", link: false
brew "universal-ctags/universal-ctags/universal-ctags", args: ["HEAD"]


#
# Dependencies
#

brew "icu4c", link: true
brew "gmp"      # "GNU multiple precision arithmetic library"
brew "gnupg"    # "GNU Pretty Good Privacy (PGP) package"
brew "jpeg"     # "Image manipulation library"
brew "libmagic" # "Implementation of the file(1) command"
brew "lz4"      # "Extremely Fast Compression algorithm"
brew "plantuml" # "Draw UML diagrams"
brew "utf8proc" # "Clean C library for processing UTF-8 Unicode data"
brew "zlib"     # "General-purpose lossless data-compression library"

#
# Casks
#

cask "1password"
cask "1password-cli"
cask "alfred"
cask "dash"
cask "docker"
cask "dropbox"
cask "firefox"
cask "gifox"
cask "github"
cask "insomnia"
cask "iterm2"
cask "java"
cask "macdown"
cask "ngrok"
cask "sequel-pro"
cask "simplenote"
cask "slack"
cask "spotify"
cask "ukelele"
cask "virtualbox"
cask "visual-studio-code"
cask "zettlr"

#
# Other - manual install
#

# Loom
# Magnet
# Obsidian
# Simplenote
# VS Code
# Enpass
# iTerm2
# Discord
# Insomnia
# Chome Canary
# Messenger
# Karabiner
# Numi
# Skitch
