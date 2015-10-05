# zmodload zsh/zprof
# oh-my-zsh covers the other history related options
dotfiles=$(dirname "${${(%):-%N}:A}")
setopt hist_ignore_all_dups
setopt correct
fpath=("${dotfiles}/zsh/zsh-completions/src" $fpath)

# Begin loading oh-my-zsh
ZSH="${dotfiles}/zsh/oh-my-zsh"
ZSH_THEME=""
DISABLE_AUTO_UPDATE=true
plugins=(
    pip
    python
    sudo
    supervisor
    systemadmin
    tmux
)

source "${ZSH}/oh-my-zsh.sh"

# source "${dotfiles}/zsh/zaw/zaw.zsh"
source "${dotfiles}/zsh/aliases.zsh"
source "${dotfiles}/zsh/venv.zsh"
source "${dotfiles}/zsh/zsh-duckduckgo/duckduckgo.zsh"

if [[ -e "${HOME}/.zshrc_local" ]]; then
    # Let a local .zshrc override
    source "${HOME}/.zshrc_local"
fi

if [[ "${ZSH_THEME}" == "" ]]; then
    # Stick to my tried and true if a theme wasn't set
    source "${dotfiles}/zsh/nanofish/nanofish.zsh-theme"
fi

source "${dotfiles}/zsh/keyboard.zsh"

if [[ $OSTYPE =~ "darwin" ]]; then
    source "${dotfiles}/zsh/osx.zsh"
fi

# zprof

# BASE16_SHELL="$HOME/dotfiles/misc/shell/base16.sh"
# [[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

source "${dotfiles}/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
# zprof
