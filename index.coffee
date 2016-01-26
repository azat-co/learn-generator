exec = require 'exec'
path = require 'path'
repo = process.argv[2]

console.log repo, path.basename(repo, '.git')

# exec "git clone #{repo}"
# exec "cd"
# if repo.indexOf('-lab')>-1
