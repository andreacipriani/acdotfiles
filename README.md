# @AndreaCipriani dotfiles

## Principles:

- Everything under `~/dotfiles/load/` gets loaded into your terminal
	- `/load/path.sh` is loaded first
	- zsh automcompletion suggestions are only inside `~/dotfiles/autocompletion`
	- Everything inside `~/dotfiles/load/private` gets encrypted before being pushed to the repo, you can add here work related stuff
- Run `install.rb` to get everything set up, or when you change machine.
 - The installation is idempotent, you can run it multiple times and you should be in the same state
- Run `backup.rb` to save all changes

## Assumptions:

- mac os
- zsh
- ohmyzsh
- iTerm 2
- There is a `~/code` folder with all your Projects

## TODO:

- encrypt/decrypt private aliases
- Install brew packages/gems/apps automatically
- Backup
  - Visual studio code
    - extensions (~/.vscode/extensions)
    - settings: synced using Settings sync extension -> https://gist.github.com/andreacipriani/1ba00e8f9773857f46eae2845f8e9ac8
  - Xcode UserData folder
  - iTerm
    - preferences
    - theme is in iterm/one-dark996.itermcolors
	- config: On Profiles press Other Actions and Import JSON Profiles, select iterm/iterm_config.json
  - Alfred preferences
  - Brew packages backup
  - Gems
  - Apps from Appstore backup

### Credits

Inspired by @holman dotfiles. I diverged from it because I wanted to keep it simple, use heavily ohmzsh and have more control.
