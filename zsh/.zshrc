#### OH-MY-ZSH CONFIG ####

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set theme; see https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="dracula"

# Choose random theme possibilities
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Case-sensitive completion
CASE_SENSITIVE="true"

# Hyphen-insensitive completion
# HYPHEN_INSENSITIVE="true"

# Auto-update (default = false)
# DISABLE_AUTO_UPDATE="true"

# Update without prompting (default = false)
# DISABLE_UPDATE_PROMPT="true"

# Default auto-update timeline
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Disable LS colors (default = false)
# DISABLE_LS_COLORS="true"

# Disable auto-setting terminal title (default = false)
# DISABLE_AUTO_TITLE="true"

# Enable command auto-correction (default = false)
# ENABLE_CORRECTION="true"

# Display red dots whilst waiting for completion (default = false)
COMPLETION_WAITING_DOTS="true"

# Disables marking untracked files under VCS as dirty; makes status checking for large repos faster
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Customize command execution timestamp; see `man strftime` for a custom format, or use:
                   # "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Load plugins:
#   - standard plugins found in $ZSH/plugins/
#   - custom plugins found in $ZSH_CUSTOM/plugins/
# Note: too many plugins slow down shell startup
plugins=(
  zsh-autosuggestions
  zsh-syntax-highlighting
  # vi-mode
  copybuffer # <C-o> copies cmd line to clipboard

  git
  macos

  fd
  ripgrep
  rust # for rustc/rustup/cargo completions

  asdf # don't use enough to warrant rn
  pip
)

# Change autosuggestions color for clarity
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=10'

# enable oh-my-zsh
source $ZSH/oh-my-zsh.sh

# Change autosuggestions keybind to escape ('\t' for Tab)
bindkey '\t' autosuggest-accept
# Default auto-completion with <C-e>
bindkey '^e' complete-word




#### USER CONFIGURATION ####

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
 export EDITOR='vim'
else
 export EDITOR='nvim'
fi

# Update prompt
prompt_context() {
  if [[ "$USER" != "$DEFAULT_USER" || -n "$SSH_CLIENT" ]]; then
    prompt_segment black default "%(!.%{%F{yellow}%}.)$USER"
  fi
}

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Change config locations
export XDG_CONFIG_HOME="$HOME/.config"



## APPLICATION CONFIGS

# Required for Vimtex/Zathura integration
export DBUS_SESSION_BUS_ADDRESS="unix:path=$DBUS_LAUNCHD_SESSION_BUS_SOCKET"

# Enable autojump
  [ -f /opt/homebrew/etc/profile.d/autojump.sh ] && . /opt/homebrew/etc/profile.d/autojump.sh

# configure shell environment for pyenv
eval "$(pyenv init --path)"

# configure shell environment for direnv
eval "$(direnv hook zsh)"

# Add bat to manpages
export MANPAGER="sh -c 'col -bx | bat -l man -p'"





## PATH UPDATES

# Set Java version to 11.0.1
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk-11.0.1.jdk/Contents/Home

# Add Racket to environment path
export PATH=$PATH:/Applications/Racket\ v8.6/bin

# Add Go to environment path
export GOPATH=$HOME/Go
export PATH=$PATH:$GOPATH/bin

# Add system binaries to path
export PATH="/usr/local/sbin:$PATH"

# Add Ruby to environment path
export GEM_HOME="$HOME/.gem"

# Add Rust environment
source "$HOME/.cargo/env"


# Configure gcc/g++ to latest versions
export PATH="/opt/homebrew/Cellar/gcc/12.2.0/bin:$PATH"
# make aliases to correct gcc/g++...
# alias c++=/opt/homebrew/Cellar/gcc/12.2.0/bin/c++-12
# alias gcc=/opt/homebrew/Cellar/gcc/12.2.0/bin/gcc-12
# alias g++=/opt/homebrew/Cellar/gcc/12.2.0/bin/g++-12

# Include libraries for llvm suite
# Put llvm suite at start of path (to use over built-ins)
export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
# For compilers to find llvm
export LDFLAGS="-L/opt/homebrew/opt/llvm/lib/c++ -Wl,-rpath,/opt/homebrew/opt/llvm/lib/c++"
# export LDFLAGS="-L/opt/homebrew/opt/llvm/lib"
export CPPFLAGS="-I/opt/homebrew/opt/llvm/include"


## FUNCTIONS
# oh-my-zsh recommends alias definitions in ZSH_CUSTOM, apparently?
# view all aliases with `alias`


# kill all processes running on provided port
killport() {
  lsof -t -i:$1 | xargs -t kill -9
}

# kill all processes that contain the name
killproc() {
  ps -a | grep -v "grep" | grep "$1" | cut -d " " -f1 | xargs -t kill -9
}

# compile c++ code w/ desired version

cppc() {
  g++ -std=c++20 -Wall -Wextra -Wno-sign-compare -pthread -O2 $1.cpp -o $1 && ./$1
}

# shortened add -> commit -> push
gacp() {
  git add -A && git commit -a -m $1 && git push
}

# convert to nosync (useful for bird)
nosync() {
  mv $1 $1.nosync && ln -s $1.nosync $1
}

# play/pause Spotify
toggle_song() {
  osascript -e 'tell application "Spotify" to playpause'
}
# go to next/previous song
next_song() {
  for i in 1..$1; do osascript -e 'tell application "Spotify" to next track'; done
}
prev_song() {
  for i in 1..$1; do osascript -e 'tell application "Spotify" to previous track'; done
}


## ALIASES

# GitUI shortcut
alias gi="gitui"

# shorten vagrant stuff
alias vssh="vagrant ssh"
alias vupsh="vagrant up && vagrant ssh"

# migrate from vim -> neovim
alias vim="nvim"

# keep old vim for TeX [TODO: migrate over to NeoVim]
# alias tvim="~/texterm.sh"
alias ovim="/opt/homebrew/bin/vim"

# fzf default 25% height
alias fzf="fzf --height=25%"

alias ml-env="source ~/course/stats-ml/bin/activate"
alias logic-env="source ~/course/csci1710/csci1710_env/bin/activate"

alias cmd="echo hello"

alias ls="exa --group-directories-first --icons --time-style=long-iso --git -h"
