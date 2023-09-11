#! /bin/bash
#
# create a shareable library from the <libname>.o object file
#
gcc -m32 -shared -z notext -fPIC -Wl,-soname,libbilbo.so -o libbilbo.so bilbo.o
#
# Move the shareable library to make it visible when linking
#
cp libbilbo.so /usr/local/lib
