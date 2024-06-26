#!/bin/bash

configDirectories=("nvim" "awesome" "alacritty" "Code/User/keybindings.json"  "Code/User/settings.json"  "")

for dir in "${configDirectories[@]}"; do
	ln -s "$HOME/dot_files/${dir}" "$HOME/.config/${dir}"
done

# Files that are not in .config.
ln -s ~/dot_files/bashScripts ~/bashScripts
ln -s ~/dot_files/vscode/extensions ~/.vscode-oss/extensions
