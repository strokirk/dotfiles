format:
	pre-commit run -a

link:
	mkdir -p ~/.config
	[ -d ~/.config/nvim ] || ln -s -f "$(realpath nvim)" ~/.config/nvim
	[ -d ~/.vim ] || ln -s -f "$(realpath vim)" ~/.vim
	[ -d ~/.dotfiles ] || ln -s -f "$(realpath .)" ~/.dotfiles
	ln -s -f "$(realpath gitconfig)" ~/.gitconfig
	ln -s -f "$(realpath bashrc)" ~/.bashrc
	ln -s -f "$(realpath zshrc)" ~/.zshrc
	ln -s -f "$(realpath tmux.conf)" ~/.tmux.conf
	ln -s -f "$(realpath taskrc)" ~/.taskrc
	ln -s -f "$(realpath ripgreprc)" ~/.ripgreprc
	touch ~/.hushlogin  # Makes login shells quick and "quiet"

install: link brew tools-py tools-js 

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
	brew install -q bat
	brew install -q brew
	brew install -q buku
	brew install -q emojify
	brew install -q eza
	brew install -q fd
	brew install -q fzf
	brew install -q glow
	brew install -q gnu-sed
	brew install -q hivemind
	brew install -q httpie
	brew install -q hyperfine
	brew install -q install
	brew install -q jq
	brew install -q just
	brew install -q lazydocker
	brew install -q mise
	brew install -q ncdu
	brew install -q neovim
	brew install -q pipx
	brew install -q pstree
	brew install -q ripgrep
	brew install -q romkatv/powerlevel10k/powerlevel10k
	brew install -q ruff
	brew install -q sd
	brew install -q task
	brew install -q tig
	brew install -q tokei
	brew install -q tree
	brew install -q universal-ctags
	brew install -q uv
	brew install -q xsv
	brew install -q yq
	brew install -q zplug
	brew install -q zsh
	
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
