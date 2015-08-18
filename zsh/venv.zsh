# Auto-activate virtualenv if .venv exists somewhere in the path
function workoncwd {
    setopt local_options extended_glob
    if type workon > /dev/null 2>&1; then
        venv=${$(find (../)#.venv(.N) 2> /dev/null | tail -n 1):a}
        if [ -e "$venv" ]; then
            venv_name=$(cat "$venv")
            active_venv=${VIRTUAL_ENV:t}
            [[ -n "$venv_name" && "$venv_name" != "$active_venv" ]] && workon "$venv_name"
        fi
    fi
}

chpwd_functions+=(workoncwd)
