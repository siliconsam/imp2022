@setlocal
@echo off
@set COM_HOME=%~dp0
@set DEV_HOME=%COM_HOME:~0,-1%

@rem This script has an ASS-U-ME that the Free Pascal compiler is installed.
@rem If not then refer to http://www.freepascal.org for relevant downloads

@rem Now build the various tools
@rem First the various ibj tools written in IMP or Free Pascal
@cd %DEV_HOME%\ibj
@call buildtools

@rem Next the various tools to manipulate icd files
@cd %DEV_HOME%\icd

@rem Tools which read/write ICD files
@call buildtools

@cd %DEV_HOME%
@endlocal
