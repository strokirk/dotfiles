# vim: foldmethod=marker

#  Git aliases {{{ #
alias g="git"
alias gc="git checkout"
alias gcm="git commit -ev -m"
alias gcom="git-verbose-commit"
alias gp="git push"
alias gr="git rebase --interactive"
alias grom="git rebase --interactive master"
alias grc="git rebase --continue"
alias gk="git clean -i ; git checkout . -p"

alias gec='$EDITOR $(git changed)'
alias gep='gec -p'
alias cep='code $(git changed)'
alias gbf='$EDITOR $(git branch-files)'
alias gbp='gbf -p'

alias ga="git add"
alias ga.="git add ."
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
alias gam="git amend"

alias gap="git add --patch"
alias gcp="git checkout --patch"
alias gpf="git push --force-with-lease"
alias gu="git reset ."
alias gup="git reset --patch HEAD"

alias gb='git-list-branches'
alias gcb='git-change-branch'
alias grm='gpm; git-rebase-all'

alias gas="git rebase --autosquash --interactive master"
alias gpm="git-prune-merged"
alias grf="git-add-labels 'Ready for Review'"
alias grup='git reset --hard $(git upstream)'
alias pub='git publish && hub pull-request'
#  }}} Git aliases #

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

function git-rebase-on() {
  branch="$(git symbolic-ref --short HEAD)";
  git config "branch.$branch.rebased-on" "$1";
};

function git-rebase-auto() {
  _r=$(git config branch.$(git symbolic-ref --short HEAD).rebased-on);
  test $_r && git rebase $_r;
}

function git-delete-current-branch() {
  b=$(git symbolic-ref --short HEAD);
  gc master && git branch -D $b;
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
