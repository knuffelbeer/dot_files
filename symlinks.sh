configDirectories=("nvim" "awesome" "alacritty")

for dir in "${configDirectories[@]}"; do
	ln -s "$HOME/dot_files/${dir}" "$HOME/.config/${dir}"
done

# Files that are not in .config.
ln -s ~/dot_files/bashScripts ~/bashScripts
