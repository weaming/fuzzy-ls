#!/bin/bash

name='zsh-fzls'
repo="https://github.com/weaming/fuzzy-ls.git"
target="$ZSH_CUSTOM/plugins/$name"
plugin="$target/plugins/$name.plugin.zsh"

echo clone to $target
git clone "$repo" "$target"

pip3 install -U fuzzy-ls

if [[ ! $(cat ~/.zshrc | grep $name) ]]; then
    echo "source $plugin" >> ~/.zshrc
fi
