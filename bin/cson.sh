#!/bin/sh
# Recursively convert cson files to json
# TODO: add --watch option

# parse options
echo -n $1 | grep -e '-w' -e '--watch'
if [ $? -eq 0 ]
then
    watch=:
    shift
else
    watch=false
fi

# remove trailing / (slash)
src=$(echo -n $1 | sed 's:/$::')
dst=$(echo -n $2 | sed 's:/$::')

# echo "pwd: $PWD"
# echo "src: $src"
# echo "dst: $dst"

find $src/ -name '*.cson' -exec $PWD/bin/cson-helper.sh {} $src $dst \;

if $watch
then
    inotify-hookable --watch-directories $src --on-modify-command "find $src/ -name '*.cson' -exec $PWD/bin/cson-helper.sh {} $src $dst \;"
fi
