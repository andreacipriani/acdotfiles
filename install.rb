#!/usr/bin/ruby
require_relative("scripts/logger.rb")

dootfiles_root = Dir.pwd
oh_my_zsh_root = "#{dootfiles_root}/oh-my-zsh"
oh_my_zsh_themes_root = "#{oh_my_zsh_root}/themes"
oh_my_zsh_custom_plugins_root = "#{oh_my_zsh_root}/custom/plugins"

# Start Install script:
puts "Running install.rb".info

# Install brew
if `which brew`
    puts "Brew is installed".success
else
    puts "Installing brew".info
    system("mkdir homebrew && curl -L https://github.com/Homebrew/brew/tarball/master | tar xz --strip 1 -C homebrew")
end

# Install ohmyzsh
if File.directory?(oh_my_zsh_root)
    puts "ohmyzsh is installed".success
    system("upgrade_oh_my_zsh")
else
    puts "Installing ohmyzsh".info
    # Change the install directory with the ZSH environment variable
    # This should create a ohmyzsh folder in the root of my dotfiles, which is gitignored
    ENV['ZSH']=oh_my_zsh_root
    system("sh -c \"$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)\"")
end

# Make a symbolic link for the .zshrc 
system("ln -sfn #{dootfiles_root}/zshrc #{ENV['HOME']}/.zshrc")
if File.symlink?(ENV['HOME']+'/.zshrc')
    puts ".zshrc is symlinked from #{dootfiles_root}".success
else 
    puts ".zshrc is not symlinked from #{dootfiles_root}".error
end

# Install all gems from Gemfile:
puts "Running bundle install to install all gems in Gemile".info
system("bundle install")

# Install fonts
if File.directory?(ENV['HOME']+'/powerline-fonts')
    puts "Powerline-fonts are installed".success
else
    puts "Installing powerline fonts".info
    system("git clone git@github.com:powerline/fonts.git ~/powerline-fonts && cd ~/powerline-fonts && ./install.sh")
end

# Install ohmyzsh custom plugins
if File.directory?(oh_my_zsh_custom_plugins_root+"/alias-tips")
    puts "Alias-tips plugin is installed".success
else 
    puts "Installing alias-tips plugin".info
    system("git clone https://github.com/djui/alias-tips.git #{oh_my_zsh_custom_plugins_root}/alias-tips")
end

# Install bullet-train theme
if File.exist?('./oh-my-zsh/themes/bullet-train.zsh-theme')
    puts "bullet-train is installed".success
else
    puts "Installing bullet-train".info
    system("curl https://raw.githubusercontent.com/caiogondim/bullet-train-oh-my-zsh-theme/master/bullet-train.zsh-theme --output #{oh_my_zsh_themes_root}/bullet-train.zsh-theme")
end

# Set up git config
system("ln -sfn #{dootfiles_root}/git/gitconfig.sh #{ENV['HOME']}/.gitconfig")
if File.symlink?(ENV['HOME']+'/.gitconfig')
    puts ".gitconfig is symlinked from #{dootfiles_root}".success
else 
    puts ".gitconfig is not symlinked from #{dootfiles_root}".error
end

# Create code folder
if File.directory?("/Users/#{ENV['USER']}/code/")
    puts "code directory existed".success
else
    puts "creating code directory".info
    system("mkdir /Users/#{ENV['USER']}/code/")
end

# Install Xcode User Data
if File.exist?(ENV['HOME']+'/Library/Developer/Xcode/UserData/FontAndColorThemes/AndreaCiprianiDark.xccolortheme')
    puts "Xcode UserData folder exists".success
else
    puts "Installing Xcode UserData folder".info
    system("rsync -r backups/Xcode/ /Users/#{ENV['USER']}/Library/Developer/Xcode")
end

system("brew bundle")
