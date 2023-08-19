#!/bin/bash
cd ../pass3
make superclean
make install
cd ../lib
cp $1.imp fubar.imp
# create the Elf object file from fubar.imp
imp77 -c -Fc -Fs -Fi fubar.imp
# Also create the Elf object file (using rela relocation records) from fubar.ibj
pass3elf.exe  fubar.ibj fubar.o
pass3elfa.exe fubar.ibj fubara.o

# create the icd,ibj "assembler" text
icd2assemble fubar.icd fubar.icd.lis
ibj2assemble fubar.ibj fubar.ibj.lis

# Read the ELF files
readelf -aW fubar.o > fubar.o.lis
readelf -aW fubara.o > fubara.o.lis

# Generate the shareable libraries
gcc -m32 -shared -fPIC -Wl,-soname,fubarlib.so -o fubarlib.so fubar.o
gcc -m32 -shared -fPIC -Wl,-soname,fubaralib.so -o fubaralib.so fubara.o

#Read the Elf contants of the shareable libraries
readelf -aW fubarlib.so > fubarlib.so.lis
readelf -aW fubaralib.so > fubaralib.so.lis
