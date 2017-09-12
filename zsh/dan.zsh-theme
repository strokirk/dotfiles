# vim: ft=zsh

# disables prompt mangling in virtual_env/bin/activate
export VIRTUAL_ENV_DISABLE_PROMPT=1

function _virtualenv_prompt {
    [[ -n ${VIRTUAL_ENV} ]] || return
    echo "${ZSH_THEME_VIRTUAL_ENV_PROMPT_PREFIX:=(}${VIRTUAL_ENV:t}${ZSH_THEME_VIRTUAL_ENV_PROMPT_SUFFIX:=) }"
}

function _git_prompt {
    [[ -n $(whence git_prompt_info) ]] && git_prompt_info
}

function _docker_prompt {
    DOCKER_PROMPT_INFO="${DOCKER_PROMPT_INFO:-${DOCKER_MACHINE_NAME}}"
    DOCKER_PROMPT_INFO="${DOCKER_PROMPT_INFO:-${DOCKER_HOST/tcp:\/\//}}"
    if [ -n "${DOCKER_PROMPT_INFO}" ]; then
        echo "${ZSH_THEME_DOCKER_PROMPT_PREFIX}${DOCKER_PROMPT_INFO}${ZSH_THEME_DOCKER_PROMPT_SUFFIX}"
    fi
}

# ZSH_THEME_GIT_PROMPT_PREFIX="git:‹%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_PREFIX="ᚠ:‹%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}› %{$fg[yellow]%}✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%}›"

ZSH_THEME_VIRTUAL_ENV_PROMPT_PREFIX="venv:‹%{$fg[red]%}"
ZSH_THEME_VIRTUAL_ENV_PROMPT_SUFFIX="%{$fg[blue]%}› "

ZSH_THEME_DOCKER_PROMPT_PREFIX="docker:‹%{$fg[red]%}"
ZSH_THEME_DOCKER_PROMPT_SUFFIX="%{$fg[blue]%}› "



# PROMPT='%{$fg_bold[red]%}➜ %{$fg[cyan]%}%~ %{$fg_bold[blue]%}$(_virtualenv_prompt)$(_docker_prompt)$(_git_prompt)%{$fg_bold[blue]%} % %{$reset_color%}
# : '

PROMPT='%{$fg[cyan]%}%~ %{$fg_bold[blue]%}$(_virtualenv_prompt)$(_docker_prompt)$(_git_prompt)%{$fg_bold[blue]%} % %{$reset_color%}
%{%(?.$fg[green].$fg[red])%}: % %{$reset_color%}'
