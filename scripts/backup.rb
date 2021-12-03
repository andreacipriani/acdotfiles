#!/usr/bin/ruby
require_relative("logger.rb")

puts "Backing up gems".info

gems = `gem list --no-versions`
if File.exist?('Gemfile')
    File.open('Gemfile', 'w') { |gemfile| gemfile.write(gems) }
    puts "Gemfile updated with #{gems.split.size} gems".success
else
    puts "Gemfile not found in #{Dir.pwd}".error
end

puts "Backing up brew/casks/mas".info

if File.exist?('Brewfile')
    system("brew bundle dump --file=NewBrewfile --force")
    brews_size = 0
    cask_size = 0
    mas_size = 0
    File.readlines('NewBrewfile').each do |line|
        if line.include?("brew") 
            brews_size += 1
        elsif line.include?("cask")
            cask_size += 1
        elsif line.include?("mas")
            mas_size += 1
        end
    end
    puts "NewBrewfile created with #{brews_size} brews, #{cask_size} casks and #{mas_size} mas".info
    puts "Please manually review changes in Newbrewfile and update Brewfile".warning
else
    puts "Brewfile not found".error
    system("brew bundle dump")
end

puts "Backing up Xcode UserData folder".info

system("rsync -r /Users/#{ENV['USER']}/Library/Developer/Xcode/ backups/Xcode")

puts "Make sure to manually sync Visual Studio Code configurations, this can't be automated".warning
puts "Make sure to manually sync Alfred preferences, this can't be automated".warning
puts "Make sure to manually sync iTerm preferences, this can't be automated".warning
