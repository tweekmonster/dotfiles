# http://dougblack.io/words/zsh-vi-mode.html
export KEYTIMEOUT=1
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>/'

bindkey -v

bindkey -M vicmd '^s' toggle-sudo
bindkey -M viins '^s' toggle-sudo

# Bound to ESC. There's no escape key sequence in my vi-mode
# this cancels vicmd mode and returns the curser to the end
bindkey -M vicmd '\e' vi-add-eol

bindkey '^P' up-history
bindkey '^N' down-history
bindkey '^?' backward-delete-char
bindkey "\e?" backward-delete-char
bindkey '^w' backward-kill-word
bindkey "\e[3~" delete-char

# Note these are actual escape (0o033) characters
# These depend on the OS X Terminal key bindings
# found in the theme file
# Mapping taken from: http://vim.wikia.com/wiki/Get_Alt_key_to_work_in_terminal
bindkey '[A' history-beginning-search-backward-end
bindkey '[B' history-beginning-search-forward-end

bindkey -M viins '[1;3D' backward-word
bindkey -M viins '[1;3C' forward-word
bindkey -M vicmd '[1;3D' vi-backward-blank-word
bindkey -M vicmd '[1;3C' vi-forward-blank-word

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
    local last_cmd="$(fc -l -n -1)"

    if [[ $BUFFER == $last_cmd ]]; then
        BUFFER=""
    else
        if [[ -z $BUFFER ]]; then
            BUFFER=$last_cmd
            CURSOR=${#BUFFER}
        fi

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
    fi

    if typeset -f _zsh_highlight > /dev/null; then
        _zsh_highlight
    fi
}

function reset-prompt() {
    # So prompt can be updated with vi-mode state
    zle .reset-prompt
}

zle -N toggle-sudo
zle -N zle-line-init reset-prompt
zle -N zle-keymap-select reset-prompt

zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
