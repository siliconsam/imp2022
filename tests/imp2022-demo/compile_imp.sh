#! /bin/bash
#
# Compile the IMPP77 code (but NOT creating an executable, and save the intermediate files)
# Use -m32 to ensure we generate 32-bit code
#
imp77 -c -Fc -Fs -Fi $1.imp
#
# Prune the generated .ibj file
#
echo ""
echo "Pruning ${1}.ibj generated from ${1}.imp"
echo ""
slimibj $1.ibj $1.ibj.thin
cp $1.ibj.thin $1.ibj
rm $1.ibj.thin
pass3elf $1.ibj $1.o
ibj2assemble $1.ibj $1.ibj.assemble
#
# Dump the contents of $1.o (generated from $1.imp)
#
echo ""
echo "Dumping the contents of ${1}.o generated from ${1}.imp"
./dump_elf.sh $1.o $1.imp
