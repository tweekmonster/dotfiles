export VIRTUAL_ENV_DISABLE_PROMPT=1
export FZF_DEFAULT_COMMAND='ag -l -g ""'

if [[ -z $ZSHENV_PATH_SET || -n $VIRTUAL_ENV ]]; then
    PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"

    if [[ $OSTYPE =~ "linux" ]]; then
        PATH="$HOME/.linuxbrew/bin:$PATH"
        export MANPATH="$HOME/.linuxbrew/share/man:$MANPATH"
        export INFOPATH="$HOME/.linuxbrew/share/info:$INFOPATH"
    fi

    PATH="$HOME/bin:$HOME/.local/bin:$HOME/.npm/bin:$PATH"
    export PATH
    export ZSHENV_PATH_SET=1

    if [[ -n $VIRTUAL_ENV && -e "${VIRTUAL_ENV}/bin/activate" ]]; then
        source "${VIRTUAL_ENV}/bin/activate"
    fi
fi

export EDITOR=vim

# dotfiles=$(dirname "${${(%):-%N}:A}")
# Done here so that the $PATH is updated with pyenv
# source "${dotfiles}/zsh/oh-my-zsh/plugins/pyenv/pyenv.plugin.zsh"

if [[ -e "${HOME}/.zshenv_local" ]]; then
    source "${HOME}/.zshenv_local"
fi
