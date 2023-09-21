for %%i in (!command!) do (
   set first=%%i
   goto next
)
:next
rem This checks and blocks certain commands from being executed.
if "!first!" == "exit" (
   echo You're trying to exit the terminal. Use :save and :exit instead of :cmd to close the terminal gracefully.
   goto eof-cmd
)
!command!

:eof-cmd
