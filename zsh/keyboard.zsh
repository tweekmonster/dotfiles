# http://dougblack.io/words/zsh-vi-mode.html
export KEYTIMEOUT=1
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>/'
typeset -A key

key[home]=${terminfo[khome]}
key[end]=${terminfo[kend]}
key[ins]=${terminfo[kich1]}
key[del]=${terminfo[kdch1]}
key[up]=${terminfo[kcuu1]}
key[down]=${terminfo[kcud1]}
key[left]=${terminfo[kcub1]}
key[right]=${terminfo[kcuf1]}
key[pgup]=${terminfo[kpp]}
key[pgdn]=${terminfo[knp]}
key[bs]=${terminfo[kbs]}
key[tab]=${terminfo[ht]}

bindkey -v

bindkey -M vicmd '^s' toggle-sudo
bindkey -M viins '^s' toggle-sudo

# Bound to ESC. There's no escape key sequence in my vi-mode
# this cancels vicmd mode and returns the curser to the end
bindkey -M vicmd '\e' vi-add-eol

bindkey '^P' up-history
bindkey '^N' down-history
bindkey '^?' backward-delete-char
bindkey "${key[bs]}" backward-delete-char
bindkey '^w' backward-kill-word
bindkey "${key[del]}" delete-char

bindkey "${key[up]}" history-beginning-search-backward-end
bindkey "${key[down]}" history-beginning-search-forward-end

bindkey -M viins "\eb" backward-word
bindkey -M viins "\ef" forward-word
bindkey -M vicmd "\eb" vi-backward-blank-word
bindkey -M vicmd "\ef" vi-forward-blank-word

# Zaw
bindkey '^R' zaw-history
bindkey '^Z' zaw
bindkey -M filterselect '\e' send-break
bindkey -M filterselect '^R' down-line-or-history
bindkey -M filterselect '^S' up-line-or-history
bindkey -M filterselect '^E' accept-search

zstyle ':filter-select:highlight' matched fg=yellow,standout
zstyle ':filter-select' max-lines 15
zstyle ':filter-select' rotate-list yes
zstyle ':filter-select' case-insensitive yes
zstyle ':filter-select' extended-search yes

function history-search-end() {
    # https://github.com/johan/zsh/blob/master/Functions/Zle/history-search-end
    integer cursor=$CURSOR mark=$MARK

    if [[ $LASTWIDGET = history-beginning-search-*-end ]]; then
        # Last widget called set $MARK.
        CURSOR=$MARK
    else
        MARK=$CURSOR
    fi

    if zle .${WIDGET%-end}; then
        # success, go to end of line
        zle .end-of-line
    else
        # failure, restore position
        CURSOR=$cursor
        MARK=$mark
        return 1
    fi
}

function toggle-sudo() {
    # This cycles prefixing the buffer with sudo and sudo -s
    if [[ ${BUFFER:0:5} == "sudo " ]]; then
        if [[ ${BUFFER:0:8} == "sudo -s " ]]; then
            (( CURSOR-=8 ))
            BUFFER="${BUFFER:8:${#BUFFER}-8}"
        else
            BUFFER="sudo -s ${BUFFER:5:${#BUFFER}-5}"
            (( CURSOR+=3 ))
        fi
    else
        BUFFER="sudo ${BUFFER}"
        (( CURSOR+=5 ))
    fi

    if typeset -f _zsh_highlight > /dev/null; then
        _zsh_highlight
    fi
}

function zle-line-init zle-keymap-select() {
    if [[ $WIDGET == "zle-line-init" ]]; then
        echoti smkx
    fi

    # So prompt can be updated with vi-mode state
    zle .reset-prompt
}

function zle-line-finish() {
    echoti rmkx
}

zle -N toggle-sudo
zle -N zle-line-init
zle -N zle-line-finish
zle -N zle-keymap-select
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
