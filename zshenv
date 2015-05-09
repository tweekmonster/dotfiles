PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
PATH="$HOME/bin:$HOME/node_modules/.bin:$PATH"
export PATH

virtualenvwrapper=$(which virtualenvwrapper_lazy.sh)
if [[ -e "${virtualenvwrapper}" ]]; then
    source "${virtualenvwrapper}"
fi

pyenv_type=$(type pyenv)
if [[ ! pyenv_type =~ "function" && -e $(which pyenv) ]]; then
    export PYENV_ROOT=/usr/local/opt/pyenv
    eval "$(pyenv init -)"
fi

if [[ -e "${HOME}/.zshenv_local" ]]; then
    source "${HOME}/.zshenv_local"
fi
