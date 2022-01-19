#!/bin/bash

### NeoVim

# If nvim/ doesn't exist, make it
[[ -d nvim ]] || mkdir nvim

# copy init file
cp -af "${CONFIG_DIR}/nvim/init.lua" nvim/init.lua

# if lua/ or plugin/ don't exist, make them
[[ -d nvim/lua ]] || mkdir nvim/lua
[[ -d nvim/lua/config ]] || mkdir nvim/lua/config

# copy files over
cp -aRf "${CONFIG_DIR}/nvim/lua/." nvim/lua/


#### Kitty

# If kitty/ doesn't exist, make it
[[ -d kitty ]] || mkdir kitty

# copy files over
cp -af "${CONFIG_DIR}/kitty/." ./kitty/



#### Zathura

# If zathura/ doesn't exist, make it
[[ -d zathura ]] || mkdir zathura

# copy files over
cp -af "${CONFIG_DIR}/zathura/zathurarc" ./zathura/



#### Git

# If git/ doesn't exist, make it
[[ -d git ]] || mkdir "git"

# copy files over
cp -af "${HOME}/.gitignore_global" "./git/"
cp -af "${HOME}/.gitconfig" "./git/"



#### Zsh

# If zsh/ doesn't exist, make it
[[ -d zsh ]] || mkdir zsh

# copy files over
cp -af "${HOME}/.zshrc" ./zsh/
cp -af "${HOME}/.zshenv" ./zsh/



#### UltiSnips

# you know the drill
[[ -d UltiSnips ]] || mkdir UltiSnips
cp -aRf "${VIM_DIR}/UltiSnips/." UltiSnips/



#### Vim

[[ -d vim ]] || mkdir vim
cp -af "${HOME}/.vimrc" ./vim/
cp -af "${VIM_DIR}/coc-settings.json" ./vim/



#### Miscellaneous dotfiles

cp "${HOME}/.gdbinit" ./
cp "${HOME}/.pylintrc" ./
