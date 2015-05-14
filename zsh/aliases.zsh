setopt complete_aliases
alias sudo='nocorrect sudo '
alias ls='ls --color=tty -F'

alias svim='sudo -s vim'

if which exim > /dev/null; then
    alias exim-clear-queue='sudo bash -c "exim -bp | exiqgrep -i | xargs exim -Mrm"'
fi

function xmlpretty() {
    xmllint --format --recover --nocompact --pretty 1 $* 2> /dev/null
}

alias oldman='LESS_TERMCAP_mb=$(printf "\e[1;31m") LESS_TERMCAP_md=$(printf "\e[1;31m") LESS_TERMCAP_me=$(printf "\e[0m") LESS_TERMCAP_se=$(printf "\e[0m") LESS_TERMCAP_so=$(printf "\e[1;44;33m") LESS_TERMCAP_ue=$(printf "\e[0m") LESS_TERMCAP_us=$(printf "\e[1;32m") /usr/bin/man'

function man() {
    # Let man check before starting vim
    /usr/bin/man -w "$*" 1> /dev/null
    if [[ $? == 0 ]]; then
        vim -c "runtime ftplugin/man.vim" -c "Man $*" +"wincmd o" -c "set nolist norelativenumber nonumber nomodifiable" -c 'nmap q :q<CR>'
    fi
}

compdef man="man"
