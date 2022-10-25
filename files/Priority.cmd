@echo off
color 03
Mode 130,45
setlocal EnableDelayedExpansion

title Etape 5 : Priority

wmic process where name="svchost.exe" call setpriority 256

:: Clear CMD
timeout /t 5 /nobreak
cls
exit