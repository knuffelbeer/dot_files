#!/bin/bash

# A kind off hacky way to get workspace-like funcionality for windows in your 
# session. It doesn't make you define windows in order of their index, which
# allows for running programs in set windows, and thus always mapping a program
# to a window. also you can have custom configuration for sessions. 


TARGET_INDEX=$1
if [ "$TARGET_INDEX" = 0 ];then
		TARGET_INDEX=10
fi

CURRENT_SESSION=$(tmux display-message -p '#S')


case "$CURRENT_SESSION"  in
# list here your directories that should have a custom commands mapped to
# as a case with their custom configuration.
	"AlgorithmOfEverything")
		if tmux list-windows | grep -q "^$TARGET_INDEX:"; then
		    tmux select-window -t "$CURRENT_SESSION:$TARGET_INDEX"
		else
			case $TARGET_INDEX in
				8)
					tmux new-window -t "$TARGET_INDEX" -n "$CURRENT_SESSION:$TARGET_INDEX"  "cd knobDistribution && nvim . && zsh"
					;;
				0)
					tmux new-window -t "$TARGET_INDEX" -n "$CURRENT_SESSION:$TARGET_INDEX"  "cd results && zsh"
					;;
				*)
					tmux new-window -t "$TARGET_INDEX" -n  "$CURRENT_SESSION:$TARGET_INDEX"
					;;
			esac

		fi
			;;
		
	"knuffelbeer")
		if tmux list-windows | grep -q "^$TARGET_INDEX:"; then
		    tmux select-window -t "$CURRENT_SESSION:$TARGET_INDEX"
		else
			case $TARGET_INDEX in
				2)
					tmux new-window -t 2 -n "$CURRENT_SESSION:2"  "vim ."
					;;
				3)
					tmux new-window -t 3 -n "$CURRENT_SESSION:3"  "gdb ."
					;;
				7)
					tmux new-window -t "$TARGET_INDEX" -n  "$CURRENT_SESSION:$7" "htop"
					;;
				*)
					tmux new-window -t "$TARGET_INDEX" -n  "$CURRENT_SESSION:$TARGET_INDEX"
					;;
			esac
		fi
			;;
		

# default configuration.
		*)
		if tmux list-windows | grep -q "^$TARGET_INDEX:"; then
		    tmux select-window -t "$CURRENT_SESSION:$TARGET_INDEX"
			else
			case $TARGET_INDEX in
				7) # Now htop is always at window 7 no matter which session you're in.
					tmux new-window -t "$TARGET_INDEX" -n  "$CURRENT_SESSION:$7" "htop"
					;;
				*)
					tmux new-window -t "$TARGET_INDEX" -n  "$CURRENT_SESSION:$TARGET_INDEX"
					;;
			esac
		# tmux new-window -n  "$CURRENT_SESSION:$TARGET_INDEX"
	fi
	;;
esac
