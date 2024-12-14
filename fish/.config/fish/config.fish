if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -x EDITOR vim

# disable fish greeting
set fish_greeting

set PATH $PATH $HOME/.local/bin $HOME/go/bin $HOME/.cargo/bin $HOME/.scripts /usr/lib/jvm/default
set EDITOR nvim
set NOMAD_ADDR http://localhost:4646

function edit_command_buffer --description 'Edit the current command buffer in $EDITOR'
    set -l tmpfile (mktemp -t fish_command.XXXXXX)
    commandline > $tmpfile
    vim $tmpfile
    commandline -r (cat $tmpfile)
    rm $tmpfile
end

bind \et "tmux attach"
bind \ef "tmux-sessionizer"
bind -k f9 "sed -i 's/size = [0-9.]\\+/size = 9.5/' ~/.config/alacritty/alacritty.toml"
bind -k f10 "sed -i 's/size = [0-9.]\\+/size = 20/' ~/.config/alacritty/alacritty.toml"
# bind \ce edit_command_buffer
# bind \cf "tmux-sessionizer"

# aliases
alias nv='nvim'
alias ls='ls --color=auto'
alias l='ls -lah'

alias c='xclip -selection clipboard'
alias y='wl-copy'
alias lsw='nmcli d wifi list'
alias grep='grep --color=auto'
alias ranger='ranger --choosedir=$HOME/.rangerdir; set LASTDIR $(cat $HOME/.rangerdir); cd "$LASTDIR"'
alias lf='~/.config/lf/lfrun'
alias webcam="mpv av://v4l2:/dev/video0"
alias printcolor="~/sandbox/python/colorprint.py"
alias transid="trans en:id"
alias pacgraph='pacgraph -b "#212326" -l "#FFF9C6" -t "#F5A069" -d "#C35C4D" -f "/home/fatt/Pictures/wallpaper/pacgraph"'
alias argoon='argoonboard'
alias unset 'set --erase'

# navigations
alias cdf='cd ~/project/dotfiles'
alias cdp='cd ~/project'
alias cdx='cd ~/project/xendit'
alias cdg='cd ~/project/grvt'
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

# nix
alias nixos-gens='sudo nix-env --list-generations --profile /nix/var/nix/profiles/system'

source $HOME/.config/fish/utils.fish
