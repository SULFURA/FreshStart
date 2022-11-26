@echo off
color 03
Mode 130,45
C:
cd C:/

echo Click on the cleaner in your taskbar and put your mouse on the window
cd "C:\SULFURAX\FreshStart"

cleanmgr.exe /d C: /SAGERUN:1

rmdir /S /Q "C:\SULFURAX\FreshStart\DeviceCleanupCmd\"
del /F /Q "C:\SULFURAX\FreshStart\AdwCleaner.exe"
del /F /Q "C:\SULFURAX\FreshStart\EmptyStandbyList.exe"

curl -g -L -# -o "C:\SULFURAX\FreshStart\EmptyStandbyList.exe" "https://github.com/SULFURA/FreshStart/raw/main/files/EmptyStandbyList.exe"
curl -g -L -# -o "C:\SULFURAX\FreshStart\DeviceCleanupCmd.zip" "https://www.uwe-sieber.de/files/DeviceCleanupCmd.zip"
curl -g -L -# -o "C:\SULFURAX\FreshStart\AdwCleaner.exe" "https://adwcleaner.malwarebytes.com/adwcleaner?channel=release"

powershell -NoProfile Expand-Archive 'C:\SULFURAX\FreshStart\DeviceCleanupCmd.zip' -DestinationPath 'C:\SULFURAX\FreshStart\DeviceCleanupCmd\'

del /F /Q "C:\SULFURAX\FreshStart\DeviceCleanupCmd.zip"
del /Q C:\Users\%username%\AppData\Local\Microsoft\Windows\INetCache\IE\*.*
del /Q C:\Windows\Downloaded Program Files\*.*
rd /s /q %SYSTEMDRIVE%\$Recycle.bin
del /Q C:\Users\%username%\AppData\Local\Temp\*.*
del /Q C:\Windows\Temp\*.*
del /Q C:\Windows\Prefetch\*.*

cd C:\SULFURAX\FreshStart
AdwCleaner.exe /eula /clean /noreboot

for %%g in (workingsets modifiedpagelist standbylist priority0standbylist) do EmptyStandbyList.exe %%g
cd "C:\SULFURAX\FreshStart\DeviceCleanupCmd\x64"
DeviceCleanupCmd.exe *

:: Clear CMD
timeout /t 5 /nobreak
cls
exit