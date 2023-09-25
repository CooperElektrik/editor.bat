for /f "usebackq tokens=*" %%A in ("macro-index") do (
    if !lineNum! equ 1 (
        set macro-list=%%A
    )
)
rem Read the "macro" file line by line
for /f "usebackq tokens=1* delims==" %%A in ("macro") do (
    rem Check if the current line matches the desired string
    if "%%A"=="!macro-input!" (
        rem If it matches, set the "macro-out" variable and echo it
        set "macro-out=%%B"
        echo !macro-out! >> macro-temp
    )
)
