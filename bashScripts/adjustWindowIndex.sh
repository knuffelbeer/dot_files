#!/bin/bash

TARGET_INDEX=$1
if [[ $TARGET_INDEX -eq 0 ]]; then
	$TARGET_INDEX = 10
fi

if tmux list-windows | grep -q "^$TARGET_INDEX:"; then
				echo "index already in use"
else
				tmux move-window -t "$TARGET_INDEX"
fi
