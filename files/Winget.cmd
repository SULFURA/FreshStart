@echo off
color 03
Mode 130,45

winget upgrade -all

:: Clear CMD
timeout /t 5 /nobreak
cls
exit