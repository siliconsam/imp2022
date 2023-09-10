Examples inside WSL folders
/home/siliconsam/projects/tools/imp2022-demo

#
# Compare bilbo.imp and bilbo.c
#

#
# Compile the C code (but NOT creating an executable, and save the intermediate files .i,.s)
# Use -m32 to ensure we generate 32-bit code
#
gcc -m32 -save-temps -c -O bilbo.c

#
# Now tweak the bilbo.s assember source
# 1) remove the .rti compiler directives. They are used for the GNU GCC event handler system
# 2) rename the mangled routines to something simple
# 3) convert the routine entry and exit style to use:
#    enter $0,$1
#    ...
#    leave
#    ret
#
# 4) convert the mechanism to get the static/own integer to use the lea instruction
##   Call the routine to get the value of the pc into %eax
#    call   get_pc
##   Now get the address of the GLOBAL OFFSET Table
#	 addl   $_GLOBAL_OFFSET_TABLE_, %eax
##   Now evaluate the address of the static/own integer value into %eax
#    lea     count@GOTOFF(%eax),%eax
# 5) repeat step 4) for each routine + own variable being accessed
#    Beware if trying to access 2 static/own variables simultaneously
#    Might need more than one register, (use the stack???)
#

#
# We can now compile the .s file (as AS assembler format)
#
gcc -m32 -c -O bilbo.s

#
# create a shareable library from the <libname>.o object file
#
gcc -m32 -shared -z notext -fPIC -Wl,-soname,libbilbo.so -o libbilbo.so bilbo.o

#
# Move the shareable library to make it visible when linking
#
cp libbilbo.so /usr/local/lib

#
# Show the IMP source baggins.imp
#

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

#
# Clear out the old bilbo code derived from bilbo.c
#
rm baggins
rm bilbo.o
rm libbilbo.so
rm /usr/local/lib/libbilbo.so

#
# Now create the IMP version of a shareable library
#
imp77 -c -Fc -Fs -Fi bilbo.imp

#
# create a new shareable library from the <libname>.o object file
#
gcc -m32 -shared -z notext -fPIC -Wl,-soname,libbilbo.so -o libbilbo.so bilbo.o

#
# Move the shareable library to make it visible when linking
#
cp libbilbo.so /usr/local/lib

#
# Link the baggins code with the shareable library
#
gcc -m32 -no-pie -o baggins baggins.o -lbilbo -limp77 -lm

#
# Run the new program
#
./baggins


objdump -f -x -d -s -t -r bilbo.o > bilbo.s.o.objdump.txt
readelf -a -W bilbo.o > bilbo.s.o.readelf.txt


gcc -m32 -shared -fPIC -z notext -o bilbo.o ./bilbo.c
gcc -shared -z notext -fPIC -Wl,-soname,libbilbo.so -o libbilbo.so bilbo.s


x86_64-elf-objcopy -O elf32-x86-64 -I elf64-x86-64 kernel.o kernel.o
x86_64-elf-gcc -T linker.ld -o myos.bin -ffreestanding -O2 -nostdlib boot32.o kernel.o -Xlinker -m -Xlinker elf32_x86_64
x86_64-elf-objcopy -O elf32-i386 -I elf32-x86-64 myos.bin myos.bin


