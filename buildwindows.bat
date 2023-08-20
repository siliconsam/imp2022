@setlocal
@set COM_HOME=%~dp0
@rem now remove the \lib\ (last 10 characters) from the script directory variable
@set BUILD_HOME=%COM_HOME%

@rem first build the pass3 programs
@cd %BUILD_HOME%\pass3
@call makep3

@rem build the run-time library
@cd %BUILD_HOME%\lib
@call makelib -bootstrap

@rem build the compiler passes
@cd %BUILD_HOME%\compiler
@call makep1_2 -bootstrap

@rem build the various utilities
@cd %BUILD_HOME%\tools
@call maketools

@mkdir %BUILD_HOME%\release
@mkdir %BUILD_HOME%\release\bin
@mkdir %BUILD_HOME%\release\docs
@mkdir %BUILD_HOME%\release\include
@mkdir %BUILD_HOME%\release\lib

@copy %BUILD_HOME%\pass3\*.exe          %BUILD_HOME%\release\bin
@copy %BUILD_HOME%\compiler\*.exe       %BUILD_HOME%\release\bin
@copy %BUILD_HOME%\tools\ibj\*.exe      %BUILD_HOME%\release\bin
@copy %BUILD_HOME%\tools\icd\*.exe      %BUILD_HOME%\release\bin
@copy %BUILD_HOME%\scripts\*.bat        %BUILD_HOME%\release\bin
@copy %BUILD_HOME%\docs\*               %BUILD_HOME%\release\docs\*
@copy %BUILD_HOME%\lib\stdperm.imp      %BUILD_HOME%\release\include\*
@copy %BUILD_HOME%\lib\libi77.lib       %BUILD_HOME%\release\lib\*
@copy %BUILD_HOME%\lib\imprtl-main.obj  %BUILD_HOME%\release\lib\*


