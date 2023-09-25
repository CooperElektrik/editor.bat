@echo off
setlocal EnableDelayedExpansion
:start
cls
echo Enter the name of the file to edit:

set /p filename=

if not exist "%filename%" (
  echo File does not exist. Creating one now.
  pause
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
if "%input:~0,1%" == ":" (
  goto %input%
) else (
  goto output
)

:exit
:q
echo Exitting.
goto eof

:save
:s
echo Writing contents to main file.
type temp >> "%filename%"
goto clear

:clear
echo Clearing temp file.
type nul > temp & echo. >> temp
pause
goto edit

:cmd
echo Executing a potentially dangerous command...
set "command=!input:~5!"
call "command.bat"
pause
goto edit

rem Record macro
:marec
set /p marec-name="Macro(s) name: "
for %%V in (!marec-name!) do (
  set /p marec-cont="%%V content: "
  set %%V=!marec-cont!
  echo %%V=!%%V!>> macro
  echo|set /p="%%V " >> macro-index
)
goto edit

rem WIP: Outputting macros
:macro
set "macro-input=!input:~7!"
call macro.bat
for /f "usebackq tokens=*" %%A in ("macro-temp") do (
    if !lineNum! equ 1 (
        set "macro-content=%%A"
    )
)
type macro-temp >> temp
del macro-temp
goto edit

:output
echo !input! >> temp

goto edit

:eof
del temp