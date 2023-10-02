@echo off
setlocal EnableDelayedExpansion
echo Currently in modify mode, some commands are disabled. To exit and write everything to the main file, use :merge.

pause

set inputFile=modify-temp
type !filename! temp >> modify-temp

for /f "tokens=* delims=" %%a in ('type "!inputFile!"') do (
    set /a "lineNumber+=1"
    echo !lineNumber!. %%a
)
set /p "splitLine=Enter the line number where you want to split: "

set "lineNumber=0"

for /f "tokens=* delims=" %%a in ('type "!inputFile!"') do (
    set /a "lineNumber+=1"
    if !lineNumber! lss !splitLine! (
        if %%a == "" (
            echo.>> modify-temp1
        ) else (
            echo %%a >> modify-temp1
        )
    ) else (
        if %%a == "" (
            echo.>> modify-temp2
        ) else (
            echo %%a >> modify-temp2
        )
    )
)
:mod
set input=""
echo --- Modifying region ---
type modify-temp1
set /p input=

if "!input:~0,1!" == ":" (
  goto !input!
) else (
  goto mod-out
)
:merge
type nul > !filename! & type modify-temp1 modify-temp2 >> !filename!
goto mod-exit

:mod-out
echo !input! >> modify-temp1
goto mod
call modify-fix.bat

:mod-exit
del modify-temp1
del modify-temp2
del modify-temp