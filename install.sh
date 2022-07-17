#!/bin/bash
HOST_CONFIG_DIR=$HOME/.config
REPO_CONFIG_DIR=$(pwd)/.config

HOST_SCRIPTS_DIR=$HOME/.scripts
REPO_SCRIPTS_DIR=$(pwd)/.scripts

REPO_ROOT_DIR=$(pwd)

ln -f $REPO_CONFIG_DIR/compton.conf $HOST_CONFIG_DIR/compton.conf
ln -f $REPO_CONFIG_DIR/i3/config $HOST_CONFIG_DIR/i3/config
ln -f $REPO_CONFIG_DIR/polybar/config $HOST_CONFIG_DIR/polybar/config
ln -f $REPO_CONFIG_DIR/polybar/colors.ini $HOST_CONFIG_DIR/polybar/colors.ini
ln -f $REPO_CONFIG_DIR/polybar/modules.ini $HOST_CONFIG_DIR/polybar/modules.ini
ln -f $REPO_CONFIG_DIR/dunst/dunstrc $HOST_CONFIG_DIR/dunst/dunstrc
ln -f $REPO_CONFIG_DIR/ranger/rc.conf $HOST_CONFIG_DIR/ranger/rc.conf
ln -f $REPO_CONFIG_DIR/sway/config $HOST_CONFIG_DIR/sway/config
ln -f $REPO_CONFIG_DIR/waybar/config $HOST_CONFIG_DIR/waybar/config 

mkdir -p $HOST_CONFIG_DIR/mpv/scripts
ln -f $REPO_CONFIG_DIR/mpv/mpv.conf $HOST_CONFIG_DIR/mpv/mpv.conf
ln -f $REPO_CONFIG_DIR/mpv/input.conf $HOST_CONFIG_DIR/mpv/input.conf
ln -f $REPO_CONFIG_DIR/mpv/encoding.rst $HOST_CONFIG_DIR/mpv/encoding.rst
ln -f $REPO_CONFIG_DIR/mpv/scripts/recent.lua $HOST_CONFIG_DIR/mpv/scripts/recent.lua

mkdir -p $HOST_SCRIPTS_DIR/backlight
ln -f $REPO_SCRIPTS_DIR/backlight/dec $HOST_SCRIPTS_DIR/backlight/dec
ln -f $REPO_SCRIPTS_DIR/backlight/inc $HOST_SCRIPTS_DIR/backlight/inc
ln -f $REPO_SCRIPTS_DIR/backlight/exdec $HOST_SCRIPTS_DIR/backlight/exdec
ln -f $REPO_SCRIPTS_DIR/backlight/exinc $HOST_SCRIPTS_DIR/backlight/exinc
ln -f $REPO_SCRIPTS_DIR/backlight/exval $HOST_SCRIPTS_DIR/backlight/exval

mkdir $HOST_SCRIPTS_DIR/dpms
ln -f $REPO_SCRIPTS_DIR/dpms/status $HOST_SCRIPTS_DIR/dpms/status
ln -f $REPO_SCRIPTS_DIR/dpms/toggle $HOST_SCRIPTS_DIR/dpms/toggle

mkdir $HOST_SCRIPTS_DIR/i3blocks
ln -f $REPO_SCRIPTS_DIR/i3blocks/bandwidth $HOST_SCRIPTS_DIR/i3blocks/bandwidth
ln -f $REPO_SCRIPTS_DIR/i3blocks/battery $HOST_SCRIPTS_DIR/i3blocks/battery

mkdir $HOST_SCRIPTS_DIR/powerline
ln -f $REPO_SCRIPTS_DIR/powerline/powerline.sh $HOST_SCRIPTS_DIR/powerline/powerline.sh

mkdir $HOST_SCRIPTS_DIR/sshmenu
ln -f $REPO_SCRIPTS_DIR/sshmenu/sshmenu $HOST_SCRIPTS_DIR/sshmenu/sshmenu

ln -f $REPO_SCRIPTS_DIR/todo.sh $HOST_SCRIPTS_DIR/todo.sh
ln -f $REPO_SCRIPTS_DIR/utils $HOST_SCRIPTS_DIR/utils

ln -f $REPO_ROOT_DIR/.aliasrc $HOME/.aliasrc
ln -f $REPO_ROOT_DIR/.p10k.zsh $HOME/.p10k.zsh
ln -f $REPO_ROOT_DIR/.vimrc $HOME/.vimrc
ln -f $REPO_ROOT_DIR/.xbindkeysrec $HOME/.xbindkeysrec
ln -f $REPO_ROOT_DIR/.Xdefaults $HOME/.Xdefaults
ln -f $REPO_ROOT_DIR/.zshrc $HOME/.zshrc
