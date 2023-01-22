# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# vim: foldmethod=marker
function source_if_exists() { [ -f "$1" ] && source "$1" }

# From brew --prefix
BREW_PREFIX="/opt/homebrew"

export ZPLUG_HOME="$BREW_PREFIX/opt/zplug"
source_if_exists $ZPLUG_HOME/init.zsh

export DOTFILES_DIR="$HOME/.dotfiles"

if [ $(command -v zplug) ]; then
  # Add automatic colors to iterm tabs based on current directory
  zplug "$DOTFILES_DIR/zsh/iterm-fast-tabcolor/", from:local
  # Add Fish-like syntax highlighting
  zplug "zdharma-continuum/fast-syntax-highlighting", defer:2
  # Add Fish-like autosuggestions for zsh
  zplug "zsh-users/zsh-autosuggestions"
  # Add `z` command to jump to frequently used directories
  zplug plugins/z, from:oh-my-zsh
  # Auto-completion
  zplug plugins/brew, from:oh-my-zsh
  zplug plugins/docker, from:oh-my-zsh
  zplug plugins/gitfast, from:oh-my-zsh
  zplug load
fi

source_if_exists "$DOTFILES_DIR/zsh/git.zsh"

fpath=($HOME/.zsh/completion $fpath)

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
unsetopt BEEP                   # No beeps!

#
# Environment (some by oh-my-zsh)
#
export LC_ALL='en_US.UTF-8'
export LANG='en_US.UTF-8'
export EDITOR='nvim'

export CLOUD_DIR="$HOME/iCloud"
export CLOUD_CODE_DIR="$CLOUD_DIR/Code"
export CLOUD_NOTES_DIR="$HOME/Notes"

export LOCAL_CODE_DIR="$HOME/dev"
export GOPATH="$LOCAL_CODE_DIR/go"
export GOBIN="$GOPATH/bin"
export NPM_PACKAGES="$HOME/.npm-packages"
export NODE_PATH="$NPM_PACKAGES/lib/node_modules${NODE_PATH:+:$NODE_PATH}"

export RIPGREP_CONFIG_PATH="$DOTFILES_DIR/ripgreprc"
export FZF_DEFAULT_OPTS="--bind ctrl-x:toggle-sort"
export HOMEBREW_NO_AUTO_UPDATE=1

export PATH="$PATH:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
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
alias ela="el -a"
alias l="el"

# Sane defaults
alias ps='ps -jh' # -j Show more columns, -h show header multiple times for long output
alias pgrep='pgrep -lf' # long list and match against argument name
alias whence="whence -avs"  # show exact origin of command

alias t=task
alias b="buku -p"
alias j=just
alias log="(cd $CLOUD_NOTES_DIR/ && $EDITOR log-notes.md)"

alias p=python
alias pt=pytest
alias bp=bpython

alias :wq=exit
alias help="run-help" # help is called run-help in zsh
alias svim="sudo vim"
alias ni="nvim"
alias nit='nvim -t'
alias rc='$EDITOR ~/.zshrc'
alias nrc="nvim -c 'e \$MYVIMRC'"
alias hist='$EDITOR $HISTFILE'
alias reload='source ~/.zshrc'
alias dot='cd $DOTFILES_DIR'
alias cod='cd $CLOUD_CODE_DIR'
alias docs='cd $CLOUD_NOTES_DIR'

alias notes='(cd $CLOUD_NOTES_DIR && $EDITOR .)'

# Use Ctrl-O and Ctrl-P to move cursor one word backward/forwards
bindkey ^O backward-word
bindkey ^P forward-word

bindkey ^W backward-kill-word
bindkey ^F kill-word
#  }}} Aliases #

#  Custom Functions {{{ #

# zf - switch to directory with fzf
function zf() {
  local directories dir
  directories=$(z -l $@ | awk '{ print $2 }')
  dir=$(echo "$directories" | fzf +m) &&
  cd "$dir"
}

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
    # Print README file
    glow README.md
}

function dated() { date +"%Y-%m-%d" }
function datet() { date +"%Y-%m-%d+%H%M" }

function nvim-fzf-files() {
    local line
    line=$(fd | fzf --multi --exit-0 --select-1 --query="$@") &&
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
alias w="watchexec -r --"

function rgp() { rg "$*" }
alias rgu="rg -u --hidden -M200 -g '!.git/'"
function nag() { $EDITOR -q <(ag "$@") }
function nrg() { $EDITOR -q <(rg --vimgrep "$@") }

function tar-sizes() { tar -ztvf $1 2>&1 | awk '{print $5 "\t" $9}' | sort -k2 }
function tar-diff() { diff -y --suppress-common-lines <(tar-sizes $1) <(tar-sizes $2) }

function x-piprot() { piprot $1 -o | sort -k 4 -n | tee piprot.txt }
function pip-to-be-square() { pip freeze | sd "(.*)==.*" '$1' | grep -v '^#' | grep -v '^-' | xargs -n5 pip install -U --pre }
function github-browse() { hub browse $(git remote get-url origin | sd '.*:(.*).git' '$1')/tree/master/$1 }
function pytest-changed-files() {
  pytest $(echo $(git branch-files) $(git changed) | sd '^([^/]*)/.*' '$1' | sort | uniq)
}

alias x-git-rebase-on=git-rebase-on
alias x-github-browse=github-browse
alias x-pip-to-be-square=pip-to-be-square
alias x-pytest-changed-files=pytest-changed-files

alias pc='pre-commit run --files $(git branch-files) $(git changed)'
alias pca='pc && pre-commit run --files $(git branch-files) $(git changed) --config ~/.pre-commit-config.yaml'

# Smaller, more readable docker ps output
function docker-ps() { docker ps $@ --format "table {{.ID}}\t{{.Image}}\t{{.Names}}\t{{.CreatedAt}}\t{{.Status}}"; }
alias dps=docker-ps
alias drm='docker run --rm -it'
alias docker-this='docker run -it --rm -v $(realpath .):/app -w /app'

#  }}} Custom Functions #



# FZF by junegunn
source_if_exists $HOME/.fzf.zsh

if [ -n "$(command -v pyenv)" ]; then
    # eval "$(pyenv init -)"
    export PYENV_ROOT="$HOME/.pyenv"
    export PYENV_SHELL=zsh
    export PYENV_VIRTUALENV_DISABLE_PROMPT=1
    export PATH="$PYENV_ROOT/shims:${PATH}"
    eval "$(pyenv virtualenv-init -)"
fi;

# Local settings that should not be committed
source_if_exists ~/zshrc.local

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
source_if_exists "$HOME/.p10k/powerlevel10k.zsh-theme"
source_if_exists "$HOME/.p10k.zsh"
