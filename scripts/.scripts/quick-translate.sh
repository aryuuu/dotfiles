#!/usr/bin/env bash

# TODO: get the string highlighted in any desktop app
# TODO: open url with the string in the browser

raw_string=$(xclip -o | tr ' ' '+')

full_url="https://translate.google.com/?sl=en&tl=id&text=$raw_string&op=translate"

xdg-open $full_url
