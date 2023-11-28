#! /bin/bash
#
# create a shareable library from the <libname>.o object file
#
LIBDIR=/usr/local/lib
#
#gcc -m32 -shared -z notext -fPIC -Wl,-soname,libbilbo.so -o libbilbo.so bilbo.o
#gcc -m32 -shared -fno-plt -fPIC -Wl,-soname,lib$2.so -o lib$2.so $1.o
gcc -m32 -shared -fPIC -Wl,-soname,$LIBDIR/lib$2.so -o lib$2.so $1.o
#
# Move the shareable library to make it visible when linking
#
cp lib$2.so ${LIBDIR}/lib$2.so
#
# Dump the contents of bilbo.o (generated from one of bilbo.imp/bilbo.c/bilbo.s)
#
echo " "
echo "Dumping library lib${2}.so generated from ${1}.o"
./dump_elf.sh lib$2.so $2.so
