fs = require 'fs'
{ spawn, exec, execSync } = require 'child_process'

src = 'src/'
dst = 'clickandscroll/'

task 'build', ->
    spawn "coffee", [ "--output", dst, "--compile", src ], { stdio: 'inherit' }
    spawn "bin/cson.sh", [ src, dst ], { stdio: 'inherit' }

task 'watch', ->
    spawn "coffee", [ "--output", dst, "--watch", "--compile", src ], { stdio: 'inherit' }
    spawn "bin/cson.sh", [ "--watch", src, dst ], { stdio: 'inherit' }
