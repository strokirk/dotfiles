#
# Options
# Note: Zsh ignores case and underscores in option names
#
# History options
export HISTSIZE=200000
export SAVEHIST=200000
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

# Use Ctrl-O and Ctrl-P to move cursor one word backward/forwards
bindkey ^O backward-word
bindkey ^P forward-word

bindkey ^W backward-kill-word
bindkey ^F kill-word
