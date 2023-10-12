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

pipx:
	pipx install black
	pipx install cookiecutter
	pipx install flake8
	pipx install isort
	pipx install myougiden
	pipx install mypy
	pipx install piprot
	pipx install pre-commit
	pipx install sqlformat

yarn:
	yarn global add npm-check
	yarn global add prettier
	yarn global add sortier


pip-env:
	pip install flake8-cognitive-complexity pytest pytest-network icecream pytest-xdist pytest-django pytest-cov ruff

brew:
	brew install -q mosh youtube-dl task buku k9s tmux lazydocker tig tokei tree hivemind hyperfine
	brew install -q zsh ncdu pipx pstree xsv httpie gnu-sed ripgrep sd jq yq just
	brew install -q neovim emojify fzf fd eza universal-ctags zplug bat glow
	brew install -q romkatv/powerlevel10k/powerlevel10k ruff
	brew install --cask docker dash insomnia
	brew install --cask spotify
	brew install --cask rectangle
	brew install --cask pop zoom
	brew install --cask obsidian
	brew install --cask visual-studio-code
	brew install --cask iterm2
	brew install --cask slack raycast shottr numi

pyenv:
	# Setup python versions
	pyenv install --skip-existing 3.10.1
	pyenv uninstall -f neovim-3 && pyenv virtualenv 3.10.1 neovim-3
	$$(pyenv prefix neovim-3)/bin/pip install -U pip
	$$(pyenv prefix neovim-3)/bin/pip install -U pynvim
