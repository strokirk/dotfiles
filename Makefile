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
	yarn global add prettier npm-check

brew:
	brew install -q tealdeer jq k9s tmux tig tokei tree lazydocker zsh yq youtube-dl
	brew install -q ncdu pipx pstree the_silver_searcher task xsv httpie gnu-sed
	brew install -q mosh neovim entr emojify buku fzf fd exa universal-ctags zplug
	brew install -q romkatv/powerlevel10k/powerlevel10k
	brew install --cask docker dash insomnia
	brew install --cask spotify
	brew install --cask rectangle
	brew install --cask docker dropbox iterm2 alfred dash virtualbox spotify simplenote insomnia firefox spectacle slack ukulele

pyenv:
	# Setup python versions
	pyenv install --skip-existing 3.10.1
	pyenv uninstall -f neovim-3 && pyenv virtualenv 3.10.1 neovim-3
	$$(pyenv prefix neovim-3)/bin/pip install -U pip
	$$(pyenv prefix neovim-3)/bin/pip install -U pynvim
