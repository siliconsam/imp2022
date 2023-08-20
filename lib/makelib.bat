@setlocal
@set COM_HOME=%~dp0
@rem now remove the \lib\ (last 10 characters) from the script directory variable
@set DEV_HOME=%COM_HOME:~0,-5%

@rem set initial values for the script parameters
@set driver=oops
@set option=-DMSVC

:parseargs
@if "%1"=="gcc" @goto clearoption
@if "%1"=="-bootstrap" @goto driverbootstrap
@if "%1"=="-i32" @goto driveri32
@if "%1"=="-i32x" @goto driveri32x
@rem if "%1"=="" @goto setoption
@rem if here parameter assumed to be the build folder
@goto checkit

:clearoption
@rem Use this parameter to indicate we are using the Microsoft C compiler, linker and libraries
@set option=
@shift
@goto parseargs

:setoption
@rem Use this parameter to indicate we are using the Microsoft C compiler, linker and libraries
@set option=-DMSVC
@shift
@goto parseargs

:driverbootstrap
@rem Use this parameter to create .obj from .ibj
@set driver=bootstrap
@rem We need to grap the various Windows specific files
@copy .\windows\*.inc *
@copy .\windows\*.imp *
@copy .\windows\*.ibj *
@shift
@goto parseargs

:driveri32
@rem Use this parameter to create .obj using %IMP_INSTALL_HOME% executables
@set driver=i32
@shift
@goto parseargs

:driveri32x
@rem Use this parameter to create .obj using %DEV_HOME% executables
@set driver=i32x
@shift
@goto parseargs

:checkit
@if "%driver%"=="oops" @goto oops
@goto clearit

:clearit
@if exist *.assemble @del *.assemble
@if exist *.cod      @del *.cod
@if exist *.dump     @del *.dump
@if exist *.icd      @del *.icd
@if exist *.lst      @del *.lst
@if exist *.obj      @del *.obj

@rem retain the .ibj files if we are using bootstrap
@if "%driver%"=="bootstrap" @goto runit
@if exist *.ibj      @del *.ibj

@rem ok, we should have a tidy environment
@rem let's start
@goto runit

:runit
@rem Compile the C implemented primitives code
@rem The possible parameter 
@cl /nologo /Gd /c /Gs /W3 /Od /arch:IA32 -D_CRT_SECURE_NO_WARNINGS %option% /FAscu /Foprim-rtl-file.obj /Faprim-rtl-file.lst prim-rtl-file.c

@rem Compile the IMP77 implemented library code
@call :%driver% impcore-arrayutils
@call :%driver% impcore-mathutils
@call :%driver% impcore-signal
@call :%driver% impcore-strutils
@call :%driver% impcore-types

@call :%driver% implib-arg
@call :%driver% implib-debug
@call :%driver% implib-env
@call :%driver% implib-heap
@call :%driver% implib-read
@call :%driver% implib-strings
@call :%driver% implib-trig

@call :%driver% imprtl-main
@call :%driver% imprtl-event
@call :%driver% imprtl-file
@call :%driver% imprtl-io
@call :%driver% imprtl-trap
@call :%driver% imprtl-check

@rem Ensure we have a clean library
@if exist libimp.lib del libimp.lib

@rem Store the C source primitives object code into the library
@lib /nologo /out:libimp.lib prim-rtl-file.obj
@rem do NOT add the runimp.obj file to the library as all symbol references start with this code
@rem do NOT add the runarg.obj file to the library as all symbol references start with this code

@rem Store the Imp source generated object code into the library
@lib /nologo /out:libimp.lib libimp.lib imprtl-main.obj
@lib /nologo /out:libimp.lib libimp.lib imprtl-event.obj
@lib /nologo /out:libimp.lib libimp.lib imprtl-io.obj
@lib /nologo /out:libimp.lib libimp.lib imprtl-file.obj
@lib /nologo /out:libimp.lib libimp.lib imprtl-trap.obj
@lib /nologo /out:libimp.lib libimp.lib imprtl-check.obj

@lib /nologo /out:libimp.lib libimp.lib impcore-arrayutils.obj
@lib /nologo /out:libimp.lib libimp.lib impcore-mathutils.obj
@lib /nologo /out:libimp.lib libimp.lib impcore-signal.obj
@lib /nologo /out:libimp.lib libimp.lib impcore-strutils.obj
@lib /nologo /out:libimp.lib libimp.lib impcore-types.obj

@lib /nologo /out:libimp.lib libimp.lib implib-arg.obj
@lib /nologo /out:libimp.lib libimp.lib implib-debug.obj
@lib /nologo /out:libimp.lib libimp.lib implib-env.obj
@lib /nologo /out:libimp.lib libimp.lib implib-heap.obj
@lib /nologo /out:libimp.lib libimp.lib implib-read.obj
@lib /nologo /out:libimp.lib libimp.lib implib-strings.obj
@lib /nologo /out:libimp.lib libimp.lib implib-trig.obj

@rem Create the library which allows command line to specify the file I/O
@if exist libi77.lib del libi77.lib
@copy libimp.lib libi77.lib

@rem we no longer need the base object archive
@del libimp.lib
@goto the_end

:bootstrap
@setlocal
@set source=%1
@%DEV_HOME%/pass3/pass3coff          %source%.ibj                %source%.obj
@rem %IMP_INSTALL_HOME%/bin/ibj2assemble %source%.ibj                %source%.ibj.assemble
@rem %IMP_INSTALL_HOME%/bin/coff2dump    %source%.obj                %source%.dump
@endlocal
exit/b

:i32
@setlocal
@set source=%1
@%IMP_INSTALL_HOME%/bin/pass1        %source%.imp,stdperm.imp=%source%.icd:b,%source%.lst
@%IMP_INSTALL_HOME%/bin/pass2        %source%.icd:b,%source%.imp=%source%.ibj,%source%.cod
@%IMP_INSTALL_HOME%/bin/pass3coff    %source%.ibj                %source%.obj

@rem %IMP_INSTALL_HOME%/bin/icd2assemble %source%.icd                %source%.icd.assemble
@rem %IMP_INSTALL_HOME%/bin/ibj2assemble %source%.ibj                %source%.ibj.assemble
@rem %IMP_INSTALL_HOME%/bin/coff2dump    %source%.obj                %source%.dump
@endlocal
exit/b

:i32x
@setlocal
@set source=%1
@%DEV_HOME%/compiler/pass1           %source%.imp,stdperm.imp=%source%.icd:b,%source%.lst
@%DEV_HOME%/compiler/pass2           %source%.icd:b,%source%.imp=%source%.ibj,%source%.cod
@%DEV_HOME%/pass3/pass3coff          %source%.ibj                %source%.obj

@rem %IMP_INSTALL_HOME%/bin/icd2assemble %source%.icd                %source%.icd.assemble
@rem %IMP_INSTALL_HOME%/bin/ibj2assemble %source%.ibj                %source%.ibj.assemble
@rem %IMP_INSTALL_HOME%/bin/coff2dump    %source%.obj                %source%.dump
@endlocal
exit/b

:oops
@echo "No 'driver' parameter has been specified"
@echo "Options are:"
@echo "    -bootstrap     Build the library using the .ibj files and programs in %DEV_HOME%"
@echo "    -i32           Build the library using the .imp files and programs in %IMP_INSTALL_HOME%"
@echo "    -i32x          Build the library using the .imp files and programs in %DEV_HOME%"
@goto the_end

:the_end
@endlocal
