setopt complete_aliases

alias ls='ls --color=tty -F'

alias svim='sudo -s vim'

if which exim > /dev/null; then
    alias exim-clear-queue='sudo bash -c "exim -bp | exiqgrep -i | xargs exim -Mrm"'
fi

function xmlpretty() {
    xmllint --format --recover --nocompact --pretty 1 $* 2> /dev/null
}

function man() {
    vim -c "SuperMan $*"
    if [ "$?" != "0" ]; then
        echo "No manual entry for $*"
    fi
}

compdef man="man"
