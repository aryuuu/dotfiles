if status is-interactive
    # Commands to run in interactive sessions can go here
end

bind \ef "tmux-sessionizer"
bind \cf "tmux-sessionizer"

set PATH $PATH $HOME/.local/bin $HOME/go/bin $HOME/.scripts

# aliases
alias ls='ls --color=auto'
alias l='ls -lah'

alias c='xclip -selection clipboard'
alias lsw='nmcli d wifi list'
alias grep='grep --color=auto'
alias ranger='ranger --choosedir=$HOME/.rangerdir; LASTDIR=`cat $HOME/.rangerdir`; cd "$LASTDIR"'
alias webcam="mpv av://v4l2:/dev/video0"
alias printcolor="~/sandbox/python/colorprint.py"
alias transid="trans en:id"
alias pacgraph='pacgraph -b "#212326" -l "#FFF9C6" -t "#F5A069" -d "#C35C4D" -f "/home/fatt/Pictures/wallpaper/pacgraph"'

# navigations
alias cdf='cd ~/project/dotfiles'
alias cdp='cd ~/project'
alias cdx='cd ~/project/xendit'
alias cds='cd ~/sandbox'
alias cdc='cd ~/.config'
alias xpn='openvpn ~/project/xendit/vpn/client.ovpn'

