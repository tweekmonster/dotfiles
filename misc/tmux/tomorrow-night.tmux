set-option -g status-position top

set -g status "on"

set -g status-bg "colour228"
set -g status-justify "left"
set -g status-left-length "100"
set -g status-left-attr "none"
set -g status-right-length "100"
set -g status-right-attr "none"
set -g status-attr "none"
set -g status-utf8 "on"

set -g pane-active-border-fg "colour194"
set -g pane-active-border-bg "colour0"
set -g pane-border-fg "colour244"
set -g pane-border-bg "colour0"

set -g message-fg "colour54"
set -g message-bg "colour195"

set -g message-command-fg "colour54"
set -g message-command-bg "colour195"

setw -g window-status-fg "colour54"
setw -g window-status-bg "colour228"
setw -g window-status-attr "none"
setw -g window-status-separator ""
setw -g window-status-format "#[fg=colour236,bg=colour220]  #I  #[bg=colour214]  #W  #[bg=default] "
setw -g window-status-current-format "#[fg=colour232,bg=colour202,bold]  #I  #[bg=colour196]  #W  #[bg=default] "

setw -g window-status-activity-bg "colour18"
setw -g window-status-activity-attr "none"
setw -g window-status-activity-fg "colour2"

set -g status-left "#[fg=colour231,bg=colour161]  tmux  #[fg=default,bg=default]    "
set -g status-right "#(cat /tmp/tmuxstatus) #[fg=colour233,bg=colour214]  %Y-%m-%d %H:%M  #[fg=colour240,bg=colour220]  #(echo $USER)@#h #S:#I:#P  "

#  vim: set ft=tmux ts=4 sw=4 tw=0 et :
