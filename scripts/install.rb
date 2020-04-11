#!/usr/bin/env ruby

class Repository

    attr_accessor :name, :remote, :destination_folder

    def initialize(name, remote, destination_folder)
        @name = name
        @remote = remote
        @destination_folder = destination_folder
    end

    def clone
        repo_path = "#{destination_folder}/#{name}"
        if File.directory?(repo_path)
            puts "Not cloning #{repo_path} because folder already exists"
            return
        end
        
        cmd = "git clone #{remote} #{repo_path}"
        puts cmd
        system(cmd)
    end 

    def to_s
        "name: #{self.name}, remote: #{self.remote}, destination folder: #{destination_folder}\n"
    end
end

### Personal repos

personal_repos = ["rename-files-creation-date", "anonymizer", "replaceit"]
for repo_name in personal_repos
    repo = Repository.new(repo_name, "git@github.com:andreacipriani/#{repo_name}.git", "/Users/andreacipriani/code/github/andreacipriani")
    repo.clone
end

bitbucket_personal_repost = ["curriculum-andrea-cipriani"]
for repo_name in bitbucket_personal_repost
    repo = Repository.new(repo_name, "git@bitbucket.org:Raiden996/#{repo_name}.git", "/Users/andreacipriani/code/bitbucket/andreacipriani")
    repo.clone
end