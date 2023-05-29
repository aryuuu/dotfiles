
jump () {
	mkdir -p $1
	cd $1
}

brg () {
	if [ $2 ]; then
		xrandr --output eDP-1 --output HDMI-1 --brightness $1
	else
		xrandr --output HDMI-1 --brightness $1
	fi
}

# monitor
dualmon () {
	xrandr --output HDMI-1 --auto --above eDP-1
}

smon () {
	xrandr --output HDMI-1 --off && i3-msg restart
}

vmon () {
	xrandr --output HDMI-1 --auto --above eDP-1
}

hmon() {
	xrandr --output HDMI-1 --auto --right-of eDP-1
}

wconn () {
	nmcli d wifi connect $1 password $2
}

wconnu () {
	nmcli d wifi connect $1 username $2 password $3
}

test-microphone() {
	arecord -vvv -f dat /dev/null
}

mp3-dl () {
	youtube-dl -x --audio-format mp3 "ytsearch:\"${@}\""

}

keycheck () {
	xev | awk -F'[ )]+' '/^KeyPress/ { a[NR+2] } NR in a { printf "%-3s %s\n", $5, $8 }'
}

colors () {
	for i in {0..255}; do
		printf "\x1b[38;5;${i}mcolour${i}\x1b[0m\n"
	done
}

# eduka
std-eduka-sql () {
	sed -i $1 -e 's/utf8mb4_0900_ai_ci/utf8mb4_unicode_ci/g'
}

eduka-mr () {
	xclip -i ~/project/eduka/mr-template -selection clipboard
}

# pacman
lsbloat () {
	pacman -Qdtq |  awk '{ printf $1; system("pacman -Qi " $1 " | grep Size | cut -d\":\" -f 2") } ' | sort -k3r,3 -k2nr,2
}

toppac () {
	expac "%n %m" -H M -l'\n' -Q $(pacman -Qqet) | sort -rhk 2 | less
}

sumpac () {
	expac -H G '%m' | awk '{sum += $1}END {print sum, $2}'
}

expose () {
	if [[ -z $1 ]]; then
		echo "Please input source port"	
	else
		ssh -NR receptor.aryuuu.com:4000:localhost:$1 linode-aryuuu
	fi
}

exposetcp () {
	if [[ -z $1 ]]; then
		echo "Please input source port"
	else 
		ssh -NR tcp.receptor.aryuuu.com:4001:localhost:$1 linode-aryuuu
	fi
}

togif() {
	if [[ -z $1 ]]; then
		echo "Please specify filename"
	else
		ffmpeg -i $1 -vf "fps=10,scale=640:-1:flags=lanczos,split[s0][s1];[s0]palettegen[p];[s1][p]paletteuse" -loop 0 ${1}.gif
	fi
}

xpn() {
    openvpn ~/project/xendit/vpn/client.ovpn
}

## docker fzf functions

# select a docker container to start and attach to
docatt() {
    local cid 
    cid=$(docker ps -a | sed 1d | fzf -1 -q "$1" --bind 'alt-j:down' --bind 'alt-k:up' | awk '{print $1}')

    [ -n "$cid" ] && docker start "$cid" && docker attach "$cid"
}

# select a running container to stop
docstop() {
    # local cid
    # cid=$(docker ps | sed 1d | fzf -q "$1" | awk '{print $1}')
    docker ps | sed 1d | fzf -q "$1" -m --bind 'alt-j:down' --bind 'alt-k:up' | awk '{print $1}' | xargs -r docker stop
    
    # [ -n "$cid" ] && docker stop "$cid"
}

# select one or more running container to remove
docrem() {
    local cid
    docker ps | sed 1d | fzf -q "$1" --no-sort -m --bind 'alt-j:down' --bind 'alt-k:up' | awk '{print $1}' | xargs -r docker rm
    
    [ -n "$cid" ] && docker rm "$cid"
}

# select docker image or images to remove
docremi() {
    local cid
    docker images | sed 1d | fzf -q "$1" --no-sort -m --bind 'alt-j:down' --bind 'alt-k:up' | awk '{print $3}' | xargs -r docker rmi
    
}

chfreq() {
	git log --pretty=format: --name-only | sort | uniq -c | sort -rg | head -20
}

