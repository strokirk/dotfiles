# vim: foldmethod=marker
function source_if_exists() { [ -f "$1" ] && source "$1" }

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
ZSH_THEME="dan"
# ~/.oh-my-zsh/themes/dan.zsh-theme

# Disable marking untracked files under VCS as dirty.
# This makes repository status check for large repositories much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY=true
# Don't check for updates on ZSH startup
DISABLE_UPDATE_PROMPT=true

HIST_STAMPS="yyyy-mm-dd"

plugins=(
    brew docker gitfast     # Auto-completion
    z                       # Add `z` command to jump to frequently used directories
    zsh-autosuggestions     # Add Fish-like autosuggestions for zsh
    zsh-syntax-highlighting # Add syntax highligting to the shell
    iterm-tab-color
)
fpath=($HOME/.zsh/completion $fpath)

source_if_exists $ZSH/oh-my-zsh.sh

#
# Options
# Note: Zsh ignores case and underscores in option names
#
# History options
HISTSIZE=200000
setopt APPEND_HISTORY
setopt EXTENDED_HISTORY         # Save history timestampts
setopt HIST_REDUCE_BLANKS       # Remove superfluous blanks from each command
setopt HIST_VERIFY              # Donot execute history directly, replace old line
setopt HIST_NO_STORE            # Donot write calls to `history` to history file
setopt HIST_EXPIRE_DUPS_FIRST
setopt INC_APPEND_HISTORY       # Enter new lines to history immediately
setopt SHARE_HISTORY            # share command history data
# Other options
setopt INTERACTIVE_COMMENTS     # Enable interactive comments (# on the command line)
setopt MARK_DIRS                # Add "/" if completes directory

#
# Environment (some by oh-my-zsh)
#
export LC_ALL='en_US.UTF-8'
export LANG='en_US.UTF-8'
export EDITOR='nvim'

# export GREP_OPTIONS='--color=auto'
# export PIP_REQUIRE_VIRTUALENV=true

export DOTFILES_DIR="$HOME/.dotfiles"
export DROPBOX_CODE_DIR="$HOME/Dropbox/Code"
export DROPBOX_NOTES_DIR="$HOME/Dropbox/Documents"
export LOCAL_CODE_DIR="$HOME/dev"
export GOPATH="$LOCAL_CODE_DIR/go"
export GOBIN="$GOPATH/bin"
export NPM_PACKAGES="$HOME/.npm-packages"
export NODE_PATH="$NPM_PACKAGES/lib/node_modules${NODE_PATH:+:$NODE_PATH}"
export HOMEBREW_NO_AUTO_UPDATE=1

export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:$PATH"
export PATH="$PATH:$DOTFILES_DIR/bin"
export PATH="$PATH:$HOME/.gem/ruby/2.0.0/bin"
export PATH="$PATH:$GOBIN"
export PATH="$PATH:$HOME/.yarn/bin"
export PATH="$PATH:$NPM_PACKAGES/bin"
export PATH="$HOME/.local/bin:$PATH"
typeset -aU path  # Deduplicate PATH

export TIME_STYLE="long-iso"
export BLOCK_SIZE="'1"

#  Aliases {{{ #
if [ "$(uname)" = "Darwin" ]; then
    unalias ls l la ll 2>/dev/null
    if [ -f "$(which gls)" ]; then
        alias ls='gls -hlpG --group-directories-first --color=auto --time-style=long-iso'
    fi
else
    alias ls='ls --color=auto'
    alias l='ls -CF --group-directories-first'
    alias la='ls -A'
    alias ll='ls -alF --time-style=long-iso'
fi
alias el="exa -l --git --group-directories-first"
alias l="el"

# Sane defaults
alias ps='ps -jh' # -j Show more columns, -h show header multiple times for long output
alias pgrep='pgrep -lf' # long list and match against argument name
alias whence="whence -avs"  # show exact origin of command

alias t=task
alias b="buku -p"
alias log="(cd $DROPBOX_NOTES_DIR/ && $EDITOR log-notes.md)"

alias p=python
alias pt=pytest

alias help="run-help" # help is called run-help in zsh
alias svim="sudo vim"
alias ni="nvim"
alias nit='nvim -t'
alias rc='$EDITOR ~/.zshrc'
alias hist='$EDITOR $HISTFILE'
alias reload='source ~/.zshrc'
alias dot='cd $DOTFILES_DIR'
alias cod='cd $DROPBOX_CODE_DIR'
alias docs='cd $DROPBOX_NOTES_DIR'

alias notes='(cd $DROPBOX_NOTES_DIR && $EDITOR .)'

# Use Ctrl-O and Ctrl-P to move cursor one word backward/forwards
bindkey ^O backward-word
bindkey ^P forward-word

bindkey ^W backward-kill-word
bindkey ^F kill-word

#  Git aliases {{{ #
alias g="git"
alias gc="git checkout"
alias gcm="git commit -ev -m"
alias gcom="git-verbose-commit"
alias gp="git pull"
alias gr="git rebase --interactive"
alias grom="git rebase --interactive master"
alias grc="git rebase --continue"

alias gec='$EDITOR $(git changed)'
alias gep='gec -p'
alias gbf='$EDITOR $(git branch-files)'
alias gbp='gbf -p'

alias ga="git add"
alias gs="git status"
alias gw="git show --decorate"
alias gd="git diff"
alias gds="git diff --staged"
alias gl="git lil"
alias glp="git lil -p"
alias gla="git lil --first-parent HEAD~15..."
alias glap="git lil --first-parent -p HEAD~15..."
alias glm="git log --decorate origin/master...HEAD"
alias glmp="glm -p"

alias gap="git add --patch"
alias gcp="git checkout --patch"
alias gu="git reset ."
alias gup="git reset --patch HEAD"

alias gb='git-list-branches'
alias gcb='git-change-branch'

alias gas="git rebase --autosquash --interactive master"
alias gpm="git-prune-merged"
alias grf="git-add-labels 'Ready for Review'"
alias grup='git reset --hard $(git upstream)'
alias pub='git publish && hub pull-request'

#  }}} Git aliases #
#
#  }}} Aliases #

#  Custom Functions {{{ #

#  Git Functions {{{ #
function git-verbose-commit() {
  if [ $# -eq 0 ]; then
      git commit --verbose;
  else
      git commit --verbose --edit -m "$*";
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
  git branch --merged | sed -E '/^\*|master/d' | xargs git branch -d 2>/dev/null
}

function git-commits-per-branch() {
  [ -z "$1" ] && return 1
  echo "# author:$1"
  for b in $(git branch | sed 's/[* ]*//; /^master$/d');
    do echo $(git log --author=$1 --oneline master..$b | wc -l) "\t" "$b";
  done
}

function git-update-projects() {
    [ "$#" -ne 1 ] && echo "Usage: $0 <dir>" && return 1
    (find $1 -type d -execdir [ -d '{}/.git' ] \; -print -prune | xargs -P9 -I% sh -c 'cd %; git fetch --all -q' &)
}

function git-stack() {
    echo $0 $@
    first=$1
    while [[ $2 ]]; do
        git checkout $2 && git rebase $1
        shift
    done
    git log --oneline --graph $first...
}

function git-pr() {
  git fetch origin pull/$1/head:pr-$1 && git checkout pr-$1
}

# fbr - checkout git branch with fzf
function fbr() {
  local branches branch
  branches=$(git branch -vv) &&
  branch=$(echo "$branches" | fzf +m) &&
  git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
}
#  }}} Git Functions #

# zf - switch to directory with fzf
function zf() {
  local directories dir
  directories=$(z -l $@ | awk '{ print $2 }')
  dir=$(echo "$directories" | fzf +m) &&
  cd "$dir"
}

alias j=z
alias jf=zf

# Thanks @jen20 https://news.ycombinator.com/item?id=25308708
pman() { man -t "$@" | open -f -a Preview; }

function manflag() {
  if [ $# -eq 2 ]; then
    # sed: delete all lines except lines between the searched flag and next empty line, then delete empty lines
    man $1 2>/dev/null | sed '/^ *'"$2"'/,/^$/ !d; /^$/d';
  else
    echo "Usage: manflag <package> <flag>";
  fi;
}

function alert() {
    function _get_prev_command() { echo $(history | tail -n1 | sed -e 's/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//') }
    # Pops a desktop notification with an icon based on the exit status. (from Ubuntu default bashrc)
    err=$?
    if [ $(uname) = 'Darwin' ]; then
        title=$([ err = 0 ] && echo "Finished successfully" || echo "Finished with error")
        msg=$(_get_prev_command)
        if [ $(command -v terminal-notifier) ]; then
            terminal-notifier -title "${title}" -message "${msg}" -sound Basso
        else
            osascript -e 'display notification "'"${msg}"'" with title "'"${title}"'"'
        fi
    else
        [ $(command -v notify-send 2>&1) ] || return 1
        lvl=$([ err = 0 ] && echo terminal || echo error)
        msg=$(_get_prev_command)
        notify-send --urgency=low -i "${lvl}" "${msg}"
    fi
}

if [ $(uname) = 'Linux' ]; then
    alias open=xdg-open
fi

function run() {
    ./$1 "${@:2}"
}

disable r
function r() {
    # Print README files
    f=$(find . -iname 'readme*' -maxdepth 1)
    if [ $(command -v mdless 2>&1) ]; then
        mdless --no-pager $f
    else
        less -FX $f
    fi
}

function dated() { date +"%Y-%m-%d" }
function datet() { date +"%Y-%m-%d+%H%M" }

function nvim-fzf-files() {
    local line
    line=$(ag -g "" | fzf --multi --exit-0 --select-1 --query="$@") &&
    nvim ${line}
}
alias nif=nvim-fzf-files
function nag() { nvim -q <(ag $@) }

function nvim-fzf-tags() {
    local line
    [ -e .git/tags ] &&
    line=$(awk '!/^!/ {print $1 "\t" $2}' .git/tags | xsv table -d '\t' | fzf --exit-0 --select-1 --query="$@" | awk '{print $1}') &&
    nvim -t ${line}
}
alias nift=nvim-fzf-tags
alias h=hivemind

function rgp() { rg "$*" }
alias rgu="rg -u --hidden -M200 -g '!.git/'"
function nag() { $EDITOR -q <(ag "$@") }
function nrg() { $EDITOR -q <(rg --vimgrep "$@") }

function tar-sizes() { tar -ztvf $1 2>&1 | awk '{print $5 "\t" $9}' | sort -k2 }
function tar-diff() { diff -y --suppress-common-lines <(tar-sizes $1) <(tar-sizes $2) }

function x-piprot() { piprot $1 -o | sort -k 4 -n | tee piprot.txt }
function pip-to-be-square() { pip freeze | sd "(.*)==.*" '$1' | grep -v '^#' | grep -v '^-' | xargs pip install -U --pre }
function git-rebase-on() { _r=$(git config branch.$(git symbolic-ref --short HEAD).rebased-on); test $_r && git rebase $_r; }
function github-browse() { hub browse $(git remote get-url origin | sd '.*:(.*).git' '$1')/tree/master/$1 }

alias x-git-rebase-on=git-rebase-on
alias x-github-browse=github-browse
alias x-pip-to-be-square=pip-to-be-square

alias pc='pre-commit run --files $(git branch-files) $(git changed)'
alias pca='pc && pre-commit run --files $(git branch-files) $(git changed) --config ~/.pre-commit-config.yaml'

# Smaller, more readable docker ps output
function docker-ps() { docker ps $@ --format "table {{.ID}}\t{{.Image}}\t{{.Names}}\t{{.CreatedAt}}\t{{.Status}}"; }
alias dps=docker-ps
alias drm='docker run --rm -it'
alias docker-this='docker run -it --rm -v $(realpath .):/data'

#  }}} Custom Functions #

export FZF_DEFAULT_OPTS="--bind ctrl-x:toggle-sort"


# FZF by junegunn
source_if_exists $HOME/.fzf.zsh
# Nix package manager
source_if_exists $HOME/.nix-profile/etc/profile.d/nix.sh
alias nix-installed="nix-env -q --installed --json | jq '.[]| \"- \" + .name + \" :: \" + .meta.description' | xargs -n1 | column -t -s '::'"

if [ -n "$(command -v pyenv)" ]; then
    # eval "$(pyenv init -)"
    export PYENV_ROOT="$HOME/.pyenv"
    export PYENV_SHELL=zsh
    export PYENV_VIRTUALENV_DISABLE_PROMPT=1
    export PATH="$PYENV_ROOT/shims:${PATH}"
    eval "$(pyenv virtualenv-init -)"
fi;


_tabcolor_on_cwd_change() { tc $(echo $PWD | sha256sum | cut -c1-6); };
_tabcolor_on_cwd_change
add-zsh-hook chpwd _tabcolor_on_cwd_change

# Local settings that should not be committed
source_if_exists $DOTFILES_DIR/zshrc.local
