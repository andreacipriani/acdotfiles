# fzf custom functions, inspired by https://github.com/junegunn/fzf#fuzzy-completion-for-bash-and-zsh https://github.com/junegunn/fzf/wiki/examples

shelp() {
    echo "□ shome - search from home\n□ ss - open in editor\n□ scd - change dir \n□ scdh - change dir from home\n□ shr - history\n□ sbr - branch history\n□ spath - copy path"
}

#shome - search from home
shome() {
  currentDir=$(pwd)
  cd
  fzf --height 40% --reverse --border
  cd $currentDir
}

# ss - fuzzy search and open with editor
ss() {
  local files
  IFS=$'\n' files=($(fzf --query="$1" --multi --select-1 --exit-0))
  [[ -n "$files" ]] && "${EDITOR:-vim}" "${files[@]}"
}

# scd - fuzzy cd into directories
scd() {
  echo "executing scd"
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune -o -type d -print 2> /dev/null | fzf +m)
  echo $dir
  cd "$dir"
}

# scd - fuzzy cd into directories starting from home
scdh() {
  cd
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune -o -type d -print 2> /dev/null | fzf +m)
  cd "$dir"
}

# scat - fuzzy cat content of selected file
scat() {
  local files
  IFS=$'\n' files=($(fzf --query="$1" --multi --select-1 --exit-0))
  [[ -n "$files" ]] && cat "${files[@]}"
}

# shr - fuzzy search in history
shr() {
  local cmd
  cmd=$( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf --tac | sed 's/ *[0-9]* *//')
  echo "copied command: $cmd"
  echo "$cmd" | pbcopy
}

# sbr - checkout git branch (including remote branches), sorted by most recent commit, limit 30 last branches
sbr() {
  local branches branch
  branches=$(git for-each-ref --count=30 --sort=-committerdate refs/heads/ --format="%(refname:short)") &&
  branch=$(echo "$branches" |
           fzf --height 40% --reverse --border +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

# spwd - fuzzy search and copy path
spath() {
  local files
  IFS=$'\n' files=($(fzf --query="$1" --multi --select-1 --exit-0))
  echo ${files[@]}
  echo ${files[@]} | pbcopy
  echo "copied path: ${files[@]}"
}
