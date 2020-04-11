# @AndreaCipriani dotfiles

## Principles:
- Everything under `~/dotfiles/load/` gets loaded into your terminal
	- `/load/path.sh` is loaded first
	- zsh automcompletion suggestions are only inside `~/dotfiles/load/autocompletion.sh`
	- Everything inside `~/dotfiles/load/private` gets encrypted and won't be shown on the public repo
- Run `install.rb` to get everything set up, or when you change machine.
 - The installation is idempotent, you can run it multiple times and you should be in the same state
- Run `backup.rb` to save all changes

## Assumptions:


- mac os
- zsh
- ohmyzsh
- iTerm 2
- There is a `~/code` folder with all your Projects

### Install.rb

Step 0:

- install brew
- install zsh
- install ohmyzsh

### Credits

Inspired by @holman dotfiles. I diverged from it because I wanted to keep it simple, use heavily ohmzsh and have more control.
