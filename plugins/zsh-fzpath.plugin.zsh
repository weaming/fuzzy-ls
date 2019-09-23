#!/usr/bin/env zsh
#
# Copyright 2019-2049 weaming
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

__zic_fzf_prog() {
  [ -n "$TMUX_PANE" ] && [ "${FZF_TMUX:-0}" != 0 ] && [ ${LINES:-40} -gt 15 ] \
    && echo "fzf-tmux -d${FZF_TMUX_HEIGHT:-40%}" || echo "fzf"
}

_zic_complete() {
  setopt localoptions nonomatch
  local l matches fzf tokens base

  l=$(fzpath $@[-1])

  if [ -z "$l" ]; then
    zle ${__zic_default_completion:-expand-or-complete}
    return
  fi

  fzf=$(__zic_fzf_prog)

  if [ $(echo $l | wc -l) -eq 1 ]; then
    matches=${(q)l}
  else
    matches=$(echo $l \
        | FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} \
          --reverse $FZF_DEFAULT_OPTS $FZF_COMPLETION_OPTS \
          --bind 'shift-tab:up'" ${=fzf} \
        | while read -r item; do
      echo -n "${(q)item} "
    done)
  fi

  matches=${matches% }
  if [ -n "$matches" ]; then
    tokens=(${(z)LBUFFER})
    base="${(Q)@[-1]}"
    if [[ "$base" != */ ]]; then
      if [[ "$base" == */* ]]; then
        base="$(dirname -- "$base")"
        if [[ ${base[-1]} != / ]]; then
          base="$base/"
        fi
      else
        base=""
      fi
    fi
    LBUFFER="${tokens[1,-2]} "
    if [ -n "$base" ]; then
      base="${(q)base}"
      if [ "${tokens[-1][1]}" = "~" ]; then
        base="${base/#$HOME/~}"
      fi
      LBUFFER="${LBUFFER}${base}"
    fi
    LBUFFER="${LBUFFER}${matches}"
    if [ -d "$LBUFFER" ]; then
        LBUFFER="$LBUFFER/"
    fi
  fi
  zle redisplay
  typeset -f zle-line-init >/dev/null && zle zle-line-init
}

__in() {
    local value x
    value="$1"
    shift
    for x in $@; do
        if [[ "$value" == "$x" ]]; then
            return 0
        fi
    done
    return 1
}

zic-completion() {
  setopt localoptions noshwordsplit noksh_arrays noposixbuiltins
  local tokens cmd

  tokens=(${(z)LBUFFER})
  cmd=${tokens[1]}

  if $(__in "$tokens[-1][1]" '~' '$'); then
    zle ${__zic_default_completion:-expand-or-complete}
  elif $(__in "$cmd" cdz rmdir mkdir open rm mv cd vi ls); then
    _zic_complete ${tokens[2,${#tokens}]/#\~/$HOME}
  else
    zle ${__zic_default_completion:-expand-or-complete}
  fi
}

[ -z "$__zic_default_completion" ] && {
  binding=$(bindkey '^I')
  # $binding[(s: :w)2]
  # The command substitution and following word splitting to determine the
  # default zle widget for ^I formerly only works if the IFS parameter contains
  # a space via $binding[(w)2]. Now it specifically splits at spaces, regardless
  # of IFS.
  [[ $binding =~ 'undefined-key' ]] || __zic_default_completion=$binding[(s: :w)2]
  unset binding
}

zle -N zic-completion
if [ -z $zic_custom_binding ]; then
  zic_custom_binding='^I'
fi
bindkey "${zic_custom_binding}" zic-completion

alias cdz=cd
