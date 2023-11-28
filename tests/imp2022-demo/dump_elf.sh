#! /bin/bash
#
# Dump the contents of $1.o (generated from $1.imp)
#
#readelf -p1 -x2 -x3 -x4 -x5 -x6 -x7 -p9 -p10 -A -g -t -a -W $1.o > $1.imp.readelf.txt
#readelf -p1 -x2 -x3 -x4 -x5 -x6 -x7 -p9 -p10 -A -g -t -a -W bilbo_ed.o > bilbo_ed.imp.readelf.txt
readelf -A -g -t -a -W $1 > $2.readelf.txt
objdump -f -x -d -s -t -r $1 > $2.objdump.txt
