#! /bin/bash
#
# Compile the IMPP77 code (but NOT creating an executable, and save the intermediate files)
# Use -m32 to ensure we generate 32-bit code
#
imp77 -c -Fc -Fs -Fi bilbo.imp
