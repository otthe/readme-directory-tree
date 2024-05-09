#!/usr/bin/env bash

#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!#
#*********************************#
#.......Make sure you have........#
#*********************************#

#<!-- TREEVIEW START -->
#<!-- TREEVIEW END -->

#*********************************#
#Tags inserted into your README.md#
#*********************************#
#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!#

# Default usage (outputs to README.md in the current directory):
# ./treeview.sh

# Specifying a directory:
# ./treeview.sh some_directory

# Specifying a directory and a different README.md file:
# ./treeview.sh some_directory /path/to/another/README.md

# Specifying a directory, README.md file, and a specific maximum depth:
# ./treeview.sh some_directory /path/to/another/README.md 2

shopt -s nullglob
dir_count=0
max_depth=-1  # -1 means unlimited depth

# list of directories to ignore
IGNORED_DIRS=("node_modules" ".git")

traverse() {
  dir_count=$((dir_count + 1))
  local directory=$1
  local prefix=$2
  local depth=$3

  if [[ $max_depth -ne -1 && $depth -ge $max_depth ]]; then
    return
  fi

  local children=("$directory"/*)
  local child_count=${#children[@]}

  for idx in "${!children[@]}"; do
    local child=${children[$idx]}
    local child_name=${child##*/}

    if [[ " ${IGNORED_DIRS[@]} " =~ " $child_name " ]]; then
      continue
    fi

    local child_prefix="│   "
    local pointer="├── "

    if [ $idx -eq $((child_count - 1)) ]; then
      pointer="└── "
      child_prefix="    "
    fi

    if [ -d "$child" ]; then
      echo "${prefix}${pointer}${child_name}/"
      traverse "$child" "${prefix}$child_prefix" $((depth + 1))
    fi
  done
}

generate_tree() {
  local root=$1
  dir_count=0
  {
    traverse "$root" "" 0
    echo
    echo "$(($dir_count - 1)) directories"
  } | sed '$d'
}

insert_tree_into_readme() {
  local readme=$1
  local tree_content=$2

  tree_content="\`\`\`bash\\n$tree_content\\n\`\`\`"

  # escape newlines for insertion in `sed`
  tree_content=$(echo "$tree_content" | sed ':a;N;$!ba;s/\n/\\n/g')

  # macOS uses `sed -i ''`, other Unix systems use `sed -i`
  if [[ "$OSTYPE" == "darwin"* ]]; then
    sed -i '' -e '/<!-- TREEVIEW START -->/,/<!-- TREEVIEW END -->/c\
<!-- TREEVIEW START -->\
'"$tree_content"'\
\\n<!-- TREEVIEW END -->' "$readme"
  else
    sed -i -e '/<!-- TREEVIEW START -->/,/<!-- TREEVIEW END -->/c\
<!-- TREEVIEW START -->\
'"$tree_content"'\
\n<!-- TREEVIEW END -->' "$readme"
  fi
}

root="."
readme="README.md"
if [ "$#" -ge 1 ]; then
  root="$1"
fi
if [ "$#" -ge 2 ]; then
  readme="$2"
fi
if [ "$#" -ge 3 ]; then
  max_depth="$3"
fi

tree_output=$(generate_tree "$root")
insert_tree_into_readme "$readme" "$tree_output"

shopt -u nullglob