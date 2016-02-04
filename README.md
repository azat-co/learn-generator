# learn-generator

Lessons generator for Learn.co curriculum

## Install

```
$ git clone URL
$ npm install
$ npm i -g coffee-script
$ npm link
```

## Usage

Use double quotes for unit name and lesson name. All arguments are mandatory.

```
$ learn-generator UNIT_NAME LESSON_NAME LESSON_REPO
```

For example

```
$ learn-generator git@github.com:learn-co-curriculum/node-modules-require.git node-modules-require "Importing, and Exporting Modules in Node" "Node Modules"
```

If repository name has "-lab", the lab template will be used.
