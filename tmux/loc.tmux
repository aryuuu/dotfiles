#!/usr/bin/env bash

# from https://github.com/tmux-plugins/tmux-urlview/blob/master/urlview.tmux
# we can use the general idea for loc.tmux plugin 
#
# read string in the "buffer"
# parse loc string (strings with /a/b/c:123:456 format)
# list it in a new pane
# open selected item in neovim
# if a window named "neovim" exist, open it there
# else open it in the current window
#
# /home/fatt/project/xendit/xendit-user-service/src/app.js:12:20
# /home/fatt/project/cepex-server/models/image.go:30:5 , /home/fatt/project/wiki-graph/src/main.rs:10:3

# rg command to match these loc strings
rg --no-heading --line-number --column --color=never --smart-case '.*:[0-9]+:[0-9]+' | fzf
rg '(\/)'


select_loc() {
}

get_tmux_option() {
  local option=$1
  local default_value=$2
  local option_value=$(tmux show-option -gqv "$option")
  if [ -z $option_value ]; then
    echo $default_value
  else
    echo $option_value
  fi
}

find_executable() {
  if type urlview >/dev/null 2>&1; then
    echo "urlview"
  elif type extract_url >/dev/null 2>&1; then
    echo "extract_url"
  fi
}

readonly key="$(get_tmux_option "@urlview-key" "u")"
readonly cmd="$(find_executable)"

if [ -z "$cmd" ]; then
  tmux display-message "Failed to load tmux-loc: loc bin is not found in $PATH"
else
  tmux bind-key "$key" capture-pane -J \\\; \
    save-buffer "${TMPDIR:-/tmp}/tmux-buffer" \\\; \
    delete-buffer \\\; \
    split-window -l 10 "$cmd '${TMPDIR:-/tmp}/tmux-buffer'"
fi
