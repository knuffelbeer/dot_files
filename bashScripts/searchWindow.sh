#!/bin/zsh

if windowIndex=$(tmux list-windows | awk '{print $2}'  | fzf| sed 's/[^0-9]*\([0-9]*\)[^0-9]*/\1/g');then
	CURRENT_SESSION=$(tmux display-message -p '#S')
	tmux select-window -t "$CURRENT_SESSION:$windowIndex"
fi
