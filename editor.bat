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

echo. >> temp
type "%filename%"

:edit
cls
set input=""
type "%filename%"
type temp
set /p input=

if !input! == "" (
  echo. >> temp
  goto edit
)
rem Commands

if "!input!" == ":E" (
  echo Exitting.
  goto eof
)
if "!input!" == ":S" (
  echo Writing contents to main file.
  type temp >> "%filename%"
  rem Clears the temp file.
  type nul > temp & echo. >> temp
  goto edit
)

echo !input! >> temp

goto edit

:eof
del temp