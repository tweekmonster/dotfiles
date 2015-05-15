# zmodload zsh/zprof
# oh-my-zsh covers the other history related options
setopt hist_ignore_all_dups
setopt correct

dotfiles=$(dirname "${${(%):-%N}:A}")
fpath=("${dotfiles}/zsh/zsh-completions/src" $fpath)

# Begin loading oh-my-zsh
ZSH="${dotfiles}/zsh/oh-my-zsh"
ZSH_THEME=""
plugins=(
    catimg
    pip
    python
    sudo
    supervisor
    systemadmin
    tmux
    pyenv
)

source "${ZSH}/oh-my-zsh.sh"

source "${dotfiles}/zsh/zaw/zaw.zsh"
source "${dotfiles}/zsh/aliases.zsh"

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

source "${dotfiles}/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
# zprof
