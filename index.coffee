cp = require 'child_process'
fs = require 'fs-extra'
exec = require 'exec'
path = require 'path'
repo = process.argv[2]
lessonName = process.argv[3]
unitName = process.argv[4] or 'Node Modules'

pwd = cp.execSync 'pwd', encoding: 'utf8'
pwd = pwd.replace /\n/g, '' # use __dirname?

repoFolder = path.basename(repo, '.git')
targetFolder = path.join pwd, '..', repoFolder

# exec "git clone #{repo}"
if repo.indexOf('-lab')>-1
#   exec "git checkout -b solution"
#   exec "git push origin solution"
#   exec "git checkout -b wip-solution"
  templateFolder = 'node-lab'
else
#   exec "git checkout -b wip-master"
  templateFolder = 'node-readme'

fs.copySync "#{pwd}/#{templateFolder}", "#{targetFolder}"
dotLearn = fs.readFileSync "#{targetFolder}/.learn", encoding: 'utf8'
dotLearn = dotLearn.replace /lesson-name/g, lessonName
dotLearn = dotLearn.replace /unit-name/g, unitName
fs.writeFileSync "#{targetFolder}/.learn", dotLearn

readme = fs.readFileSync "#{targetFolder}/README.md", encoding: 'utf8'
readme = readme.replace /lesson-name/g, lessonName
readme = readme.replace /repo-folder/g, repoFolder
fs.writeFileSync "#{targetFolder}/README.md", readme

if repo.indexOf('-lab') > -1
  packageJson = fs.readJsonSync "#{targetFolder}/package.json"
  packageJson.name = repoFolder
  packageJson.description = lessonName
  packageJson.repository.url = repo
  packageJson.bugs.url = "#{repo}/issues"
  packageJson.homepage = "#{repo}/#readme"
  fs.writeJsonSync "#{targetFolder}/package.json", packageJson

# lesson-name, repo-folder, unit-name

# $ git clone git@github.com:learn-co-curriculum/node-debugger-lab.git
# $ gco -b solution
# $ ggpush
# $ gco -b wip-solution
# // copy files
# // edit learn with the new name
# // edit package.json with new repo url
# // edit readme with name

console.log repo, path.basename(repo, '.git'), pwd, process.cwd()
