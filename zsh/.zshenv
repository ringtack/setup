export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk-11.0.1.jdk/Contents/Home
source "$HOME/.cargo/env"

killport() {
  lsof -t -i:$1 | xargs kill -9
}

gacp() {
  git add -A && git commit -a -m $1 && git push
}

# shorten vagrant stuff
alias vssh="vagrant ssh"
alias vupsh="vagrant up && vagrant ssh"

# migrate from vim -> neovim
alias vim="nvim"

# fzf default 25% height
alias fzf="fzf --height=25%"
