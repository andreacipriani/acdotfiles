# Use `hub` as a git wrapper - http://defunkt.github.com/hub/
hub_path=$(which hub)
if (( $+commands[hub] ))
then
  alias git=$hub_path
fi

alias aliases="$EDITOR $DOTFILES/load/aliases.sh"
alias c="cd $CODE"
alias dotfiles="cd $DOTFILES"
alias reload!="exec zsh"

# Quick jumping back into directories
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."

# Fancy colouredls
alias la="ls -lA --sd"

#Copy your public key
alias pubkey="more ~/.ssh/id_rsa.pub | pbcopy | echo '=> Public key copied to pasteboard.'"

# Git aliases
alias ga="git add -p"
alias gpm="git push origin master"
alias gpr='git pull --rebase'
alias gst="git status -sb"
alias glog="git log --oneline --decorate"
alias gp='git push origin HEAD'
alias gpo="git push --set-upstream origin $(git branch | awk '/^\* / { print $2 }')"
alias grbc="gitc rebase --continue"
alias grm="git fetch && git rebase origin/master"
alias grmi="git fetch && git rebase origin/master -i"
alias gall="git add ."
alias gca='git commit -a'
alias gco='git checkout'
alias gcom='git checkout master'
alias gcb='git checkout -b'
alias gb='git branch'
alias gac='git add -A && git commit -m'
alias grbtaketheirs="git checkout --ours . && git add ."
alias grbtakemine="git checkout --theirs . && git add ."
alias gclean= "git gc --aggressive && git prune"
alias gcpc="gitc cherry-pick --continue"
alias gcm="git commit -m"
alias gcan="git commit --amend --no-edit"

# Remove `+` and `-` from start of diff lines; just rely upon color.
alias gd='git diff --color | sed "s/^\([^-+ ]*\)[-+ ]/\\1/" | less -r'
alias gfix="git diff --name-only | uniq | xargs git mergetool"

#Xcode aliases
alias watchos="open /Applications/Xcode.app/Contents/Developer/Applications/Simulator\ \(Watch\).app"
alias xcodetemplates='cd ~/Library/Developer/Xcode/Templates/'
alias cleanderivedata='rm -Rf ~/Library/Developer/Xcode/DerivedData'
alias pi='pod install --repo-update'

# Open in Xcode, credits to @orta
xcode(){ 
  if test -n "$(find . -maxdepth 1 -name '*.xcworkspace' -print -quit)"
  then
    echo "Opening workspace"
    open *.xcworkspace
    return
  else
    if test -n "$(find . -maxdepth 1 -name '*.xcodeproj' -print -quit)"
    then
      echo "Opening project"
      open *.xcodeproj
      return  
    else
      echo "Nothing found"
    fi
  fi
}