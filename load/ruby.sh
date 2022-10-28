# Export gems
export GEM_HOME=~/.gem
export PATH="$HOME/.rbenv/bin:$PATH"

# Rbenv
if (( $+commands[rbenv] ))
then
  eval "$(rbenv init -)"
fi
