# Sets reasonable macOS defaults.
#
# The original idea (and a couple settings) were grabbed from:
#   https://github.com/mathiasbynens/dotfiles/blob/master/.macos
#

# Use AirDrop over every interface. srsly this should be a default.
defaults write com.apple.NetworkBrowser BrowseAllInterfaces 1

# Always open everything in Finder's list view. This is important.
defaults write com.apple.Finder FXPreferredViewStyle Nlsv

# Show the ~/Library folder.
chflags nohidden ~/Library

# Set a really fast key repeat.
defaults write NSGlobalDomain KeyRepeat -int 1

# Set the Finder prefs for showing a few different volumes on the Desktop.
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

#show hidden files
defaults write com.apple.finder AppleShowAllFiles YES

# Enable press-and-hold for special characters
defaults write -g ApplePressAndHoldEnabled -bool true

# Show build time in Xcode
defaults write com.apple.dt.Xcode ShowBuildOperationDuration -bool YES

# Skip Xcode refactoring animation
defaults write com.apple.dt.Xcode CodeFoldingAnimationSpeed -int 0
