export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk-11.0.1.jdk/Contents/Home
source "$HOME/.cargo/env"

killport() {
  lsof -t -i:$1 | xargs kill -9
}

vssh() {
  vagrant ssh
}

vupsh() {
  vagrant up && vagrant ssh
}

gacp() {
  git add -A && git commit -a -m $1 && git push
}
