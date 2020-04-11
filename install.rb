#!/usr/bin/ruby

# A simple extension to make colorful logs with emojis
class String
    def log(prefix, color_code)
        "#{prefix}\e[#{color_code}m#{self}\e[0m"
    end
    def error
        log("❌ ", 31)
    end

    def info
        log("", 34)
    end  

    def success
        log("✅ ", 32)
    end
end

dootfiles_root = Dir.pwd
oh_my_zsh_root = "#{dootfiles_root}/oh-my-zsh"
oh_my_zsh_themes_root = "#{oh_my_zsh_root}/themes"

# Install:
puts "Running install.rb".info

# Install brew
if `which brew`
    puts "Brew is installed".success
else
    puts "Installing brew".info
    system("mkdir homebrew && curl -L https://github.com/Homebrew/brew/tarball/master | tar xz --strip 1 -C homebrew")
end

# Install ohmyzsh
if File.directory?(ENV['HOME']+'/code/acdotfiles/oh-my-zsh')
    puts "ohmyzsh is installed".success
    system("upgrade_oh_my_zsh")
else
    puts "Installing ohmyzsh".info
    # Change the install directory with the ZSH environment variable
    ENV['ZSH']="#{ENV['HOME']}/code/acdotfiles/oh-my-zsh"
    system("sh -c \"$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)\"")
end

# Make a symbolic link for the .zshrc 

system("ln -sfn #{dootfiles_root}/zshrc #{ENV['HOME']}/.zshrc")
if File.symlink?(ENV['HOME']+'/.zshrc')
    puts ".zshrc is symlinked from #{dootfiles_root}".success
else 
    puts ".zshrc is not symlinked from #{dootfiles_root}".error
end

# Install fonts
if File.directory?(ENV['HOME']+'/powerline-fonts')
    puts "Powerline-fonts are installed".success
else
    puts "Installing powerline fonts".info
    system("git clone git@github.com:powerline/fonts.git ~/powerline-fonts && cd ~/powerline-fonts && ./install.sh")
end

# Install ohmyzsh plugins

# Install bullet-train theme
if File.exist?('./oh-my-zsh/themes/bullet-train.zsh-theme')
    puts "bullet-train is installed".success
else
    puts "Installing bullet-train".info
    system("curl https://raw.githubusercontent.com/caiogondim/bullet-train-oh-my-zsh-theme/master/bullet-train.zsh-theme --output #{oh_my_zsh_themes_root}/bullet-train.zsh-theme")
end


# Set up git config


