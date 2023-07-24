#!/usr/bin/env bash

GITHUB_TOKEN=$(<~/.config/gh/dmenu_github_token)

query=$(echo " " | dmenu -c -fn "FontAwesome" -p " "  -l 5 -sb '#6272A4' -sf '#F8F8F2' -nb '#282A36' -nf '#F8F8F2' -shb '#6272A4' -shf '#FA485D' -nhb '#282A36' -nhf '#FA485D' | tr ' ' '+' )

if [[ -z $query ]];
then
    notify-send "dmenu github" "Please input a query"
    exit 1
fi

selected_repo=$(curl -L \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer $GITHUB_TOKEN" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  https://api.github.com/search/repositories\?q\=$query \
  | jq '.items[] | .full_name' \
  | tr -d '"' \
  | dmenu -c -fn "FontAwesome" -p " "  -l 5 -sb '#6272A4' -sf '#F8F8F2' -nb '#282A36' -nf '#F8F8F2' -shb '#6272A4' -shf '#FA485D' -nhb '#282A36' -nhf '#FA485D')

xdg-open https://github.com/$selected_repo
