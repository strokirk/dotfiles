format:
    pre-commit run -a

install:
    just brew
    just tools-py
    just tools-js

tools-py:
    uv tool install cookiecutter
    uv tool install mypy
    uv tool install piprot
    uv tool install pre-commit
    # uv tool install sqlformat
    # uv tool install myougiden

tools-js:
    # bun install --global
    # pnpm install --global
    yarn global add npm-check
    yarn global add prettier
    yarn global add sortier

brew:
    brew install -q task buku lazydocker tig tokei tree hivemind hyperfine
    brew install -q zsh ncdu pipx pstree xsv httpie gnu-sed ripgrep sd jq yq just
    brew install -q neovim emojify fzf fd eza universal-ctags zplug bat glow
    brew install -q romkatv/powerlevel10k/powerlevel10k ruff uv mise

    # Casks
    brew install --cask bitwarden
    brew install --cask dash
    brew install --cask docker
    brew install --cask iterm2
    brew install --cask karabiner-elements
    brew install --cask numi
    brew install --cask obsidian
    brew install --cask pop
    brew install --cask raycast
    brew install --cask shottr
    brew install --cask slack
    brew install --cask spotify
    brew install --cask tableplus
    brew install --cask visual-studio-code
    brew install --cask zoom
