setopt complete_aliases
alias sudo='nocorrect sudo '

# Snatched from oh-my-zsh, except with the -F flag
# Find the option for using colors in ls, depending on the version: Linux or BSD
if [[ "$(uname -s)" == "NetBSD" ]]; then
    # On NetBSD, test if "gls" (GNU ls) is installed (this one supports colors);
    # otherwise, leave ls as is, because NetBSD's ls doesn't support -G
    gls --color -d . &>/dev/null 2>&1 && alias ls='gls --color=tty'
elif [[ "$(uname -s)" == "OpenBSD" ]]; then
    # On OpenBSD, test if "colorls" is installed (this one supports colors);
    # otherwise, leave ls as is, because OpenBSD's ls doesn't support -G
    colorls -G -d . &>/dev/null 2>&1 && alias ls='colorls -GF'
else
    ls --color -d . &>/dev/null 2>&1 && alias ls='ls --color=tty -F' || alias ls='ls -GF'
fi

alias svim='sudo -s vim'

if which exim > /dev/null; then
    alias exim-clear-queue='sudo bash -c "exim -bp | exiqgrep -i | xargs exim -Mrm"'
fi

function xmlpretty() {
    xmllint --format --recover --nocompact --pretty 1 $* 2> /dev/null
}

# alias oldman='LESS_TERMCAP_mb=$(printf "\e[1;31m") LESS_TERMCAP_md=$(printf "\e[1;31m") LESS_TERMCAP_me=$(printf "\e[0m") LESS_TERMCAP_se=$(printf "\e[0m") LESS_TERMCAP_so=$(printf "\e[1;44;33m") LESS_TERMCAP_ue=$(printf "\e[0m") LESS_TERMCAP_us=$(printf "\e[1;32m") /usr/bin/man'
#
# function man() {
#     # Let man check before starting vim
#     /usr/bin/man -w $* 1> /dev/null
#     if [[ $? == 0 ]]; then
#         vim -c "runtime ftplugin/man.vim" -c "Man $*" +"wincmd o" -c "set nolist norelativenumber nonumber nomodifiable" -c 'nmap q :q<CR>'
#     fi
# }
#
# compdef man="man"
