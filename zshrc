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
export DOTFILES_DIR="$HOME/.dotfiles"

export ZPLUG_HOME="$BREW_PREFIX/opt/zplug"
source_if_exists $ZPLUG_HOME/init.zsh

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

source_if_exists "$DOTFILES_DIR/zsh/options.zsh"
source_if_exists "$DOTFILES_DIR/zsh/git.zsh"
source_if_exists "$DOTFILES_DIR/zsh/aliases.zsh"

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
