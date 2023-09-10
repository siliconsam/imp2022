#! /bin/bash
#
# Compile the C code (but NOT creating an executable, and save the intermediate files .i,.s)
# Use -m32 to ensure we generate 32-bit code
#
gcc -m32 -save-temps -c -O bilbo.c
