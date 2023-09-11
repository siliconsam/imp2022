#! /bin/bash
#
# Now, compile a program to utilise the routines in the bilbo.s assembler file
#
imp77 -c -Fc -Fs -Fi baggins.imp
#
# Link the baggins code with the shareable library
#
gcc -m32 -no-pie -o baggins baggins.o -lbilbo -limp77 -lm

