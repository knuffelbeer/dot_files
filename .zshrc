#!/bin/zsh
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="robbyrussell"

# export PATH=$HOME/bin:/usr/local/bin:$PATH
export EDITOR="nvim"
# Path to your oh-my-zsh installation.
#export LUA_PATH="/home/knuffelbeer/.luarocks/lib/luarocks/rocks-5.1/magick/1.6.0-1/?.lua;;"
#export LUA_CPATH="/home/knuffelbeer/.luarocks/lib/luarocks/rocks-5.1/magick/1.6.0-1/?.so;;"
#ZSH=/usr/share/oh-my-zsh/
# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="mh"
# ZSH_THEME="kafeitu"
 ZSH_THEME="jbergantine"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-autosuggestions zsh-history-substring-search zsh-vi-mode zsh-syntax-highlighting)


# Define the function
vimmiedepimmie() {
  if [[ $# -eq 0 ]]; then
    # If no arguments, use fzf to select a file and open it in neovim
    nvim "$(fzf)"
  else
    # If arguments are provided, open them directly in neovim
    nvim "$@"
  fi
}

# Create an alias for the function
# alias vi='vimmiedepimmie'
alias v='vimmiedepimmie'
alias wi='nmtui'

alias x="xplr"
alias hdmi="/home/knuffelbeer/bashScripts/hdmi.sh"
alias n="nvim"
alias vim="nvim"
alias c="cd"
alias f="/home/knuffelbeer/bashScripts/fzf.sh"
alias vi="/home/knuffelbeer/bashScripts/fzf.sh"

alias scim="sc-im"
alias dirBase='basename "$(pwd)" | figlet -f small |  lolcat'
alias clear="clear && dirBase"
# export VCPKG_ROOT=/home/knuffelbeer/vcpkg/vcpkg
export PATH=$PATH:/home/knuffelbeer/vcpkg/
# ~/.bashrc
export PATH=$PATH:~/sc-im/src
export PATH=$PATH:~/blender-4.1.1-linux-x64
export PATH=$PATH:/home/knuffelbeer/.local/bin
export PATH=$PATH:/usr/bin
# alias code="code --enable-proposed-api ms-toolsai.jupyter"
source $ZSH/oh-my-zsh.sh
# eval "$(zoxide init --cmd cd zsh)"
bindkey              '^I'         menu-complete
bindkey "$terminfo[kcbt]" reverse-menu-complete
if [ -z "$SSH_AUTH_SOCK" ]; then
	eval "$(ssh-agent)"
fi

if [ -z "$TMUX" ]; then
	tmux new -As knuffelbeer

else
	#lolcat ~/.southpark

	# | lolcat
	source /home/knuffelbeer/.python_venvs/B/bin/activate
	basename "$(pwd)" | figlet -f small |  lolcat
	#colorscript -r
	#cowthink -n -f bong.cow |
	#basename "$(pwd)" | cowthink -n -f kenny | lolcat
fi
set -o vi
