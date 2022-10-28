# @AndreaCipriani dotfiles

## Principles:

- Run `ruby install.rb` to get all your apps and tools installed
	- The installation is idempotent, you can run it multiple times and you should be in the same state
- Everything under `~/dotfiles/load/` gets loaded into your terminal
	- `/load/path.sh` is loaded first
	- zsh automcompletion suggestions are only inside `~/dotfiles/autocompletion`
- All files under `work-encrypted/` will be encrypted
- Run `ruby scripts/backup.rb` to save all changes

## Installation order:

- macOS
- ruby
- Clone the repo and run `ruby install.rb`
- Setup iTerm by restoring preferences, setting the theme (CMD+I, Colors tab, Load Presets, Import) and configuration
- Setup Visual Studio code by syncing with account
- Setup Alfred 

## TODO:

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

### Credits

Initially inspired by @holman dotfiles. I diverged from it because I wanted to keep it simple, understand everything and heavily depend on ohmzsh.
