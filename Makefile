link:
	ln -s -f $(realpath nvim) ~/.nvim
	ln -s -f $(realpath vim) ~/.vim
	ln -s -f $(realpath gitconfig) ~/.gitconfig
	ln -s -f $(realpath bashrc) ~/.bashrc
	ln -s -f $(realpath zshrc) ~/.zshrc
	ln -s -f $(realpath tmux.conf) ~/.tmux.conf

pip:
	pip install --user --upgrade autopep8
	pip install --user --upgrade flake8
	pip install --user --upgrade neovim
