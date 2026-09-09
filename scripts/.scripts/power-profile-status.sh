#!/usr/bin/env bash

case $(powerprofilesctl get) in
    performance) echo '󰓅' ;;
    balanced)    echo '󰾅' ;;
    power-saver) echo '󰾆' ;;
esac
