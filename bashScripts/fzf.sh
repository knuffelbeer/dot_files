#!/bin/bash



if [[ $# -eq 1 ]]; then
	nvim "$1"
	exit 0
fi

var1="$(fzf --exit-0)"  # --exit-0 ensures that fzf returns a 0 exit code even if no selection is made.

if [[ -z "$var1" ]]; then
    echo "No file selected."
    exit 1
fi

# Determine the application based on the file extension and launch it.
case "$var1" in
    *.pdf)
        okular "$var1" &
        ;;
    *.pptx)
        libreoffice "$var1" &
        ;;
    *.docx)
        libreoffice "$var1" &
        ;;
    *.xlsx)
        libreoffice "$var1"
        ;;
    *.ods)
        libreoffice "$var1"
        ;;
    *.jpg)
        feh "$var1" &
        ;;
    *.jpeg)
        feh "$var1" &
        ;;
    *.csv)
        libreoffice "$var1" &
        ;;
    *.png)
        feh "$var1" &
        ;;
    *)
        nvim "$var1"  # Use Neovim as default for all other files.
        ;;
esac
