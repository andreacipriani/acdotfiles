# Path to your oh-my-zsh installation.
export ZSH=$HOME/.dotfiles
export DOTFILES=$HOME/.dotfiles
export CODE=~/code

# First load the path file
path_file=$DOTFILES/load/path.sh
source $path_file

# Then load all the files in /.dotfiles/load
typeset -U load_files
load_files=($DOTFILES/load/**)
for file in ${(M)load_files:#*/path.zsh}
do
  source $file
done

# Load autocompletions now, otherwise functions won't be loaded
autoload -U compinit
compinit
autocompletion_file=$DOTFILES/autocompletion.sh
source autocompletion_file
unset load_files

# Better history, credits to https://coderwall.com/p/jpj_6q/zsh-better-history-searching-with-arrow-keys
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search # Up
bindkey "^[[B" down-line-or-beginning-search # Down
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# Enable auto correction
ENABLE_CORRECTION="true"

# Theme and prompt https://github.com/caiogondim/bullet-train.zsh
ZSH_THEME="bullet-train"

# Use another custom folder than $ZSH/custom
ZSH_CUSTOM=$DOTFILES/custom

# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/

plugins=(git)

source $ZSH/oh-my-zsh.sh