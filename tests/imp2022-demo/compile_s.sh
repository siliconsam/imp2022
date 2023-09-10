#! /bin/bash
#
# Now compiler the assembler code in the .s file (AS assembler format)
# Ensure we compile as 32-bit code
#
gcc -m32 -c -O bilbo.s
