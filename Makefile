link:
	mkdir -p ~/.config
	[ -d ~/.config/nvim ] || ln -s -f $(realpath nvim) ~/.config/nvim
	[ -d ~/.vim ] || ln -s -f $(realpath vim) ~/.vim
	[ -d ~/.dotfiles ] || ln -s -f $(realpath .) ~/.dotfiles
	ln -s -f $(realpath gitconfig) ~/.gitconfig
	ln -s -f $(realpath bashrc) ~/.bashrc
	ln -s -f $(realpath zshrc) ~/.zshrc
	ln -s -f $(realpath tmux.conf) ~/.tmux.conf
	ln -s -f $(realpath taskrc) ~/.taskrc

pipx:
	pipx install sqlformat flake8 mypy isort piprot
	pipx install sncli black cookiecutter myougiden

yarn:
	yarn global add prettier

brew:
	brew install -q tealdeer jq k9s tmux tig tokei tree lazydocker zsh yq youtube-dl
	brew install -q ncdu pipx pstree the_silver_searcher task xsv httpie gnu-sed
	brew install -q mosh neovim entr emojify buku fzf fd exa universal-ctags
	brew cask install docker dropbox iterm2 alfred dash virtualbox spotify simplenot insomnia firefox spectacle slack ukulele

pyenv:
	# Setup python versions
	pyenv install --skip-existing 3.7-dev
	pyenv install --skip-existing 3.6.5
	pyenv install --skip-existing 3.5.5
	pyenv install --skip-existing 2.7.15
	# Neovim 3
	pyenv uninstall -f neovim-3 && pyenv virtualenv 3.6.5 neovim-3
	$$(pyenv prefix neovim-3)/bin/pip install neovim
	# Neovim 2
	pyenv uninstall -f neovim-2 && pyenv virtualenv 2.7.15 neovim-2
	$$(pyenv prefix neovim-2)/bin/pip install neovim
