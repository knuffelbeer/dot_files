#!/bin/bash

# A kind off hacky way to get workspace-like funcionality for windows in your 
# session. You can define a custom setup for one of you sessions and have


TARGET_INDEX=$1
if [ "$TARGET_INDEX" = 0 ];then
		TARGET_INDEX=10
fi

CURRENT_SESSION=$(tmux display-message -p '#S')
echo "$CURRENT_SESSION"

# list here your directories that should have a custom commands mapped to
# there windows.
if [ "$CURRENT_SESSION" = "knuffelbeer" ]; then
		echo "knuffelbeer"
		if tmux list-windows | grep -q "^$TARGET_INDEX:"; then
				echo "window $1 exists."
		    tmux select-window -t "$CURRENT_SESSION:$TARGET_INDEX"
		else
				echo "case."
			case $TARGET_INDEX in
				2)
					tmux new-window -t 2 -n "$CURRENT_SESSION:2"  "vim ."
					;;
				3)
					tmux new-window -t 3 -n "$CURRENT_SESSION:3"  "gdb ."
					;;
				*)
					tmux new-window -t "$TARGET_INDEX" -n  "$CURRENT_SESSION:$TARGET_INDEX"
					;;
			esac
		fi
else
    echo "You are not in the target session. Current session: $CURRENT_SESSION"
		if tmux list-windows | grep -q "^$TARGET_INDEX:"; then
				echo "window $TARGET_INDEX exists."
		    tmux select-window -t "$CURRENT_SESSION:$TARGET_INDEX"
			else
				echo "window $TARGET_INDEX didn't exist."
		tmux new-window -n  "$CURRENT_SESSION:$TARGET_INDEX"
	fi
fi
