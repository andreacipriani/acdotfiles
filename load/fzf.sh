# fzf custom functions, inspired by https://github.com/junegunn/fzf#fuzzy-completion-for-bash-and-zsh https://github.com/junegunn/fzf/wiki/examples

shelp() {
    echo "□ shome - search from home\n□ ss - open in editor\n□ scd - change dir \n□ scdh - change dir from home\n□ shr - history\n□ sbr - brancheshistory\n□ spath - copy path"
}

#Search from home
shome() {
  currentDir=$(pwd)
  cd
  fzf-tmux
  cd $currentDir
}

# ss - fuzzy search and open with editor
ss() {
  local files
  IFS=$'\n' files=($(fzf-tmux --query="$1" --multi --select-1 --exit-0))
  [[ -n "$files" ]] && ${EDITOR:-$EDITOR} "${files[@]}"
}

# scd - fuzzy cd into directories

scd() {
  echo "executing scd"
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune -o -type d -print 2> /dev/null | fzf-tmux +m)
  echo $dir
  cd "$dir"
}

# scd - fuzzy cd into directories starting from home

scdh() {
  cd
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune -o -type d -print 2> /dev/null | fzf-tmux +m)
  cd "$dir"
}

# scat - fuzzy cat content of selecte file

scat() {
  local files
  IFS=$'\n' files=($(fzf-tmux --query="$1" --multi --select-1 --exit-0))
  cat ${files[@]}
}

# shr - fuzzy search in history

shr() {
  local cmd
  cmd=$( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf-tmux +s --tac | sed 's/ *[0-9]* *//')
  echo "copyied command: $cmd"
  echo "$cmd" | pbcopy
}

# sbr - checkout git branch (including remote branches), sorted by most recent commit, limit 30 last branches
sbr() {
  local branches branch
  branches=$(git for-each-ref --count=30 --sort=-committerdate refs/heads/ --format="%(refname:short)") &&
  branch=$(echo "$branches" |
           fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

# spwd - fuzzy search and copy path
spath() {
  local files
  IFS=$'\n' files=($(fzf-tmux --query="$1" --multi --select-1 --exit-0))
  echo ${files[@]}
  echo ${files[@]} | pbcopy
  echo "copyied path: ${files[@]}"
}

gheios() {
  local files
  IFS=$'\n' files=($(fzf-tmux --query="$1" --multi --select-1 --exit-0))
  echo ${files[@]}
  echo ${files[@]} | pbcopy
  echo "opening path: ${files[@]} on ghe"
  open "https://TODO/blob/master/${files[@]}"
}