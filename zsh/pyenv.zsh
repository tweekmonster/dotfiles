# Holy shit oh-my-zsh's pyenv plugin can get slow calling on `brew`
pyenvdirs=("$HOME/.pyenv", "/usr/local/pyenv" "/usr/local/opt/pyenv" "/opt/pyenv")

for pydir in "${pyenvdirs[@]}"; do
    if [[ -d "$pydir/bin" ]]; then
        export PYENV_ROOT="$pydir"
        export PATH="${pydir}/bin:$PATH"
        eval "$(pyenv init -)"
        eval "$(pyenv virtualenv-init -)"
        break
    fi
done
