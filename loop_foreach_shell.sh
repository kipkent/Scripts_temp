#!/bin/bash
## path to input file

file='lists.txt'
exec 4<$file

while read -r -u4 t ; do
    echo "$t"
done
