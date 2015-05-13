# http://dougblack.io/words/zsh-vi-mode.html
bindkey -v

bindkey '^P' up-history
bindkey '^N' down-history
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word
bindkey '^r' history-incremental-search-backward
bindkey -rM viins '^['
bindkey -M viins '^v' vi-cmd-mode

bindkey '^[[A' history-beginning-search-backward
bindkey '^[[B' history-beginning-search-forward

# Zaw
bindkey '^R' zaw-history
bindkey '^Z' zaw
bindkey -sM filterselect '^[' '^G'
bindkey -M filterselect '^R' down-line-or-history
bindkey -M filterselect '^S' up-line-or-history
bindkey -M filterselect '^E' accept-search

zstyle ':filter-select:highlight' matched fg=yellow,standout
zstyle ':filter-select' max-lines 15
zstyle ':filter-select' rotate-list yes
zstyle ':filter-select' case-insensitive yes
zstyle ':filter-select' extended-search yes

# Bind ESC to bell in vi-mode
bindkey -sM vicmd '^[' '^G'


function zle-line-init zle-keymap-select() {
    zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select
export KEYTIMEOUT=1
