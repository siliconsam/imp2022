#! /bin/bash
#
# Now, compile a program to utilise the routines in the bilbo.s assembler file
#
#./compile_imp.sh $1
#
# Link the $1 code with the shareable library $2
#
echo "Linking executable ${1} generated from ${1}.imp and library ${2}"
#gcc -m32 -no-pie -o $1 $1.o /usr/local/lib/libimp77.a -l$2 -lm
imp77link $1 $2
#
# Dump the contents of $1
#
echo "Dumping executable ${1} generated from ${1}.imp and library ${2}"
./dump_elf.sh $1 $1.$2.so
echo "Running executable ${1} generated from ${1}.imp and library ${2}"
echo ""
./$1
echo ""
#
# Now to remove the library $2 from /usr/local/lib
#
rm /usr/local/lib/lib$2.so
