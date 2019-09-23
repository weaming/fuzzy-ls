#!/usr/bin/env fish

set name 'fish-fzpath'
set repo "https://github.com/weaming/fuzzy-path.git"
set target /tmp/fuzzy-path
set plugin $target/plugins/$name.plugin.fish
set config $HOME/.config/fish/conf.d/$name.fish

if test -d $target
    rm -rf $target
end
echo clone to $target
git clone $repo $target
cp $plugin $config


pip3 install -U fuzzy-path

