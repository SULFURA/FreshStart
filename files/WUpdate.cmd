@echo off & setlocal
set batchPath=%~dp0
C:
goto msg

:script
powershell.exe "C:\SULFURAX\FreshStart\WUpdate.ps1"
:: Clear CMD
timeout /t 5 /nobreak
cls
exit

:msg
SET msgboxTitle=Warn !
SET msgboxBody=If there's a major update from Windows Update, your PC might restart after it's installed. So save your work wait for the end of the script to know if your PC restarts or not. By the way, you can't stop the restart yourself.
SET tmpmsgbox=%temp%\~tmpmsgbox.vbs
IF EXIST "%tmpmsgbox%" DEL /F /Q "%tmpmsgbox%"
ECHO msgbox "%msgboxBody%",0,"%msgboxTitle%">"%tmpmsgbox%"
WSCRIPT "%tmpmsgbox%"

goto script