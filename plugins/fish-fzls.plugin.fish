# reference: fzf bindings
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
    set -e FZLS_FILES
    fzls $argv
end

function fzls_complete_files -a last
    begin; complete -C; __fzls_files $last; end \
        | fzf -d \t -1 -0 --ansi --header="$last" --height="80%" --tabstop=4 \
        | read -l token
    commandline -rt "$token"
end

function fzls_complete_dirs -a last
    begin; complete -C; __fzls_dirs $last; end \
        | fzf -d \t -1 -0 --ansi --header="$last" --height="80%" --tabstop=4 \
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

function fzls_complete
    set -l cmd (commandline)
    set -l last (commandline | awk '{print $NF}')
    if startswith_any $cmd cd tree
        fzls_complete_dirs $last
    else
        fzls_complete_files $last
    end
end

function fzls_key_bindings
    bind \cs 'fzls_complete'
end

fzls_key_bindings
