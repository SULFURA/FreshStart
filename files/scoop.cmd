@echo off
C:
cd C:/

if exist "C:\Users\%username%\scoop\" (
    scoop update * && scoop cache rm * && scoop cleanup * && exit
) else (
    timeout /t 5 /nobreak
    cls
    exit
)
