#!/bin/bash

# A kind off hacky way to get workspace-like funcionality for windows in your 
# session. It doesn't make you define windows in order of their index. 
# As in, you can always jump to windo 9 even if 2-8 aren't created yet. This
# allows for running certain programs in set windows.
# It also allows for custom configurations for certain directories,
# so you can have subdirectories or certain programs open automatically on set 
# windows. Usage: map each index running this script with that number in your 
# .tmux.conf and adjust the switch statement with the directories to your liking.


TARGET_INDEX=$1
if [ "$TARGET_INDEX" = 0 ];then
		TARGET_INDEX=10
fi

CURRENT_SESSION=$(tmux display-message -p '#S')

selectDir(){
			if dirs=$(ls -d */ 2> /dev/null); then
			  tmux new-window -t "$TARGET_INDEX" -n "$CURRENT_SESSION:$TARGET_INDEX" "bash -c 'file=\$(echo \"$dirs\"| fzf); if [ -n \"\$file\" ]; then cd \"\$file\" && zsh; else zsh ; fi'"
			else
			  tmux new-window -t "$TARGET_INDEX" -n "$CURRENT_SESSION:$TARGET_INDEX" "zsh"
			fi
}

case "$CURRENT_SESSION"  in
# list here your directories that should have a custom commands mapped to
# as a case with their custom configuration.
	"AlgorithmOfEverything")
		if tmux list-windows | grep -q "^$TARGET_INDEX:"; then
		    tmux select-window -t "$CURRENT_SESSION:$TARGET_INDEX"
		else
			case $TARGET_INDEX in
				# 2)
				# 	tmux new-window -t "$TARGET_INDEX" -n "$CURRENT_SESSION:$TARGET_INDEX"  "cd knobDistribution && nvim . && zsh"
				# 	;;
				2) # promt for a file int the knobDistribution directory
					tmux new-window -t "$TARGET_INDEX" -n "$CURRENT_SESSION:$TARGET_INDEX" "bash -c 'cd knobDistribution; file=\$(fzf); if [ -n \"\$file\" ]; then nvim \"\$file\"; else nvim .; fi'"
					;;
				10)
					tmux new-window -t "$TARGET_INDEX" -n "$CURRENT_SESSION:$TARGET_INDEX"  "cd /home/knuffelbeer/meester_solutions/AlgorithmOfEverything/results/3ModelsMAPE && zsh"
					;;
				*)
					selectDir
					;;
			esac

		fi
			;;
		
	"nvim")
		if tmux list-windows | grep -q "^$TARGET_INDEX:"; then
		    tmux select-window -t "$CURRENT_SESSION:$TARGET_INDEX"
		else
			case $TARGET_INDEX in
				2)

					tmux new-window -t "$TARGET_INDEX" -n "$CURRENT_SESSION:$TARGET_INDEX"  "nvim /home/knuffelbeer/.config/nvim/init.lua && zsh"
					;;
				#9)
				#	tmux new-window -t "$TARGET_INDEX" -n "$CURRENT_SESSION:$TARGET_INDEX"  "cd /home/knuffelbeer/.config/nvim/lua/ && zsh"
				#	;;
				9) # Now when you navigate to window 2 it prompts for a file with fzf and opens it up in neovim. 
					tmux new-window -t "$TARGET_INDEX" -n "$CURRENT_SESSION:$TARGET_INDEX" "bash -c 'cd /home/knuffelbeer/.config/nvim/lua/; file=\$(fzf); if [ -n \"\$file\" ]; then nvim \"\$file\"; else nvim .; fi'"
					;;
				# 10)
				# 	tmux new-window -t "$TARGET_INDEX" -n "$CURRENT_SESSION:$TARGET_INDEX"  "cd /home/knuffelbeer/.config/nvim/lua/plugins && zsh"
				# 	;;
				10) # Now when you navigate to window 2 it prompts for a file with fzf and opens it up in neovim. 
					tmux new-window -t "$TARGET_INDEX" -n "$CURRENT_SESSION:$TARGET_INDEX" "bash -c 'cd /home/knuffelbeer/.config/nvim/lua/plugins; file=\$(fzf); if [ -n \"\$file\" ]; then nvim \"\$file\"; else nvim .; fi'"
					;;
				*)
					selectDir
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
				2) # Now when you navigate to window 2 it prompts for a file with fzf and opens it up in neovim. 
					tmux new-window -t "$TARGET_INDEX" -n "$CURRENT_SESSION:$TARGET_INDEX" "bash -c 'file=\$(fzf); if [ -n \"\$file\" ]; then nvim \"\$file\"; else nvim .; fi'"
					;;
				3) # Now when you navigate to window 2 it prompts for a file with fzf and opens it up in neovim. 
			if ls -d */ > /dev/null; then
			  tmux new-window -t "$TARGET_INDEX" -n "$CURRENT_SESSION:$TARGET_INDEX" "bash -c 'file=\$(ls -d */ | fzf); if [ -n \"\$file\" ]; then cd \"\$file\" && zsh; else zsh ; fi'"
			  # No subdirectories, open zsh in the current directory
			else
			  tmux new-window -t "$TARGET_INDEX" -n "$CURRENT_SESSION:$TARGET_INDEX" "zsh"
			fi
					;;
				4)
					if [ -d "build" ]; then
										tmux new-window -t "$TARGET_INDEX" -n "$CURRENT_SESSION:$TARGET_INDEX" "cd build"
					else
						figlet "no build directory found."
					fi

					;;
				*)
					selectDir
					;;
			esac
		# tmux new-window -n  "$CURRENT_SESSION:$TARGET_INDEX"
	fi
	;;
esac
