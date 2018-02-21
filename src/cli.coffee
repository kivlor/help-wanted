fs = require 'fs'

packageFile = './package.json'
packageJSON = {}

# find package.json
try
  stats = fs.statSync packageFile
catch error
  console.log "Error: #{packageFile} not found"
  process.exit 1

try
  fs.accessSync packageFile, fs.F_OK
catch error
  console.log "Error: #{packageFile} not found OR isn't readable"
  process.exit 1

packageJSON = {}

try
  packageJSON = JSON.parse(fs.readFileSync packageFile, 'utf8')
catch error
  console.log "Error: #{packageFile} not found OR isn't readable"
  process.exit 1

# check for dependecies
dependencies = Object.keys packageJSON.dependencies || []
devDependencies = Object.keys packageJSON.devDependencies || []
allDependencies = [ dependencies..., devDependencies... ]

unless allDependencies.length
  console.log "No dependencies..."
  process.exit 0
