# Fuzzy `ls`

    pip3 install fuzzy-ls

## environments:

* `FZLS_FILES`: also list files (default list only directories)
* `ROOT`: the root directory to list

## Install for shells

Install [fzf](https://github.com/junegunn/fzf) by following its [installation instruction](https://github.com/junegunn/fzf#installation).

### Zsh

    curl -sS https://raw.githubusercontent.com/weaming/fuzzy-ls/master/plugins/setup-zsh.sh | ZSH_CUSTOM=$ZSH_CUSTOM bash

### Usage

Press `Ctrl+i` for completion, it'll launch fzf automatically. It will only complete the last part of your input command.
Check fzf’s [readme](https://github.com/junegunn/fzf#search-syntax) for more search syntax usage.

![demo](https://i.loli.net/2019/04/02/5ca35bf5d0151.png)

Support comamnds:

* cdz (the original purpose of the project)
* rmdir
* mkdir
* open
* rm
* mv
* cd
* vi
* ls

### Fish

    curl -sS https://raw.githubusercontent.com/weaming/fuzzy-ls/master/plugins/setup-fish.fish | fish
