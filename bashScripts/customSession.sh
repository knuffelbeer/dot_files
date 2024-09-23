#!/usr/bin/env bash

# Directory to use
directory=~/cppStuff/torch/basicExample
session_name="basicExample"

# Function to create the session and windows
function create_session() {
    local dir="$1"
    local name="$2"

    # Create a new tmux session with the specified name and directory
    tmux new-session -ds "$name" -c "$dir" -n 'nvim' "nvim"

    # Create new windows for nvim, gdb, and build directory
    #tmux new-window -t "$name:2" -n 'nvim' "nvim"
    #tmux new-window -t "$name:2" -n 'gdb' "gdb"
    tmux new-window -t "$name:2" -n 'build' "cd $dir/build && zsh"
    tmux select-window -t "$name:1"
}

# Check for an existing tmux session
if ! tmux has-session -t "$session_name" 2> /dev/null; then
    create_session "$directory" "$session_name"
    tmux switch-client -t "$session_name"
else
    tmux switch-client -t "$session_name"
fi
