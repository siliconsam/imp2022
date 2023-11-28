#! /bin/bash
#
# Now compiler the assembler code in the .s file (AS assembler format)
# Ensure we compile as 32-bit code
#
#gcc -m32 -c -O $1.s
gcc -m32 -c -o $1.o $1.s
#
# Dump the contents of $1.o (generated from $1.s)
#
echo ""
echo "Dumping object ${1}.o generated from ${1}.s"
./dump_elf.sh $1.o $1.s
readelf -x1 -x2 -R3 -x4 -x5 -x6 -x7 -p8 -p9 -A -g -t -a -W $1.o > $1.s.readelf.txt
