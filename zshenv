PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"

if [[ $OSTYPE =~ "linux" ]]; then
    PATH="$HOME/.linuxbrew/bin:$PATH"
    export MANPATH="$HOME/.linuxbrew/share/man:$MANPATH"
    export INFOPATH="$HOME/.linuxbrew/share/info:$INFOPATH"
fi

PATH="$HOME/bin:$HOME/node_modules/.bin:$PATH"
export PATH
export EDITOR=vim

if [[ -e "${HOME}/.zshenv_local" ]]; then
    source "${HOME}/.zshenv_local"
fi
