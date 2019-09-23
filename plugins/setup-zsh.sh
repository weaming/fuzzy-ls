#!/bin/bash

name='zsh-fzpath'
repo="https://github.com/weaming/fuzzy-path.git"
target="${ZSH_CUSTOM:-$HOME/.local/src}/plugins/$name"
plugin="$target/plugins/$name.plugin.zsh"

echo clone to $target
git clone "$repo" "$target"

pip3 install -U fuzzy-path

if [[ ! $(cat ~/.zshrc | grep $name) ]]; then
    echo "source $plugin" >> ~/.zshrc
fi
