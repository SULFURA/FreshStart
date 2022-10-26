@echo off
color 03
Mode 130,45
C:
title Etape 2 : Cleanup

echo Click on the cleaner in your taskbar and put your mouse on the window
cd "C:\Users\%username%\Documents\SULFURAX\StartPC"

cleanmgr.exe /d C: /SAGERUN:1

rmdir /S /Q "C:\Users\%username%\Documents\SULFURAX\StartPC\DeviceCleanupCmd\"
del /F /Q "C:\Users\%username%\Documents\SULFURAX\StartPC\AdwCleaner.exe"
del /F /Q "C:\Users\%username%\Documents\SULFURAX\StartPC\EmptyStandbyList.exe"

curl -g -L -# -o "C:\Users\%username%\Documents\SULFURAX\StartPC\EmptyStandbyList.exe" "https://github.com/SULFURA/StartPC/raw/main/files/EmptyStandbyList.exe"
curl -g -L -# -o "C:\Users\%username%\Documents\SULFURAX\StartPC\DeviceCleanupCmd.zip" "https://www.uwe-sieber.de/files/DeviceCleanupCmd.zip"
curl -g -L -# -o "C:\Users\%username%\Documents\SULFURAX\StartPC\AdwCleaner.exe" "https://adwcleaner.malwarebytes.com/adwcleaner?channel=release"

powershell -NoProfile Expand-Archive 'C:\Users\%username%\Documents\SULFURAX\StartPC\DeviceCleanupCmd.zip' -DestinationPath 'C:\Users\%username%\Documents\SULFURAX\StartPC\DeviceCleanupCmd\'

del /F /Q "C:\Users\%username%\Documents\SULFURAX\StartPC\DeviceCleanupCmd.zip"
del /Q C:\Users\%username%\AppData\Local\Microsoft\Windows\INetCache\IE\*.*
del /Q C:\Windows\Downloaded Program Files\*.*
rd /s /q %SYSTEMDRIVE%\$Recycle.bin
del /Q C:\Users\%username%\AppData\Local\Temp\*.*
del /Q C:\Windows\Temp\*.*
del /Q C:\Windows\Prefetch\*.*

cd C:\Users\%username%\Documents\SULFURAX\StartPC
AdwCleaner.exe /eula /clean /noreboot

for %%g in (workingsets modifiedpagelist standbylist priority0standbylist) do EmptyStandbyList.exe %%g
cd "C:\Users\%username%\Documents\SULFURAX\StartPC\DeviceCleanupCmd\x64"
DeviceCleanupCmd.exe *

:: Clear CMD
timeout /t 5 /nobreak
cls
exit