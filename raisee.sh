#!/bin/sh

files=$(grep "raise " lib/* -R | awk -F\: '{print $1}')
for f in $files; do
    echo $f
    sed -i 's/raise /raisee /g' $f
done

# after runing this script,
# and need some mannual code adjust
