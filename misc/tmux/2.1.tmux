# https://www.reddit.com/r/tmux/comments/3paqoi/tmux_21_has_been_released/cw552qd
set -g default-terminal "xterm-256color"
set-option -g mouse on
bind-key -T root PPage if-shell -F "#{alternate_on}" "send-keys PPage" "copy-mode -e; send-keys PPage"
bind-key -t vi-copy PPage page-up
bind-key -t vi-copy NPage page-down
bind -n WheelUpPane if-shell -F -t = "#{mouse_any_flag}" "send-keys -M" "if -Ft= '#{pane_in_mode}' 'send-keys -M' 'select-pane -t=; copy-mode -e; send-keys -M'"
bind -n WheelDownPane select-pane -t= \; send-keys -M
# bind-key -T root WheelDownPane if-shell -F -t = "#{alternate_on}" "send-keys -M" "select-pane -t =; copy-mode -e; send-keys -M"
# bind-key -T root WheelUpPane if-shell -F -t = "#{alternate_on}" "send-keys -M" "select-pane -t =; send-keys -M"
# bind-key -t vi-copy WheelDownPane halfpage-up
# bind-key -t vi-copy WheelUpPane halfpage-down
set-window-option -g window-style 'bg=#111111'
set-window-option -g window-active-style 'bg=#000000'
# set-window-option -g pane-active-border-style ''
