# Use `hub` as a git wrapper - http://defunkt.github.com/hub/
# hub_path=$(which hub)
# alias git=$hub_path

alias openalias="$EDITOR $DOTFILES/load/aliases.sh"
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
alias gp="git push origin HEAD"
alias grbc="gitc rebase --continue"
alias grm="git fetch && git rebase origin/master"
alias grmi="git fetch && git rebase origin/master -i"
alias gall="git add ."
alias gca='git commit -a'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gb='git branch'
alias gac='git add -A && git commit -m'
alias grbtaketheirs="git checkout --ours . && git add ."
alias grbtakemine="git checkout --theirs . && git add ."
alias gclean= "git gc --aggressive && git prune"
alias gcpc="gitc cherry-pick --continue"
alias gcm="git commit -m"
alias gcan="git commit --amend --no-edit"
alias gdiff="git diff --color-moved"
alias gconflicts="git diff --name-only --diff-filter=U --relative"
alias gopenconflicts="git diff --name-only --diff-filter=U --relative | xargs code"
alias gaddconflicts="git diff --name-only --diff-filter=U --relative | xargs git add"

# Git with forks
alias gsync="git fetch upstream && git checkout master && git merge upstream/master"

# Remove `+` and `-` from start of diff lines; just rely upon color.
alias gfix="git diff --name-only | uniq | xargs git mergetool"

#Xcode aliases
alias watchos="open /Applications/Xcode.app/Contents/Developer/Applications/Simulator\ \(Watch\).app"
alias xcodetemplates='cd ~/Library/Developer/Xcode/Templates/'
alias cleanderivedata='rm -Rf ~/Library/Developer/Xcode/DerivedData'
alias pi='pod install --repo-update'
quitxcodecmd="tell application \"Xcode\" to quit"
alias quitxcode="osascript -e '$quitxcodecmd'"

# Filesystem shorcuts
alias goios="cd /Users/$ANDREA_USERNAME/code/spotify/acipriani/client-ios"
alias gospt="cd /Users/$ANDREA_USERNAME/code/spotify/acipriani/"
alias gotuist="cd /Users/$ANDREA_USERNAME/code/github/andreacipriani/tuist"
alias gogithub="cd /Users/$ANDREA_USERNAME/code/github/andreacipriani"
alias goclient="cd /Users/$ANDREA_USERNAME/code/spotify/acipriani/client"
alias goandroid="cd /Users/$ANDREA_USERNAME/code/spotify/acipriani/client-android"

# Rails - unless you are starting a new project, better to always prepend bundle.
alias rails="bundle exec rails"

# Functions

# Open a Bazel Xcode project:
# $1 = name of project, e.g: "$bazopen Quasar"
bazopen() {
  rm -rf base/$1/$1.xcodeproj
  if [ "$1" = "mesmerize" ]; then  
    project_path=base/Sandbox/Applications/Mesmerize/project.yaml
  else
    project_path=base/$1/project.yaml
  fi
  PROJECT=$project_path make xcode
  xed projects/$1.xcodeproj
}

gcom() {
  if [ `git branch --list main` ];
  then 
    git checkout main
  else
    git checkout master
  fi
}

xcregenonly() {
  echo "Closing Xcode"
  pkill -f '/Applications/Xcode(-beta)?.app/Contents/MacOS/Xcode'
  echo "Generating project"
  rake generate:generate_only
  echo "Opening project"
  rake ws
}

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