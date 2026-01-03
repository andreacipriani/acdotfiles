export ANDREA_USERNAME=$(whoami)
export DOTFILES=$HOME/code/acdotfiles
export ZSH=$DOTFILES/oh-my-zsh
export CODE=~/code
export EDITOR='code'

# Load path and environment variables first
source "$DOTFILES/load/path.sh"

# Load all other shell files in /load
for file in "$DOTFILES"/load/*.sh; do
  if [[ "$(basename "$file")" != "path.sh" ]]; then
    source "$file"
  fi
done

# Load encrypted work files if they exist
if [[ -d "$DOTFILES/work-encrypted/load" ]]; then
  for file in "$DOTFILES"/work-encrypted/load/*.sh; do
    source "$file"
  done
fi

# Load autocompletions
autoload -U compinit
compinit
source "$DOTFILES/autocompletion/autocompletion.sh"

# Better history
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search # Up
bindkey "^[[B" down-line-or-beginning-search # Down

# iTerm2 integration
[[ -e "$HOME/.iterm2_shell_integration.zsh" ]] && source "$HOME/.iterm2_shell_integration.zsh"

# Disable auto correction
ENABLE_CORRECTION="false"

# Colorize different commands
[[ -s "/etc/grc.zsh" ]] && source /etc/grc.zsh

# Theme and prompt
export TERM="xterm-256color"
ZSH_THEME="bullet-train"
BULLETTRAIN_PROMPT_ORDER=(
  dir
  context
  git
)
BULLETTRAIN_STATUS_EXIT_SHOW=true
BULLETTRAIN_CONTEXT_DEFAULT_USER=$ANDREA_USERNAME
BULLETTRAIN_DIR_EXTENDED=2
BULLETTRAIN_GIT_BG=green
BULLETTRAIN_GIT_COLORIZE_DIRTY_BG_COLOR=red

# Oh My Zsh plugins
plugins=(
  alias-tips
  rbenv
  ruby
  git
  docker
  macos
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source "$ZSH/oh-my-zsh.sh"

# Added by Antigravity
export PATH="/Users/andreacipriani/.antigravity/antigravity/bin:$PATH"
