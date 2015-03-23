# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

HIST_STAMPS="yyyy-mm-dd"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

plugins=(git sudo wd)

source $ZSH/oh-my-zsh.sh

# User configuration

export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"
export PATH="$PATH:/opt/rock/bin/"
# export MANPATH="/usr/local/man:$MANPATH"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

#
# Options
#
# Enable interactive comments (# on the command line)
setopt interactivecomments

#
# Environment (some by oh-my-zsh)
#
export LANG='en_US.UTF-8'
export EDITOR='vim'

#
# Aliases (some by Oh-my-zsh)
#
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias grep='grep --color=auto'
alias ls='ls --color=auto'
alias l='ls -CF --group-directories-first'
alias la='ls -A'
alias ll='ls -alF --time-style=long-iso'

alias help="run-help" # help is called run-help in zsh
alias svim="sudo vim"
alias v="vim"
alias rc="vim ~/.zshrc"

alias gap="git ap"
alias gec="git ec"
alias gs="git status"
alias gc="git checkout"

# Utilize some Swedish characters for a more comfortable shell
bindkey -s ¨ /
bindkey -s £ '$()'

# FZFa by junegunn
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
