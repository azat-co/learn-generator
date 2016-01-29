#!/usr/local/bin/coffee
cp = require 'child_process'
fs = require 'fs-extra'
exec = require 'exec'
path = require 'path'
unitName = process.argv[2]
lessonName = process.argv[3]
repo = process.argv[4]

sourceFolder = __dirname
repoFolder = path.basename(repo, '.git')
targetFolder = path.join process.cwd(), repoFolder

cp.execSync "git clone #{repo}", cwd: process.cwd()
if repo.indexOf('-lab')>-1
  cp.execSync "git checkout -b solution", cwd: targetFolder
  cp.execSync "git push origin solution", cwd: targetFolder
  cp.execSync "git checkout -b wip-solution", cwd: targetFolder
  templateFolder = 'node-lab'
else
  cp.execSync "git checkout -b wip-master", cwd: targetFolder
  templateFolder = 'node-readme'

fs.copySync "#{sourceFolder}/#{templateFolder}", "#{targetFolder}"
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

console.log repo, path.basename(repo, '.git'), sourceFolder, targetFolder
