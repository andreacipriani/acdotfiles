export DOTFILES=$HOME/code/acdotfiles #dotfiles folder
export ZSH=$DOTFILES/oh-my-zsh #ohmyzsh folder
export CODE=~/code #all code projects folder
export EDITOR='code'

# First load the path file
path_file=$DOTFILES/load/path.sh
source $path_file

# Then load all the files in /load
typeset -U load_files
load_files=($DOTFILES/load/**/*)
for file in $load_files
do
  source $file
done

# Load autocompletions now, otherwise functions won't be loaded
autoload -U compinit
compinit
autocompletion_file=$DOTFILES/autocompletion/autocompletion.sh
source $autocompletion_file
unset load_files

# Better history, credits to https://coderwall.com/p/jpj_6q/zsh-better-history-searching-with-arrow-keys
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search # Up
bindkey "^[[B" down-line-or-beginning-search # Down
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# disable auto correction
ENABLE_CORRECTION="false"

#Colorize different commands
[[ -s "/etc/grc.zsh" ]] && source /etc/grc.zsh

# Theme and prompt https://github.com/caiogondim/bullet-train.zsh
ZSH_THEME="bullet-train"
BULLETTRAIN_PROMPT_ORDER=(
  dir
  context
  git
)
BULLETTRAIN_STATUS_EXIT_SHOW=true
BULLETTRAIN_CONTEXT_DEFAULT_USER="acipriani"
BULLETTRAIN_DIR_EXTENDED=2 #show complete dir path
BULLETTRAIN_GIT_BG=green
BULLETTRAIN_GIT_COLORIZE_DIRTY_BG_COLOR=red

# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
plugins=(
         alias-tips
         rbenv
         ruby
         )

source $ZSH/oh-my-zsh.sh