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
alias el="eza -l --no-user --git --group-directories-first"
alias ela="el -a"
alias l="el"

# Sane defaults
alias ps='ps -jh' # -j Show more columns, -h show header multiple times for long output
alias pgrep='pgrep -lf' # long list and match against argument name
alias whence="whence -avs"  # show exact origin of command

# Note taking
alias t=task
alias b="buku -p"
alias log="(cd $CLOUD_NOTES_DIR/ && $EDITOR log-notes.md)"

# Programming tools
alias j=just
alias h=hivemind
alias w="watchexec -r"
alias wp="watchexec -r -e py"

alias pq="pueue"
alias pa="pq add --"
alias pqc="pq clean"

alias bp=bpython
alias p=python
alias pt="pytest --no-header"
alias ptn="pytest --no-header -nauto"
alias wpn="wp -- pytest --no-header -nauto"

alias :wq=exit
alias help="run-help" # help is called run-help in zsh
alias ni="nvim"
alias nit='nvim -t'
alias rc='$EDITOR ~/.zshrc'
alias rca='$EDITOR $DOTFILES_DIR/zsh/aliases.zsh'
alias rcl='$EDITOR ~/zshrc.local'
alias nrc="nvim -c 'e \$MYVIMRC'"
alias hist='$EDITOR $HISTFILE'
alias reload='source ~/.zshrc'
alias count='sort | uniq -c | sort -n'

# Quick dirs
alias dot='cd $DOTFILES_DIR'
alias cod='cd $CLOUD_CODE_DIR'
alias docs='cd $CLOUD_NOTES_DIR'
alias notes='(cd $CLOUD_NOTES_DIR && $EDITOR .)'

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
function tar-diff() { diff -y --suppress-common-lines <(tar-sizes $1) <(tar-sizes $2) }
function tar-sizes() { tar -ztvf $1 2>&1 | awk '{print $5 "\t" $9}' | sort -k2 }

function github-browse() { hub browse $(git remote get-url origin | sd '.*:(.*).git' '$1')/tree/master/$1 }
function npmg() { npm install -g "$@" }

alias pc='pre-commit run --files $(git branch-files) $(git changed)'
alias pca='pre-commit run --all-files'

# Smaller, more readable docker ps output
alias docker-this='docker run -it --rm -v $(realpath .):/app -w /app'
alias dps=docker-ps
alias drm='docker run --rm -it'
function docker-ps() { docker ps $@ --format 'table {{.ID}}\t{{.Image}}\t{{.Names}}\t{{.State}} : {{.RunningFor}}'; }

function append-gitignore()        { echo >> .gitignore        "$@" }
function append-gitignore-global() { echo >> ~/.gitignore      "$@" }
function append-gitignore-local()  { echo >> .git/info/exclude "$@" }
function append-ignore()           { echo >> .ignore           "$@" }

#
# PYTHON DEVELOPMENT
#

function pip-install-devtools() { pip install icecream ruff pytest pytest-network pytest-xdist pytest-sugar pytest-django pytest-cov }
function pip-to-be-square() { pip freeze | sd "(.*)==.*" '$1' | grep -v '^#' | grep -v '^-' | xargs -n5 pip install -U --pre }
function py-sitepackages() { python -c 'import site; print(site.getsitepackages()[0])' }
function pytest-changed-files() { pytest $(git-changed-folders) "$@" }
function x-piprot() { piprot $1 -o | sort -k 4 -n | tee piprot.txt }
function ptc() { pytest --cov-report html --cov "$1" "$1" }

#
# SEARCHING
#

function nvim-fzf-files() {
    local line
    line=$(fd | fzf --multi --exit-0 --select-1 --query="$@") &&
    nvim ${line}
}
alias nif=nvim-fzf-files
function nvim-fzf-tags() {
    local line
    [ -e .git/tags ] &&
    line=$(awk '!/^!/ {print $1 "\t" $2}' .git/tags | xsv table -d '\t' | fzf --exit-0 --select-1 --query="$@" | awk '{print $1}') &&
    nvim -t ${line}
}
alias nift=nvim-fzf-tags
function nrg() { $EDITOR -q =(rg --no-heading --with-filename --line-number --column --color=never "$@") }
function nsg() { $EDITOR -q =(sg "$@") }

function rgp() { rg "$*" }
alias rgu="rg -u --hidden -M200 -g '!.git/'"
alias fdu="fd -u --hidden"
