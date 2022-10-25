@echo off
color 03
Mode 130,45
setlocal EnableDelayedExpansion

title Etape 2 : Cleanup

echo Click on the cleaner in your taskbar and put your mouse on the window
cd "C:\SULFURAX\StartPC"

cleanmgr.exe /d C: /SAGERUN:1

rmdir /S /Q "C:\SULFURAX\StartPC\DeviceCleanupCmd\"
del /F /Q "C:\SULFURAX\StartPC\AdwCleaner.exe"
del /F /Q "C:\SULFURAX\StartPC\EmptyStandbyList.exe"

REM curl -g -L -# -o "C:\SULFURAX\StartPC\EmptyStandbyList.exe" "https://wj32.org/wp/download/1455/"
curl -g -L -# -o "C:\SULFURAX\StartPC\DeviceCleanupCmd.zip" "https://www.uwe-sieber.de/files/DeviceCleanupCmd.zip"
curl -g -L -# -o "C:\SULFURAX\StartPC\AdwCleaner.exe" "https://adwcleaner.malwarebytes.com/adwcleaner?channel=release"

powershell -NoProfile Expand-Archive 'C:\SULFURAX\StartPC\DeviceCleanupCmd.zip' -DestinationPath 'C:\SULFURAX\StartPC\DeviceCleanupCmd\'

del /F /Q "C:\SULFURAX\StartPC\DeviceCleanupCmd.zip"
del /Q C:\Users\%username%\AppData\Local\Microsoft\Windows\INetCache\IE\*.*
del /Q C:\Windows\Downloaded Program Files\*.*
rd /s /q %SYSTEMDRIVE%\$Recycle.bin
del /Q C:\Users\%username%\AppData\Local\Temp\*.*
del /Q C:\Windows\Temp\*.*
del /Q C:\Windows\Prefetch\*.*

cd C:\SULFURAX\StartPC
AdwCleaner.exe /eula /clean /noreboot

REM for %%g in (workingsets modifiedpagelist standbylist priority0standbylist) do EmptyStandbyList.exe %%g
cd "C:\SULFURAX\StartPC\DeviceCleanupCmd\x64"
DeviceCleanupCmd.exe *

:: Clear CMD
timeout /t 5 /nobreak
cls
exit