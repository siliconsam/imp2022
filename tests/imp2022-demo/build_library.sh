#! /bin/bash
#
# create a shareable library from the <libname>.o object file
#
gcc -m32 -shared -z notext -fPIC -Wl,-soname,libbilbo.so -o libbilbo.so bilbo.o
#
# Move the shareable library to make it visible when linking
#
cp libbilbo.so /usr/local/lib
#
# Now, compile a program to utilise the routines in the bilbo.s assembler file
#
imp77 -c -Fc -Fs -Fi baggins.imp
#
# Link the baggins code with the shareable library
#
gcc -m32 -no-pie -o baggins baggins.o -lbilbo -limp77 -lm
#
# Run the new program
#
./baggins
