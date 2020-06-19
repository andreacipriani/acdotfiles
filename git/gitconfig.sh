[user]
    name = Andrea Cipriani
	email = andreacipriani89@gmail.com
# Conditionally override the git username and email for 
[includeIf "gitdir:~/code/spotify/"] 
	# I can't make it work with a relative path nor using env variables
    path = ~/code/acdotfiles/git/gitworkconfig.sh
[hub]
        protocol = https
	host = ghe.spotify.net
[color]
        diff = auto
        status = auto
        branch = auto
        ui = true
[core]
	excludesfile = ~/code/acdotfiles/git/global/.gitignore
	editor = $EDITOR -n -w
[apply]
        whitespace = nowarn
[mergetool]
        keepBackup = false
[difftool]
        prompt = false
[help]
        autocorrect = 1
[pull]
	rebase = true
[rebase]
	autoStash = true
[rerere]
	enabled = true
[difftool "opendiff"]
	cmd = opendiff \"$LOCAL\" \"$REMOTE\"
	path = 
[mergetool "opendiff"]
	cmd = opendiff \"$LOCAL\" \"$REMOTE\" -ancestor \"$BASE\" -merge \"$MERGED\"
	trustExitCode = true
[filter "lfs"]
	smudge = git-lfs smudge -- %f
	process = git-lfs filter-process
	required = true
	clean = git-lfs clean -- %f
[difftool "sourcetree"]
	cmd = opendiff \"$LOCAL\" \"$REMOTE\"
	path = 
[mergetool "sourcetree"]
	cmd = /Applications/Sourcetree.app/Contents/Resources/opendiff-w.sh \"$LOCAL\" \"$REMOTE\" -ancestor \"$BASE\" -merge \"$MERGED\"
	trustExitCode = true
[merge]
	tool = opendiff
[diff]
	tool = opendiff
	submodule = log
[status]
	submodulesummary = 1
