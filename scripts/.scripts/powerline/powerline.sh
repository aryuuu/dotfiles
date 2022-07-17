#!/bin/bash
#
# Beautiful powerline-style prompt written in pure bash, simple and very fast.
#
# Author  : Yuri Plashenkov
# Github  : https://github.com/plashenkov/powerline
# License : MIT License

__ps1() {
  # Colors (see "88/256 Colors" section):
  # http://misc.flogisoft.com/bash/tip_colors_and_formatting#colors1
  local user="\u"
  local user_bg_color=208
  local user_text_color=231
  local host="\h"
  local host_bg_color=172
  local host_text_color=231
  local host_bold=true
  local path_bg_color=240
  local path_text_color=252
  local path_separator_color=245
  local path_bold=false

  # Skip Midnight Commander
  if [ -z $MC_SID ]; then
    if [ "$host_bold" = true ]; then host_bold="1;"; else host_bold=""; fi
    if [ "$path_bold" = true ]; then path_bold="1;"; else path_bold=""; fi

    local path=$PWD

    if [ "$path" != "/" ]; then
      # Replace home directory with ~
      path=${path/#$HOME/\~}

      # Strip leading and trailing slashes
      path=${path#/}
      path=${path%/}

      # Strip too long path
      IFS="/" read -ra dirs <<< "$path"
      local dir_count=${#dirs[@]}

      if [ $dir_count -gt 4 ]; then
        path=".../${dirs[$dir_count-3]}/${dirs[$dir_count-2]}/${dirs[$dir_count-1]}"
      fi

      # Replace path separator (/) with powerline separator symbol
      path=${path//\//"\[\e[0;38;5;${path_separator_color};48;5;${path_bg_color}m\]  \[\e[${path_bold}38;5;${path_text_color}m\]"}
    fi

    PS1="\[\e[${host_bold}48;5;${user_bg_color};38;5;${user_text_color}m\] ${user} \[\e[0;38;5;${user_bg_color};48;5;${host_bg_color}m\]\[\e[${host_bold}48;5;${host_bg_color};38;5;${host_text_color}m\] ${host} \[\e[0;38;5;${host_bg_color};48;5;${path_bg_color}m\]\[\e[${path_bold}48;5;${path_bg_color};38;5;${path_text_color}m\] $path \[\e[0;38;5;${path_bg_color}m\]\[\e[0m\] "
  fi
}

PROMPT_COMMAND=__ps1
