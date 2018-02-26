#!/bin/sh

infile=$(echo -n $1 | sed 's:^./::g')
src=$2
dst=$3
outfile=$(echo -n $infile | sed -e "s:$src/:$dst/:" -e 's:.cson$:.json:')
# echo "cson-helper.sh: pwd: $PWD"
# echo "infile: $infile"
# echo "outfile: $outfile"
mkdir -p $(dirname $outfile)
cson2json $infile > $outfile
