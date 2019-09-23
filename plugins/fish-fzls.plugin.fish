# bind \cf '__fzf_find_file'
# bind \cr '__fzf_reverse_isearch'
# bind \eo '__fzf_cd'
# bind \eO '__fzf_cd --hidden'
# bind \cg '__fzf_open'
# bind \co '__fzf_open --editor'

function __fzls_files
    env FZLS_FILES=1 fzls $argv
end

function __fzls_dirs
    fzls $argv
end

function fzls_complete_files
    set -l last_word (commandline | awk '{print $NF}')
    begin; complete -C; __fzls_files $last_word; end \
        | fzf -d \t -1 -0 --ansi --header="$last_word" --height="80%" --tabstop=4 \
        | read -l token
    commandline -rt "$token"
end

function fzls_complete_dirs
    set -l last_word (commandline | awk '{print $NF}')
    begin; complete -C; __fzls_dirs $last_word; end \
        | fzf -d \t -1 -0 --ansi --header="$last_word" --height="80%" --tabstop=4 \
        | read -l token
    commandline -rt "$token"
end

function fzls_key_bindings
    bind \cx 'fzls_complete_files'
end

fzls_key_bindings
