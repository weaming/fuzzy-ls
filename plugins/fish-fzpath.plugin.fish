# reference: fzf bindings
# bind \cf '__fzf_find_file'
# bind \cr '__fzf_reverse_isearch'
# bind \eo '__fzf_cd'
# bind \eO '__fzf_cd --hidden'
# bind \cg '__fzf_open'
# bind \co '__fzf_open --editor'

function __fzpath_files
    env fzpath_FILES=1 fzpath $argv
end

function __fzpath_dirs
    set -e fzpath_FILES
    fzpath $argv
end

function fzpath_complete_files -a last
    begin; complete -C; __fzpath_files $last; end \
        | fzf -d \t -1 -0 --ansi --header="$last" --height="30%" --tabstop=4 \
        | read -l token
    commandline -rt "$token"
end

function fzpath_complete_dirs -a last
    begin; complete -C; __fzpath_dirs $last; end \
        | fzf -d \t -1 -0 --ansi --header="$last" --height="30%" --tabstop=4 \
        | read -l token
    commandline -rt "$token"
end

function startswith_any
    for x in $argv[2..-1]
        if string match -r '^'$x $argv[1] >/dev/null
            return 0
        end
    end
    return 1
end

function fzpath_complete
    set -l cmd (commandline)
    set -l last (commandline | awk '{print $NF}')
    if startswith_any $cmd cd tree
        fzpath_complete_dirs $last
    else
        fzpath_complete_files $last
    end
end

function fzpath_key_bindings
    bind \cs 'fzpath_complete'
end

fzpath_key_bindings
