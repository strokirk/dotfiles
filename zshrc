# vim: foldmethod=marker
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
setopt append_history
setopt histignoredups	 # Don't write successive identical lines to history
setopt hist_no_store     # Don't write calls to `history` to history file
setopt hist_ignore_all_dups # Don't write any duplicate commands to history
# Enable interactive comments (# on the command line)
setopt interactivecomments

#
# Environment (some by oh-my-zsh)
#
export LANG='en_US.UTF-8'
export EDITOR='nvim'

export GREP_OPTIONS='--color=auto'

#
# Aliases (some by Oh-my-zsh)
#
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
alias ls='ls --color=auto'
alias l='ls -CF --group-directories-first'
alias la='ls -A'
alias ll='ls -alF --time-style=long-iso'
if [ $(uname) = 'Darwin' ]; then
    unalias ls l la ll
fi

alias help="run-help" # help is called run-help in zsh
alias svim="sudo vim"
alias v="vim"
alias rc='$EDITOR ~/.zshrc'
alias dot='cd ~/.dotfiles'

# Utilize some Swedish characters for a more comfortable shell
bindkey -s ¨ /
bindkey -s £ '$(!!)'
bindkey -s ª '${EDITOR} -q <(!!)'

# Git aliases {{{
alias gc="git checkout"
alias gcm="git commit -m"
alias gp="git pull"

alias gec='$EDITOR $(git changed)'
alias gbf='$EDITOR $(git branch-files)'

alias gs="git status"
alias gw="git show"
alias gd="git diff"
alias gds="git diff --staged"
alias glgm="git log --decorate origin/master...HEAD"

alias gap="git add --patch"
alias gcp="git checkout --patch"
alias gup="git reset --patch HEAD"
alias gec='$EDITOR $(git changed)'
alias gbf='$EDITOR $(git branch-files)'

alias gb=git-list-branches
alias gcb=git-change-branch

function git-list-branches() {
  RED=$(tput setaf 1);
  RESET=$(tput sgr0);
  for branch in $(git branch | sed s/^..//); do
    time_ago=$(git log -1 --pretty=format:"%Cgreen%ci %Cblue%cr%Creset" $branch --);
    # Add a red star to mark branches that are tracking something upstream
    tracks_upstream=$(if [ "$(git rev-parse $branch@{upstream} 2>/dev/null)" ]; then printf "$RED★$RESET"; fi);
    printf "%-53s - %-1s %s\n" "$time_ago" "${tracks_upstream:- }" "$branch";
  done | sort;
}

function git-change-branch() {
    git show-ref --quiet --verify -- "refs/heads/$1"
    if [ $? -eq 0 ]; then
        git checkout "$1"
    else
        git checkout -b "$1"
    fi
}

function git-delete-merged() {
  git branch --merged | sed '/^*\|master/d' | xargs git branch -d 2>/dev/null
}

# fbr - checkout git branch with fzf
function fbr() {
  local branches branch
  branches=$(git branch -vv) &&
  branch=$(echo "$branches" | fzf +m) &&
  git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
}
# end git }}}

function manflag() {
  if [ $# -eq 2 ]; then
    # sed: delete all lines except lines between the searched flag and next empty line, then delete empty lines
    man $1 2>/dev/null | sed '/^ *'"$2"'/,/^$/ !d; /^$/d';
  else
    echo "Usage: manflag <package> <flag>";
  fi;
}

# FZF by junegunn
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
