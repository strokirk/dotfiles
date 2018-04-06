link:
	[ -d ~/.config/nvim ] || ln -s -f $(realpath nvim) ~/.config/nvim
	[ -d ~/.vim ] || ln -s -f $(realpath vim) ~/.vim
	[ -d ~/.dotfiles ] || ln -s -f $(realpath .) ~/.dotfiles
	ln -s -f $(realpath gitconfig) ~/.gitconfig
	ln -s -f $(realpath bashrc) ~/.bashrc
	ln -s -f $(realpath zshrc) ~/.zshrc
	ln -s -f $(realpath tmux.conf) ~/.tmux.conf
	ln -s -f $(realpath taskrc) ~/.taskrc

pip:
	pip install --user --upgrade autopep8
	pip install --user --upgrade flake8
	pip install --user --upgrade neovim
	pip install --user --upgrade pipenv
	pip install --user --upgrade pytest-watch
	pip install --user --upgrade isort
	pip install --user --upgrade pawk
	pip install --user --upgrade piprot
	pip install --user --upgrade pipsi
