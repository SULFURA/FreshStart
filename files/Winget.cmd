@echo off
color 03
Mode 130,45
C:
cd C:/

winget upgrade -h --all --include-unknown

:: Clear CMD
timeout /t 5 /nobreak
cls
exit