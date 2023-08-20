@echo off
@setlocal
@set COM_HOME=%~dp0
@rem now remove the \compiler\ (last 10 characters) from the script directory variable
@set DEV_HOME=%COM_HOME:~0,-10%
@set LIB_HOME=%DEV_HOME%/lib

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
@set EXE_HOME=%DEV_HOME%\compiler\
@shift
@goto parseargs

:driveri32
@rem Use this parameter to create .obj using %IMP_INSTALL_HOME% executables
@set driver=i32
set LIB_HOME=%IMP_INSTALL_HOME%\lib
set EXE_HOME=%IMP_INSTALL_HOME%\bin
@shift
@goto parseargs

:driveri32x
@rem Use this parameter to create .obj using %DEV_HOME% executables
@set driver=i32x
set EXE_HOME=%DEV_HOME%\compiler
@shift
@goto parseargs

:checkit
@if "%driver%"=="oops" @goto oops
@goto clearit

:clearit
@if exist *.assemble @del *.assemble
@if exist *.cod      @del *.cod
@if exist *.debug    del *.debug
@if exist *.dump     @del *.dump
@if exist *.icd      @del *.icd
@if exist *.lst      @del *.lst
@if exist *.map      del *.map
@if exist *.obj      @del *.obj

@rem retain the .exe files if we are using i32x
@if not "%driver%"=="i32x"      %if exist *.exe del *.exe
@rem retain the .ibj files if we are using bootstrap
@if not "%driver%"=="bootstrap" @if exist *.ibj @del *.ibj

@rem ok, we should have a tidy environment
@rem let's start
@goto runit

:runit
@rem compile the takeon lexer/parser table generator using new development library
@call :%driver% takeon
@call :dolinkn takeon

@echo     *******************************************************************************
@echo     *    Form the "development" parse/lex tables from the grammar using takeon    *
@echo     *******************************************************************************
@%EXE_HOME%\takeon i77.grammar=i77.tables.inc,i77.par.debug,i77.lex.debug
@echo.
@echo     *******************************************************************************
@echo     *    Compile pass1+pass2 with the "released" versions of pass1,pass2          *
@echo     *    Build pass1,pass2 with "development" pass3 and link to new library       *
@echo     *******************************************************************************
@call :%driver% pass1
@call :%driver% ibj.utils
@call :%driver% icd.utils
@call :%driver% pass2
@call :dolinkn pass1
@call :dolinkn pass2 icd.utils ibj.utils
@goto the_end

:i32
@set source=%1
@%EXE_HOME%\pass1        %source%.imp,..\lib\stdperm.imp=%source%.icd:b,%source%.lst
@%EXE_HOME%\pass2        %source%.icd:b,%source%.imp=%source%.ibj,%source%.cod
@call :ibj2obj           %source%

@rem %IMP_INSTALL_HOME%\bin\icd2assemble %source%.icd                    %source%.icd.assemble
@rem %IMP_INSTALL_HOME%\bin\ibj2assemble %source%.ibj                    %source%.ibj.assemble
@exit/b

:i32x
@set source=%1
@%EXE_HOME%\pass1           %source%.imp,..\lib\stdperm.imp=%source%.icd:b,%source%.lst
@%EXE_HOME%\pass2           %source%.icd:b,%source%.imp=%source%.ibj,%source%.cod
@call :ibj2obj              %source%

@rem %IMP_INSTALL_HOME%\bin\icd2assemble %source%.icd                    %source%.icd.assemble
@rem %IMP_INSTALL_HOME%\bin\ibj2assemble %source%.ibj                    %source%.ibj.assemble
@exit/b

:bootstrap
:ibj2obj
@%DEV_HOME%\pass3\pass3coff %1.ibj %1.obj
@rem %DEV_HOME%\pass3\pass3elf %1.ibj %1.o
@rem %IMP_INSTALL_HOME%\bin\coff2dump %1.obj %1.dump
@exit/b

:dolinkn
@setlocal
@echo off

@echo.
@call :dolinklist %*

@echo **************************
@echo **** ALL LINKING DONE **** for %1
@echo **************************
@goto :end

:dolinklist
@echo off
setlocal enabledelayedexpansion
@echo ********************************************
@echo **** Linking OBJECT files from %*
@echo ********************************************
@echo.

set objlist=
set argCount=0
for %%x in (%*) do (
    @call :ibj2obj %%x
    set /A argCount+=1
    set "objlist=!objlist! %%~x.obj"
)
@echo Number of object files to link: %argCount%
@echo Object link list              : %objlist%
@echo.

@rem set LIB_HOME=%IMP_INSTALL_HOME%\lib
@rem This link command line avoids adding the C heap library code
@rem To include the heap code add the line "/heap:0x800000,0x800000 ^" after the "/stack:..." line
@link ^
/nologo ^
/SUBSYSTEM:CONSOLE ^
/stack:0x800000,0x800000 ^
/MAPINFO:EXPORTS ^
/MAP:%1.map ^
/OUT:%1.exe ^
/DEFAULTLIB:%LIB_HOME%\libi77.lib ^
%LIB_HOME%\imprtl-main.obj ^
%objlist% ^
%LIB_HOME%\libi77.lib

@echo.
@endlocal
exit/b

:end
@endlocal
@echo on
@exit/b

:oops
@echo "No 'driver' parameter has been specified"
@echo "Options are:"
@echo "    -bootstrap     Build the compiler using the .ibj files and programs in %DEV_HOME%"
@echo "    -i32           Build the compiler using the .imp files and programs in %IMP_INSTALL_HOME%"
@echo "    -i32x          Build the compiler using the .imp files and programs in %DEV_HOME%"
@goto the_end

:the_end
@endlocal
