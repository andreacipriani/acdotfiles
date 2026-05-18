### This file doesn't have to be inside `load/` becuase we want to load after those files

# Matches case insensitive for lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# Pasting with tabs doesn't perform completion
zstyle ':completion:*' insert-tab pending

### Git completion
completion="$(brew --prefix)/share/zsh/site-functions/_git"

if test -f $completion
then
  source $completion
fi

### SPM Autocompletion
# https://github.com/apple/swift-package-manager/blob/master/Documentation/Usage.md#resolving-versions-packageresolved-file
# Assuming _swift in is in the current folder
# fpath=(. \$fpath)