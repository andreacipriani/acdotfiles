#!/usr/bin/ruby
require_relative("scripts/logger.rb")

dotfiles_root = Dir.pwd
oh_my_zsh_root = "#{dotfiles_root}/oh-my-zsh"
oh_my_zsh_themes_root = "#{oh_my_zsh_root}/themes"
oh_my_zsh_custom_plugins_root = "#{oh_my_zsh_root}/custom/plugins"

# Start Install script:
puts "Running install.rb".info

print "Is this a personal or corporate installation? (personal/corporate): "
corporate = gets.chomp.downcase == "corporate"
puts (corporate ? "Corporate installation: casks will be skipped" : "Personal installation: all packages will be installed").info

# Install brew
if system("command -v brew > /dev/null")
    puts "Brew is installed".success
else
    puts "Installing brew".info
    system('/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"')
end

# Install ohmyzsh
if File.directory?(oh_my_zsh_root)
    puts "ohmyzsh is installed".success
    # Update is handled by zsh normally, but we can try to update here if needed
else
    puts "Installing ohmyzsh".info
    ENV['ZSH'] = oh_my_zsh_root
    system("sh -c \"$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)\" \"\" --unattended")
end

# Make a symbolic link for the .zshrc 
system("ln -sfn #{dotfiles_root}/zshrc #{ENV['HOME']}/.zshrc")
if File.symlink?(ENV['HOME']+'/.zshrc')
    puts ".zshrc is symlinked from #{dotfiles_root}".success
else 
    puts ".zshrc is not symlinked from #{dotfiles_root}".error
end

# Install all gems from Gemfile:
if File.exist?("Gemfile")
    puts "Installing gems from Gemfile".info
    File.readlines("Gemfile").each do |line|
        gem_name = line.strip
        next if gem_name.empty?
        system("gem", "install", gem_name, "--no-document", "--user-install")
    end
end

# Install fonts (Optional: maybe use brew for this now?)
if File.directory?(ENV['HOME']+'/powerline-fonts')
    puts "Powerline-fonts are installed".success
else
    puts "Installing powerline fonts".info
    system("git clone https://github.com/powerline/fonts.git ~/powerline-fonts && cd ~/powerline-fonts && ./install.sh")
end

# Install ohmyzsh custom plugins
def install_plugin(root, name, url)
    if File.directory?("#{root}/#{name}")
        puts "#{name} plugin is installed".success
    else 
        puts "Installing #{name} plugin".info
        system("git clone #{url} #{root}/#{name}")
    end
end

install_plugin(oh_my_zsh_custom_plugins_root, "alias-tips", "https://github.com/djui/alias-tips.git")
install_plugin(oh_my_zsh_custom_plugins_root, "zsh-autosuggestions", "https://github.com/zsh-users/zsh-autosuggestions")
install_plugin(oh_my_zsh_custom_plugins_root, "zsh-syntax-highlighting", "https://github.com/zsh-users/zsh-syntax-highlighting.git")

# Install bullet-train theme
if File.exist?("#{oh_my_zsh_themes_root}/bullet-train.zsh-theme")
    puts "bullet-train is installed".success
else
    puts "Installing bullet-train".info
    system("curl https://raw.githubusercontent.com/caiogondim/bullet-train-oh-my-zsh-theme/master/bullet-train.zsh-theme --output #{oh_my_zsh_themes_root}/bullet-train.zsh-theme")
end

# Set up git config
system("ln -sfn #{dotfiles_root}/git/gitconfig #{ENV['HOME']}/.gitconfig")
if File.symlink?(ENV['HOME']+'/.gitconfig')
    puts ".gitconfig is symlinked from #{dotfiles_root}".success
else 
    puts ".gitconfig is not symlinked from #{dotfiles_root}".error
end

# Create code folder
code_dir = "#{ENV['HOME']}/code"
if File.directory?(code_dir)
    puts "code directory exists".success
else
    puts "creating code directory".info
    Dir.mkdir(code_dir)
end

# Install Xcode User Data
xcode_user_data = "#{ENV['HOME']}/Library/Developer/Xcode/UserData/FontAndColorThemes/AndreaCiprianiDark.xccolortheme"
if File.exist?(xcode_user_data)
    puts "Xcode UserData exists".success
else
    puts "Installing Xcode UserData".info
    system("rsync -r backups/Xcode/ #{ENV['HOME']}/Library/Developer/Xcode/")
end

# Install VS Code extensions
if File.exist?('backups/vscode/extensions.txt')
    if system("command -v code > /dev/null 2>&1")
        puts "Installing VS Code extensions".info
        installed_extensions = `code --list-extensions`.split("\n")
        File.readlines('backups/vscode/extensions.txt').each do |line|
            extension = line.strip
            if installed_extensions.include?(extension)
                puts "#{extension} is already installed".success
            else
                puts "Installing #{extension}".info
                system("code --install-extension #{extension}")
            end
        end
    else
        puts "Skipping VS Code extensions: 'code' CLI not found. Install VS Code and run 'Install code command in PATH' from the Command Palette, then re-run this script.".warning
    end
end

# Run brew bundle
if File.exist?("Brewfile")
    puts "Running brew bundle".info
    if corporate
        require 'tempfile'
        Tempfile.create('Brewfile') do |f|
            File.readlines("Brewfile").each { |l| f.write(l) unless l.strip.start_with?("cask") }
            f.flush
            system("brew bundle --file=#{f.path}")
        end
    else
        system("brew bundle")
    end
end
