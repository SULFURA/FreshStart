@echo off
color 03
Mode 130,45
C:
cd C:/

winget upgrade -h --all --include-unknown

if exist "C:\SULFURAX\Powershell\" (
    timeout /t 5 /nobreak
    cls
    exit
) else (
    mkdir C:\SULFURAX\Powershell >nul 2>&1
    winget search Microsoft.PowerShell
    winget install --id Microsoft.Powershell --source winget
    winget install --id Microsoft.Powershell.Preview --source winget
)


:: Clear CMD
timeout /t 5 /nobreak
cls
exit