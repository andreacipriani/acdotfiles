# Add each topic folder to fpath so that they can add functions and completion scripts
for topic_folder ($DOTFILES/*) if [ -d $topic_folder ]; then fpath=($topic_folder $fpath); fi;

# Basic Paths
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"

# Homebrew
if [[ -f /opt/homebrew/bin/brew ]]; then
  eval $(/opt/homebrew/bin/brew shellenv)
fi

# Android SDK
export PATH="$PATH:$HOME/Library/Android/sdk/platform-tools/"

# Python
export PATH="$HOME/Library/Python/3.9/bin:$PATH"

# Rust / Cargo
export PATH="$PATH:$HOME/.cargo/bin"

# Mise
MISE_PATH="$HOME/.local/bin/mise"
if [[ -f "$MISE_PATH" ]]; then
  eval "$($MISE_PATH activate zsh)"
fi

# Google Cloud SDK
if [[ -d "$(brew --prefix)/share/google-cloud-sdk" ]]; then
  source "$(brew --prefix)/share/google-cloud-sdk/path.zsh.inc"
  source "$(brew --prefix)/share/google-cloud-sdk/completion.zsh.inc"
fi

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
