#! /bin/bash
#
# Now, compile a program to utilise the routines in the bilbo.s assembler file
#
#./compile_imp.sh $1
#
# Link the $1.imp code with object code $2.o
#
echo "Linking executable ${1} generated from ${1}.imp and ${2}.o"
##gcc -m32 -no-pie -o $1 ../../lib/imprtl-main.o $1.o $2.o /usr/local/lib/libimp77.a -lm
##gcc -m32 -Xlinker -Map=$1$2.map -no-pie -o $1 /usr/local/lib/libimp77.a $1.o $2.o /usr/local/lib/libimp77.a -lm
#gcc -m32 -Xlinker -Map=$1$2.map -no-pie -o $1 $1.o $2.o /usr/local/lib/libimp77.a -lm
##gcc -m32 -no-pie -o $1 $1.o $2.o /usr/local/lib/libimp77.a -lm
imp77link $1 $2
#
# Dump the contents of $1
#
echo "Dumping executable ${1} generated from ${1}.imp and ${2}.o"
readelf -A -g -t -a -W $1.o > $1.$2.o.readelf.txt
objdump -f -x -d -s -t -r $1 > $1.$2.o.objdump.txt
echo "Running executable ${1} generated from ${1}.imp and ${2}.o"
echo ""
./$1
echo ""


