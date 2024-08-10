# #!/usr/bin/env bash

# select_from() {
#   local c
#   for c; do
#     if command -v "${c%% *}" &> /dev/null; then
#       echo "$c"
#       return 0
#     fi
#   done
#   return 1
# }

# preview=$(select_from 'bat --color=always --style=header,numbers -H {2} {1}' 'cat {1}')

# command=$(select_from 'rg -n --color=always' 'grep -Rn --color=always')

# fzf -d: \
# --ansi \
# --query="$1" \
# --phony \
# --bind="change:reload:$command {q}" \
# --bind="start:reload:$command {q}" \
# --bind='enter:execute:$EDITOR {1}' \
# --preview-window='+{2}-/2' \
# --preview="[[ -n {1} ]] && $preview"

# #!/usr/bin/env bash

# # Minimum number of characters required to trigger search
# MIN_CHARS=3

# # Define preview and command directly since you have 'bat' and 'rg'
# preview='bat --color=always --style=header,numbers -H {2} {1}'
# command='rg -n --color=always'

# fzf -d: \
# --ansi \
# --query="$1" \
# --phony \
# --bind="change:reload:if [[ \${#q} -ge $MIN_CHARS ]]; then $command {q}; else echo 'Query too short...'; fi" \
# --bind="start:reload:if [[ \${#q} -ge $MIN_CHARS ]]; then $command {q}; else echo 'Query too short...'; fi" \
# --bind='enter:execute:$EDITOR {1} +{2}' \
# --preview-window='+{2}-/2' \
# --preview="[[ -n {1} ]] && $preview"

# #!/usr/bin/env bash

# # Minimum number of characters required to trigger search
# MIN_CHARS=3

# # Define the preview and command directly
# preview='bat --color=always --style=header,numbers -H {2} {1}'
# command='rg -n --color=always'

# fzf -d: \
# --ansi \
# --query="$1" \
# --phony \
# --bind="change:reload:echo -n \${q} | awk 'length(\$0) >= $MIN_CHARS' && $command {q}" \
# --bind="start:reload:echo -n \${q} | awk 'length(\$0) >= $MIN_CHARS' && $command {q}" \
# --bind='enter:execute:$EDITOR {1} +{2}' \
# --preview-window='+{2}-/2' \
# --preview="[[ -n {1} ]] && $preview"

#!/usr/bin/env bash

# Minimum number of characters required to trigger search
MIN_CHARS=3

# Define preview and command directly since you have 'bat' and 'rg'
preview='bat --color=always --style=header,numbers -H {2} {1}'
command='rg -n --color=always'

# Function to check query length and execute command if valid
reload_command() {
  if [[ ${#1} -ge $MIN_CHARS ]]; then
    $command "$1"
  else
    echo "Query too short..."
  fi
}

# Use fzf with external command for checking query length
fzf -d: \
--ansi \
--query="$1" \
--phony \
--bind="change:reload:$reload_command {q}" \
--bind="start:reload:$reload_command {q}" \
--bind='enter:execute:$EDITOR {1} +{2}' \
--preview-window='+{2}-/2' \
--preview="[[ -n {1} ]] && $preview"

