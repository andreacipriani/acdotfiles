# iTerm2 badge: show the current git branch in the top-right corner, so you can
# glance at a terminal/tab and see which branch (and agent task) it's on.
#
# Leave the iTerm2 Badge field (Settings > Profiles > General) empty — this sets
# the badge format directly via escape sequence.

_iterm_branch_badge() {
  emulate -L zsh

  local branch
  branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
  branch=${branch#agc--}  # strip personal branch prefix for a cleaner badge

  # OSC 1337 ; SetBadgeFormat = <base64 value> ST. Empty clears it outside a repo.
  printf '\e]1337;SetBadgeFormat=%s\a' "$(print -rn -- "$branch" | base64)"
}

autoload -Uz add-zsh-hook
add-zsh-hook precmd _iterm_branch_badge
