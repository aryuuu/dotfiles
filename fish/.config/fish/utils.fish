function envsource --description 'Source environment file'
  set -f envfile "$argv"
  if not test -f "$envfile"
    echo "Unable to load $envfile"
    return 1
  end
  while read line
    if not string match -qr '^#|^$' "$line"
      set item (string split -m 1 '=' $line)
      set -gx $item[1] $item[2]
      echo "Exported key $item[1]"
    end
  end < "$envfile"
end

function lsbloat --description 'List all bloat package'
	pacman -Qdtq |  awk '{ printf $1; system("pacman -Qi " $1 " | grep Size | cut -d\":\" -f 2") } ' | sort -k3r,3 -k2nr,2
end

function keycheck -d 'Print keycode of pressed key'
	xev | awk -F'[ )]+' '/^KeyPress/ { a[NR+2] } NR in a { printf "%-3s %s\n", $5, $8 }'
end

function toppac -d 'List top packages by size'
	expac "%n %m" -H M -l'\n' -Q $(pacman -Qqet) | sort -rhk 2 | less
end

function sumpac -d 'Sum package size'
	expac -H G '%m' | awk '{sum += $1}END {print sum, $2}'
end

function expose -d 'Expose local port to internet'
    if test -z $argv[1]
        echo "Please input source port"
    else
        ssh -NR receptor.aryuuu.com:4000:localhost:$argv[1] linode-aryuuu
    end
end

function togif -d 'Convert video to gif'
	if test -z $argv[1]
		echo "Please specify filename"
	else
		ffmpeg -i $argv[1] -vf "fps=10,scale=320:-1:flags=lanczos" -c:v pam -f image2pipe - | convert -delay 10 - -loop 0 -layers Optimize $argv[1].gif
		# ffmpeg -i $1 -vf "fps=10,scale=640:-1:flags=lanczos,split[s0][s1];[s0]palettegen[p];[s1][p]paletteuse" -loop 0 ${1}.gif
	end
end

function docatt -d 'Attach to running container'
    set cid (docker ps -a | sed 1d | fzf -1 -q "$argv" --bind 'alt-j:down' --bind 'alt-k:up' | awk '{print $1}')

    if test -n "$cid"
        docker start $cid; and docker attach $cid
    end
end

function docsh -d 'Open shell in a running container'
	set cid (docker ps | sed 1d | fzf -1 -q "$argv" --bind 'alt-j:down' --bind 'alt-k:up' | awk '{print $1}')

	if test -n "$cid"
		docker exec -it $cid /bin/sh
	end
end

function docex -d 'Open shell in a running container'
	set cid (docker ps | sed 1d | fzf -1 -q "$argv" --bind 'alt-j:down' --bind 'alt-k:up' | awk '{print $1}')

	if test -n "$cid"
		docker start $cid; and docker exec -it $cid /bin/sh
	end
end

function docstop -d 'Stop a running container'
    docker ps | sed 1d | fzf -q "$1" -m --bind 'alt-j:down' --bind 'alt-k:up' | awk '{print $1}' | xargs -r docker stop
end

function docrem -d 'Remove a container'
	docker ps | sed 1d | fzf -q "$1" -m --bind 'alt-j:down' --bind 'alt-k:up' | awk '{print $1}' | xargs -r docker rm
end

function docremi -d 'Remove a docker image'
	docker images | sed 1d | fzf -q "$1" -m --bind 'alt-j:down' --bind 'alt-k:up' | awk '{print $3}' | xargs -r docker rmi
end
