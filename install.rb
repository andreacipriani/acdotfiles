#!/usr/bin/ruby

# Colorize messages
class String
    def colorize(color_code)
        "\e[#{color_code}m#{self}\e[0m"
    end
    def error
        colorize(31)
    end

    def info
        colorize(34)
    end  

    def success
        colorize(32)
    end
end

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
if File.file?(ENV['HOME']+'/.zshrc') || File.symlink?(ENV['HOME']+'/.zshrc')
    puts "ohmyzsh is installed".success
else
    puts "Installing ohmyzsh".info
    system("sh -c \"$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)\"")
end

# Make a symbolic link for the .zshrc 
dootfiles_root = Dir.pwd

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

# Install bullet-train theme

