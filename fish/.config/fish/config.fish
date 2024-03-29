if status is-interactive
    # Commands to run in interactive sessions can go here
end

# disable fish greeting
set fish_greeting

bind \ef "tmux-sessionizer"
bind \cf "tmux-sessionizer"

set PATH $PATH $HOME/.local/bin $HOME/go/bin $HOME/.cargo/bin $HOME/.scripts /usr/lib/jvm/default

# aliases
alias ls='ls --color=auto'
alias l='ls -lah'

alias c='xclip -selection clipboard'
alias lsw='nmcli d wifi list'
alias grep='grep --color=auto'
alias ranger='ranger --choosedir=$HOME/.rangerdir; LASTDIR=`cat $HOME/.rangerdir`; cd "$LASTDIR"'
alias lf='~/.config/lf/lfrun'
alias webcam="mpv av://v4l2:/dev/video0"
alias printcolor="~/sandbox/python/colorprint.py"
alias transid="trans en:id"
alias pacgraph='pacgraph -b "#212326" -l "#FFF9C6" -t "#F5A069" -d "#C35C4D" -f "/home/fatt/Pictures/wallpaper/pacgraph"'
alias argoon='argoonboard'

# navigations
alias cdf='cd ~/project/dotfiles'
alias cdp='cd ~/project'
alias cdx='cd ~/project/xendit'
alias cds='cd ~/sandbox'
alias cdc='cd ~/.config'
alias xpn='openvpn ~/project/xendit/vpn/client.ovpn'

# git
alias gst='git status'
alias glgg='git log --graph'
alias gds='git diff --staged'
alias gd='git diff'
alias glo='git log --oneline --decorate'
alias glog='git log --oneline --decorate --graph'

source $HOME/.config/fish/utils.fish
