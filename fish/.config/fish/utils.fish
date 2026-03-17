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
      # echo "Exported key $item[1]"
    end
  end < "$envfile"
end

function load_env_file
    set -l env_file "$argv[1]"
    if test -f $env_file
        set -l current_var
        set -l current_value

        for line in (cat $env_file | string trim)
            # Skip empty lines and lines starting with #
            if string match -qr '^#' $line; or test -z $line
                continue
            end

            # Check for a key=value format or a continuation line
            if string match -q '*=*' $line
                # If we are processing a multiline value, finalize the current variable
                if test -n "$current_var"
                    set -gx $current_var "$current_value"
                    set current_var
                    set current_value
                end

                # Split key=value, respecting quotes
                set -l key_value (string split '=' $line 1)
                set current_var $key_value[1]
                # set current_value (string trim -c '"' "'" $key_value[2])
                set current_value $key_value[2]
            else
                # Continuation of the previous variable
                set current_value "$current_value\n$line"
            end
        end

        # Finalize the last variable if it was multiline
        if test -n "$current_var"
            # echo $current_var $current_value
            set -gx $current_var "$current_value"
        end
    else
        echo "File not found: $env_file"
    end
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

function docstart -d 'Start a docker container from selected image'
	docker images | sed 1d | fzf -q "$1" -m --bind 'alt-j:down' --bind 'alt-k:up' | awk '{print $3}' | xargs -r docker run
end

function docshi -d 'Start a shell from selected image'
	set image_id (docker images | sed 1d | fzf -q "$1" -m --bind 'alt-j:down' --bind 'alt-k:up' | awk '{print $3}')

  if test -n "$image_id"
    docker run -it $image_id /bin/sh
  end
end

function uwuctx -d 'simpler version of kubectx'
  kubectl config get-contexts | awk '{ print $1 }'| fzf -q "$1" -m --bind 'alt-j:down' --bind 'alt-k:up' | kubectx config use-context
end

function xensearch -d 'search string in xendit dir'

end

function dev -d 'start a nix shell for development'
    nix develop --command fish
end

function q -d 'alias for amazon-q'
    amazon-q $argv
end

function oc -d 'alias for opencode'
    opencode
end

# function oc -d 'alias for opencode with kiro-cli support'
#     ~/project/opencode/result/bin/opencode
# end

# function nixos-gens
#     set -l current (readlink /var/run/current-system)
    
#     # List all NixOS generations with highlighting and additional details
#     nix-env -p /nix/var/nix/profiles/system --list-generations | while read -l generation path
#         set -l is_current (string match -q "$current" "$path" && echo "* " || echo "  ")
        
#         # Get generation creation date
#         set -l gen_info (stat -c "%y" "$path/activate" 2>/dev/null)
        
#         # Colorize output
#         if string match -q "$current" "$path"
#             set_color green
#         else
#             set_color normal
#         end
        
#         printf "%s%s: %s\n" "$is_current" "$generation" "$gen_info"
        
#         set_color normal
#     end
# end
