@echo off & setlocal
set batchPath=%~dp0

SET msgboxTitle=Warn !
SET msgboxBody=If there's a major update from Windows Update, your PC might restart after it's installed. So save your work wait for the end of the script to know if your PC restarts or not. By the way, you can't stop the restart yourself.
SET tmpmsgbox=%temp%\~tmpmsgbox.vbs
IF EXIST "%tmpmsgbox%" DEL /F /Q "%tmpmsgbox%"
ECHO msgbox "%msgboxBody%",0,"%msgboxTitle%">"%tmpmsgbox%"

WSCRIPT "%tmpmsgbox%"
C:
powershell.exe "C:\Users\%username%\Documents\SULFURAX\FreshStart\WUpdate.ps1"

:: Clear CMD
timeout /t 5 /nobreak
cls
exit