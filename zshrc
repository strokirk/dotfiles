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

# Completion
fpath=($BREW_PREFIX/share/zsh/site-functions $fpath)
fpath=($HOME/.zsh/completion $fpath)
autoload -Uz compinit
compinit


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

export RIPGREP_CONFIG_PATH="$DOTFILES_DIR/ripgreprc"
export FZF_DEFAULT_OPTS="--bind ctrl-x:toggle-sort"
export HOMEBREW_NO_AUTO_UPDATE=1
export DIRENV_LOG_FORMAT=

export PATH="$PATH:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
export PATH="$PATH:$DOTFILES_DIR/bin"
export PATH="$HOME/.local/bin:$PATH"
typeset -aU path  # Deduplicate PATH

export TIME_STYLE="long-iso"
export BLOCK_SIZE="'1"

source_if_exists "$DOTFILES_DIR/zsh/git.zsh"
source_if_exists "$DOTFILES_DIR/zsh/aliases.zsh"

# Use Ctrl-O and Ctrl-P to move cursor one word backward/forwards
bindkey ^O backward-word
bindkey ^P forward-word

bindkey ^W backward-kill-word
bindkey ^F kill-word

# FZF by junegunn
source_if_exists $HOME/.fzf.zsh

# Powerlevel10k / p10k
# To customize prompt, run `p10k configure` or edit this manually
source_if_exists $HOME/.p10k.zsh
# Compiled p10k output
source_if_exists /opt/homebrew/opt/powerlevel10k/powerlevel10k.zsh-theme

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
