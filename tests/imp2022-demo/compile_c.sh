#! /bin/bash
#
# Compile the C code (but DON'T create an executable, and save the intermediate files .i,.s)
# Use -m32 to ensure we generate 32-bit code
#
gcc -m32 -save-temps -c -O $1.c
#
# Dump the contents of $1.o generated from $1.c
#
echo ""
echo "Dump the contents of $1.o generated from $1.c"
echo ""
./dump_elf.sh $1.o $1.c
