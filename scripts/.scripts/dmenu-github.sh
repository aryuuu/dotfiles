#!/usr/bin/env bash

# uncomment for debugging
# set -o xtrace

GITHUB_TOKEN=$(<~/.config/gh/dmenu_github_token)

query=$(cat ~/.cache/dmenu-github | dmenu -c -fn "FontAwesome" -p " "  -l 5 -sb '#6272A4' -sf '#F8F8F2' -nb '#282A36' -nf '#F8F8F2' -shb '#6272A4' -shf '#FA485D' -nhb '#282A36' -nhf '#FA485D' | tr ' ' '+' )

if [[ -z $query ]];
then
    notify-send "dmenu github" "Please input a query"
    exit 1
fi

selected_repo=''
if grep -Fxq $query ~/.cache/dmenu-github; then
    selected_repo=$query
else
    selected_repo=$(curl -L \
      -H "Accept: application/vnd.github+json" \
      -H "Authorization: Bearer $GITHUB_TOKEN" \
      -H "X-GitHub-Api-Version: 2022-11-28" \
      https://api.github.com/search/repositories\?q\=$query \
      | jq '.items[] | .full_name' \
      | tr -d '"' \
      | dmenu -c -fn "FontAwesome" -p " "  -l 5 -sb '#6272A4' -sf '#F8F8F2' -nb '#282A36' -nf '#F8F8F2' -shb '#6272A4' -shf '#FA485D' -nhb '#282A36' -nhf '#FA485D')

    if [[ -z $selected_repo ]];
    then
        notify-send "dmenu github" "Please select a repo"
        exit 1
    fi

    echo $selected_repo >> ~/.cache/dmenu-github
fi

xdg-open https://github.com/$selected_repo 2> /dev/null
