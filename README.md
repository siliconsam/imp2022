"# imp2022"
IMP-77 for WSL (Windows sub-system for Linux), UNIX/Linux

This distribution contains the IMP compiler and the run-time library for
Intel 386 UNIX/Linux machines that use ELF object files.


COMMON PRE-REQUISITES

* Copy of the IMP2022 git repository on your Windows/Linux/WSL machine
* Optionally the FreePascal compiler for i386 Linux/Windows from www.freepascal.org
    Appropriate version for your O/S environment.
    This Pascal compiler is needed to build some of the tool executables
    It is recommended that you install this compiler
    (until these tools are rewritten in IMP)


PRE-REQUISITES FOR LINUX

* A C compiler and libraries. (Build tested against the gcc compiler suite)
* dos2unix
* File + executable access to the /usr/local folder and sub-folders

PRE-REQUISITES FOR WINDOWS (Versions 8 upwards)

* A C compiler + libraries. (Build tested with Visual Studio in command-line mode)


POSSIBLE REQUIRED TWEAKS FOR COMPILER INSTALLATION:

The Makefiles supplied don't try to figure out local installed software or
policies, so you may need to make some changes.  In particular:

1.  The Makefiles assume GCC is your compiler.
2.  The Makefiles, and the shell/make scripts assume that you will install to
    /usr/local/bin, /usr/local/lib and /usr/local/include.
3.  The "install" command is particularly sensitive to the UNIX/Linux variant you
    are running, and the install section of the Makefiles will likely need fixing.
4.  The loader script "ld.i77.script" in "imp2022/compiler" ass-u-mes
    that ld will concatenate this script into the default GCC loader script.
    This ld.i77.script is ESSENTIAL.
    If not then
        * run "ld --verbose"
        * copy the generated ld script into a file "compiler/ld.script"
        * insert the "section" contents of ld.i77.script before the .data
          instructions into the "compiler/ld.script"
        * rename the "compiler/ld.script" to be "compiler/ld.i77.script"
    ***** This potential amendment to ld.i77.script MUST be done BEFORE running
    the "make bootstrap" in the compiler folder.

    Imp-77 event handling depends on the individual event traps being in
    one section "ITRAP" in the order of ITRAP$B sections, then all ITRAP$D sections
    and finally the ITRAP%F section.
    The Windows linker does this automatically
    Versions of the GCC binutils loader ld (upto 2.27) under WSL/Linux seem ok!
    Versions of the GCC binutils loader ld (after 2.27) have problems with relocation records

The Linux version is slightly different to the Windows version.
COFF object file symbols for Windows have a _ as the first character of the symbol name.
Linux/ELF symbols do not have _ as their first character.
The bootstrap files provided are for the Linux/WSL version.


BOOTSTRAPPING

You don't necessarily have an IMP compiler already installed, so the library
and compiler directories contain some ELF object files as well as sources.
When packed the archive, the object files are up-to-date, so "make" should only
need to compile the C portions, and link the object files.
Be aware of the possible tweaks mentioned above.

Let me know if this bootstrapping step doesn't work (via a github notification),
but only after you have tried all of the above installation "tweaks".
Bootstrapping has been tested in:-
 1) a WSL version 2 environment (Debian and Ubuntu 22.04 LTS)
    These environments use a later version of the GNU binutils package
 2) a Centos-7 virtual machine
    This uses an earlier version of the GNU binutils package

Both the Centos + WSL environments needed tweaks to the default ld loader script.
These are already located in the ld.i77.script.
This script should cope with .rel and .rela type of relocation entries.

The pass3elf.c code generates .rel relocation entities.
The pass3elfa.c code generates .rela relocation entities.

Currently the combination of pass3elf and ld.i77.script will generate working executables,
For this combination the ld loader generates 2 warnings:
1) relocation in read-only section '.text' 
2) creating DT_TEXTREL in a PIE

Currently the combination of pass3elfa and ld.i77.script does NOT generate working executables.
This "bug" is being investigated.

N.B. The "make bootstrap" command uses dos2unix to change the line-endings of various
text files to have the UNIX/Linux CR line ending rather than Windows CR-LF line ending.
The other make commands ass-u-me that text files have the CR line ending.

The order of bootstrapping is...
    **** Extract the default loader script
        ld --verbose > ld.script
    **** Compare ld.i77.script v ld.script
        If ld.script only uses .rela relocation then use ld.i77.script

    * build the pass3 program (used to generate the Elf .o files from .ibj files)
        Pass3 program is generated from the pass3elf.c source (generates .rel relocations)
    cd imp2022/pass3
    make install

    * build the library
	cd imp2022/lib
	make bootstrap

    * build the pass1, pass2 programs
	cd ../compiler
    make bootstrap

This should have installed the IMP compiler and libraries
Next do a general tidy-up of the temporary files
    cd ../pass3
    make superclean
    cd ../lib
    make superclean
    cd ../compiler
    make superclean

I strongly suggest you then make copies of:-
    * the installed compiler (ass-u-med in /usr/local/bin)
    * installed library (/usr/local/bin)
    * installed include files. (usr/local/include)
    * the ../compiler folder
    * the ../lib folder

Now, you can start to "enhance" the IMP compiler by modifying the source files
in the compiler and lib folders.

Then to re-build the libraries and compiler
    cd ../lib
    make
	cd ../compiler
	make

To verify the re-built (but un-installed) compilers and libraries,
use the various imp examples in imp2022/tests
Specify the -e option (== testmode) to the imp77 script when compiling a single
IMP-77 file, so that the un-installed compiler and libraries are used.

For multi-file IMP-77 programs you can use the imp77link script, however this script
only uses the installed compiler and libraries.
As an exercise, create a new script "imp77elink" which uses the un-installed/testmode
compiler and libraries 
 
If there are no errors and you feel confident with your new "enhancements"
Then to install the new version of compiler and libraries
    cd ../lib
	make install
	cd ../compiler
	make install

Remember, always keep backups of the previous versions of source files and the
installed files.
If not, the GitHub repository should contain a set of files that can be used to
bootstrap the IMP compiler.

RUNNING THE IMP COMPILER
The compiler is invoked by the imp77 shell script.
The various options are:
-c  This just generates the ELF object file (no linking to an executable)
-Fc Generates a .cod file which lists the code generated by the compiler
-Fs Generates a .lst file which indicates any syntax errors found
-Fi retains the .ibj, .icd, .o files generated by the compiler
The .imp extension of the source file must be given

The options can be combined.
e.g. imp77 -c -Fc -Fs -Fi pass2.imp
This retains all the intermediate files and generates the pass2 executable.

There is an additional script imp77link which can take an IMP program split
into several Imp source files and individually generate the ELF object files
before linking the ELF .o files into an executable.
Examples of the use of imp77link are in various Makefile files
1) in the compiler folder to build pass2
2) in the tools/ibj folder to build slimibj

UTILITIES
The imp2022/tools folder contains various utilities (in IMP and Free Pascal)
These help to analyse the intermediate files generated by the compiler.
Main intermediate files are the .icd files generated by the pass1 executable
and the .ibj files generated by the pass2 executable.
These are:
    1) icd2assemble reads a .icd file and converts it into a textual form
    2) assemble2icd take the textual form and regenerates the .icd file
    3) icd2dump reads the binary .icd file and converts to ASCII text
    3) ibj2assemble reads a .ibj file and converts it into a textual form
    4) assemble2ibj reads the textual form and regenerates the .ibj file
    5) slimibj reads a .ibj file and optionally:
        a) removes extra LINE records from the .ibj file
        b) removes unused REFEXT records from the .ibj file
        c) compacts adjacent OBJ records in the .ibj file
    6) coff2dump reads a Windows .obj COFF format file
    7) ibj2coff reads a .ibj file and generates a COFF .obj file
        This is equivalent to the pass3coff executable

To build these utilities:
    1) Install the FreePascal compiler
    2) cd tools/icd
    3) make install
    4) cd ../ibj
    5) make install

BUILDING WINDOWS VERSION

Obtain the pre-requisite software for Windows

1) Copy/Git pull the git repository folder tree to a Windows folder
2) Ensure the Visual Studio 32-bit command shell can access the FreePascal compiler
2) Run the buildwindows.bat script inside a command shell with access to the Visual Studio
   32-bit command line C compiler and linker.
3) This generates a release folder tree with a Windows version of the IMP compiler
4) Modify the setenv.bat script to point to the correct version of the Free Pascal compiler
5) When using the Visual Studio 32-bit command shell ensure you ALWAYS call setenv.bat
    This will give access to the IMP compiler and associated utilities.

Good luck and enjoy!

Original implementation by:
Andy Davis
andy@nb-info.co.uk

Refreshed and enhanced by:
John McMullin
jdmcmullin@aol.com

