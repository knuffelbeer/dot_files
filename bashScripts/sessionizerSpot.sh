#!/usr/bin/env bash

selected_program=$1
selected_name="$selected_program"
tmux_running=$(pgrep tmux)

if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
    tmux new-session -s $selected_name "$selected_program"
fi

if ! tmux has-session -t=$selected_name 2> /dev/null; then
    tmux new-session -ds $selected_name "$selected_program"
fi

tmux switch-client -t $selected_name
