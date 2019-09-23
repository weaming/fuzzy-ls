#!/usr/bin/env fish

set name 'fish-fzls'
set repo "https://github.com/weaming/fuzzy-ls.git"
set target /tmp/fuzzy-ls
set plugin $target/plugins/$name.plugin.fish
set config $HOME/.config/fish/conf.d/fuzzy-ls.fish

echo clone to $target
git clone $repo $target
cp $plugin $config

pip3 install -U fuzzy-ls

