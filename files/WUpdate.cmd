@echo off & setlocal
set batchPath=%~dp0
C:
powershell.exe "C:\Users\%username%\Documents\SULFURAX\FreshStart\WUpdate.ps1"

:: Clear CMD
timeout /t 5 /nobreak
cls
exit