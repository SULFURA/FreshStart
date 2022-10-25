@echo off
color 03
Mode 130,45

title Etape 8 : Checkup

sfc /scannow && DISM /Online /Cleanup-Image /CheckHealth && DISM /Online /Cleanup-Image /ScanHealth && DISM /Online /Cleanup-Image /RestoreHealth && Dism.exe /online /Cleanup-Image /StartComponentCleanup && Dism.exe /online /Cleanup-Image /StartComponentCleanup /ResetBase

:: Clear CMD
timeout /t 5 /nobreak
cls
exit