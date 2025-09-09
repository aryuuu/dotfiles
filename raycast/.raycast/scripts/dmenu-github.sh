#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title GitHub Repo Search
# @raycast.mode fullOutput
# @raycast.packageName GitHub Tools
# @raycast.argument1 { "type": "text", "placeholder": "Repository name" }

# Optional parameters:
# @raycast.icon 🔍
# @raycast.refreshTime 1h
# @raycast.needsConfirmation false

GITHUB_TOKEN=$(<~/.config/gh/dmenu_github_token)
query=$1

if [[ -z $query ]]; then
  echo "Please provide a repository name"
  exit 1
fi

# Search for repositories
repos=$(curl -L \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer $GITHUB_TOKEN" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  "https://api.github.com/search/repositories?q=xendit/$query" \
  | jq -r '.items[] | .full_name')

# If no results found
if [[ -z $repos ]]; then
  echo "No repositories found"
  exit 1
fi

# Save to cache and open in browser
selected_repo=$(echo "$repos" | head -n 1)
echo "$selected_repo" >> ~/.cache/raycast-github
open "https://github.com/$selected_repo"
