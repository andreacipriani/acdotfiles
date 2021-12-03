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

if File.exist?('Brewfile')
    # system("brew bundle dump")
else
    puts "Brewfile not found".error
end
