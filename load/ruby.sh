# Export gems
export GEM_HOME=~/.gem

# Rbenv
if (( $+commands[rbenv] ))
then
  eval "$(rbenv init -)"
fi
