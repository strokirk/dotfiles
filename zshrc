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

plugins=(git brew fabric)

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

export DOTFILES_DIR="$HOME/.dotfiles"
export DROPBOX_CODE_DIR="$HOME/Dropbox/Code"
export LOCAL_CODE_DIR="$HOME/dev"

#  Aliases {{{ #
if [ $(uname) = 'Darwin' ]; then
    unalias ls l la ll
    if [ -f $(which gls) ]; then
        alias ls='gls -hlpG --group-directories-first --color=auto --time-style=long-iso'
    fi
else
    alias ls='ls --color=auto'
    alias l='ls -CF --group-directories-first'
    alias la='ls -A'
    alias ll='ls -alF --time-style=long-iso'
fi

alias pgrep='pgrep -lf' # sane default for pgrep, long list and match against argument name

alias help="run-help" # help is called run-help in zsh
alias svim="sudo vim"
alias v="vim"
alias rc='$EDITOR ~/.zshrc'
alias hist='$EDITOR $HISTFILE'
alias reload='source ~/.zshrc'
alias dot='cd $DOTFILES_DIR'
alias code='cd $DROPBOX_CODE_DIR'

# Utilize some Swedish characters for a more comfortable shell
bindkey -s ¨ /
bindkey -s £ '$(!!)'
bindkey -s ª '${EDITOR} -q <(!!)'

bindkey ^O forward-word
bindkey ^P backward-word

#  Git aliases {{{ #
alias gc="git checkout"
alias gcm="git commit -ev -m"
alias gcom="git-verbose-commit"
alias gp="git pull"
alias grbm="git rebase --interactive master"

alias gec='$EDITOR $(git changed)'
alias gbf='$EDITOR $(git branch-files)'

alias gs="git status"
alias gw="git show --decorate"
alias gd="git diff"
alias gds="git diff --staged"
alias gl="git lil"
alias glm="git log --decorate origin/master...HEAD"
alias glmp="glm -p"

alias gap="git add --patch"
alias gcp="git checkout --patch"
alias gup="git reset --patch HEAD"
alias gec='$EDITOR $(git changed)'
alias gbf='$EDITOR $(git branch-files)'

alias gb='$DOTFILES_DIR/bin/git-list-branches'
alias gcb=git-change-branch

alias git-prune-merged="git checkout master && git pull --prune && git-delete-merged"
alias gpm="git-prune-merged"
alias grf="git-rfr"
#  }}} Git aliases #
#
#  }}} Aliases #

#  Custom Functions {{{ #

#  Git Functions {{{ #
function git-verbose-commit() {
  if [ $# -eq 0 ]; then
      git commit --verbose;
  else
      git commit --verbose --edit -m "$@";
  fi;
}

function git-change-branch() {
    [ -z "$1" ] && return 1
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

function git-commits-per-branch() {
  [ -z "$1" ] && return 1
  echo "# author:$1"
  for b in $(git branch | sed 's/[* ]*//; /^master$/d');
    do echo $(git log --author=$1 --oneline master..$b | wc -l) "\t" "$b";
  done
}

function git-rfr() {
  [ $(command -v ghi 2>&1) ] || return 1
  [ $# -ne 1 ] && exit 1
  ghi label $1 -a "Ready for Review";
}

# fbr - checkout git branch with fzf
function fbr() {
  local branches branch
  branches=$(git branch -vv) &&
  branch=$(echo "$branches" | fzf +m) &&
  git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
}
#  }}} Git Functions #

function manflag() {
  if [ $# -eq 2 ]; then
    # sed: delete all lines except lines between the searched flag and next empty line, then delete empty lines
    man $1 2>/dev/null | sed '/^ *'"$2"'/,/^$/ !d; /^$/d';
  else
    echo "Usage: manflag <package> <flag>";
  fi;
}

function alert() {
    # Pops a desktop notification with an icon based on the exit status. (from Ubuntu default bashrc)
    [ $(command -v notify-send 2>&1) ] || return 1
    lvl=$([ $? = 0 ] && echo terminal || echo error)
    msg = $(history | tail -n1 | sed -e 's/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//')
    notify-send --urgency=low -i "${lvl}" "${msg}"
}

#  }}} Custom Functions #

export FZF_DEFAULT_OPTS="--bind ctrl-x:toggle-sort"

# FZF by junegunn
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# Nix package manager
[ -f ~/.nix-profile/etc/profile.d/nix.sh ] && source /Users/dan/.nix-profile/etc/profile.d/nix.sh
# Virtualenvwrapper
[ -f /usr/local/bin/virtualenvwrapper.sh ] && source /usr/local/bin/virtualenvwrapper.sh
# Local settings that should not be committed
[ -f $DOTFILES_DIR/local_zshrc ] && source $DOTFILES_DIR/local_zshrc
