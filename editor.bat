@echo off
setlocal EnableDelayedExpansion
:start
cls
echo Enter the name of the file to edit:

set /p filename=

if not exist "%filename%" (
  echo File does not exist. Creating one now.
  type nul >> %filename%
)

type "%filename%"

:edit
cls
set input=""
type "%filename%"
set /p input=*newline: 

if !input! == "" (
  echo. >> "%filename%"
  goto edit
)
echo !input! >> "%filename%"

goto edit