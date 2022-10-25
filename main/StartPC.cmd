@echo off
color 03
Mode 130,45
title Script StartPC
setlocal EnableDelayedExpansion

:: Dossier
mkdir C:\SULFURAX\StartPC >nul 2>&1
mkdir C:\SULFURAX\Backup >nul 2>&1
cd C:\SULFURAX\StartPC >nul 2>&1

:: Run Admin
Reg.exe add HKLM /F >nul 2>&1
if %errorlevel% neq 0 start "" /wait /I /min powershell -NoProfile -Command start -verb runas "'%~s0'" && exit /b

:: Show details BSOD
Reg add "HKLM\System\CurrentControlSet\Control\CrashControl" /v "DisplayParameters" /t REG_DWORD /d "1" /f >nul 2>&1

:: Blank/Color Character
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do (set "DEL=%%a" & set "COL=%%b")

:: Add ANSI escape sequences
Reg add HKCU\CONSOLE /v VirtualTerminalLevel /t REG_DWORD /d 1 /f >nul 2>&1

:: Check Updates
goto CheckUpdates

:CheckUpdates
set local = 1.0
set localtwo=%local%
if exist "%temp%\Updater.bat" DEL /S /Q /F "%temp%\Updater.bat" >nul 2>&1
curl -g -L -# -o "%temp%\Updater.bat" "https://raw.githubusercontent.com/SULFURA/StartPC/main/files/StartPC_Version" >nul 2>&1
call "%temp%\Updater.bat"
IF "%local%" gtr "%localtwo%" (
    curl -L -o %0 "https://github.com/SULFURA/StartPC/main/StartPC.cmd" >nul 2>&1
    call %0
	exit /b
)

:: Restore Point
powershell -ExecutionPolicy Unrestricted -NoProfile Enable-ComputerRestore -Drive 'C:\', 'D:\', 'E:\', 'F:\', 'G:\' >nul 2>&1
powershell -ExecutionPolicy Unrestricted -NoProfile Checkpoint-Computer -Description 'StartPC Restore Point' >nul 2>&1

::HKCU & HKLM backup
for /F "tokens=2" %%i in ('date /t') do set date=%%i
set date1=%date:/=.%
>nul 2>&1 md C:\SULFURAX\Backup\%date1%
reg export HKCU C:\SULFURAX\Backup\%date1%\HKLM.reg /y >nul 2>&1
reg export HKCU C:\SULFURAX\Backup\%date1%\HKCU.reg /y >nul 2>&1

:: Script
cls
goto Script
title Script en cours...

:Script
:: Services
goto Services

:: Cleanup
goto Cleanup

:: Cleanup Event Logs
goto CleanupEventLogs

:: Scoop Update / RM : Cleanup
goto scoop

:: Set Priority
goto Priority

:: Refresh Network
goto RefreshNetwork

:: Defrag
goto Defrag

:: Checkup
goto Checkup

:: End
goto End

:Services
:: Start AppInfo Service
sc config AppInfo start=auto
sc start AppInfo

:: Start BAM Service
sc config BAM start= AUTO
sc start BAM start

:: Start BITS Service
sc config BITS start=auto
sc start BITS

:: Start CDPUserSvc_1675c6 Service
sc config CDPUserSvc_1675c6 start=auto
sc start CDPUserSvc_1675c6

:: Stop clicktorunsvc Service
sc config clicktorunsvc start=disabled
sc stop clicktorunsvc

:: Start DiagTrack Service
sc config DiagTrack start= AUTO
sc start DiagTrack start

:: Start DNS Service
sc config dnscache start= AUTO
sc start dnscache start

:: Start DPS Service
sc config DPS start= AUTO
sc start DPS start

:: Start Dusmsvc Service
sc config Dusmsvc start= AUTO
sc start Dusmsvc start

:: Start Eventlog Service
sc config Eventlog start= AUTO
sc start Eventlog start

:: Start PCA Service
sc config PcaSvc start= AUTO
sc start PcaSvc start

:: Start SGRMBroker Service
sc config SGRMBroker start= AUTO
sc start SGRMBroker

:: Start SysMain/Superfetch Service
sc config SysMain start= AUTO
sc start SysMain start

:: Start WSearch Service
sc config WSearch start= AUTO
sc start WSearch

:: Clear CMD
timeout /t 5 /nobreak
cls

:Cleanup 
cleanmgr.exe /d C: /SAGERUN:1

rmdir /S /Q "C:\SULFURAX\StartPC\DeviceCleanupCmd\"
del /F /Q "C:\SULFURAX\StartPC\AdwCleaner.exe"
del /F /Q "C:\SULFURAX\StartPC\EmptyStandbyList.exe"

curl -g -L -# -o "C:\SULFURAX\StartPC\EmptyStandbyList.exe" "https://wj32.org/wp/download/1455/"
curl -g -L -# -o "C:\SULFURAX\StartPC\DeviceCleanupCmd.zip" "https://www.uwe-sieber.de/files/DeviceCleanupCmd.zip"
curl -g -L -# -o "C:\SULFURAX\StartPC\AdwCleaner.exe" "https://adwcleaner.malwarebytes.com/adwcleaner?channel=release"

powershell -NoProfile Expand-Archive 'C:\SULFURAX\StartPCs\DeviceCleanupCmd.zip' -DestinationPath 'C:\SULFURAX\StartPC\DeviceCleanupCmd\'

del /F /Q "C:\SULFURAX\StartPC\DeviceCleanupCmd.zip"
del /Q C:\Users\%username%\AppData\Local\Microsoft\Windows\INetCache\IE\*.*
del /Q C:\Windows\Downloaded Program Files\*.*
rd /s /q %SYSTEMDRIVE%\$Recycle.bin
del /Q C:\Users\%username%\AppData\Local\Temp\*.*
del /Q C:\Windows\Temp\*.*
del /Q C:\Windows\Prefetch\*.*

cd C:\SULFURAX\StartPC
AdwCleaner.exe /eula /clean /noreboot

for %%g in (workingsets modifiedpagelist standbylist priority0standbylist) do EmptyStandbyList.exe %%g
cd "C:\SULFURAX\StartPC\DeviceCleanupCmd\x64"
DeviceCleanupCmd.exe *

:: Clear CMD
timeout /t 5 /nobreak
cls

:CleanupEventLogs
FOR /F "tokens=1,2*" %%V IN ('bcdedit')
for /F "tokens=*" %%G in ('wevtutil.exe el') DO (call :do_clear "%%G")
echo.
echo All Event Logs have been cleared!


:do_clear
echo clearing %1
wevtutil.exe cl %1
goto :eof

:: Clear CMD
timeout /t 5 /nobreak
cls

:scoop
scoop update * && scoop cache rm * && scoop cleanup *

:: Clear CMD
timeout /t 5 /nobreak
cls

:Priority
wmic process where name="svchost.exe" call setpriority 256

:: Clear CMD
timeout /t 5 /nobreak
cls

:RefreshNetwork
netsh advfirewall reset 
ipconfig /release 
ipconfig /renew 
nbtstat -R 
nbtstat -RR 
ipconfig /flushdns 
ipconfig /registerdns 

:: Clear CMD
timeout /t 5 /nobreak
cls

:Defrag
defrag /c /o /u

:: Clear CMD
timeout /t 5 /nobreak
cls

:Checkup
sfc /scannow && DISM /Online /Cleanup-Image /CheckHealth && DISM /Online /Cleanup-Image /ScanHealth && DISM /Online /Cleanup-Image /RestoreHealth && Dism.exe /online /Cleanup-Image /StartComponentCleanup && Dism.exe /online /Cleanup-Image /StartComponentCleanup /ResetBase

:: Clear CMD
timeout /t 5 /nobreak
cls


:End
echo Fin du Script
title Fin du Script

:: Clear CMD + Exit
timeout /t 5 /nobreak
cls
exit

:ColorText
echo off
<nul set /p ".=%DEL%" > "%~2"
findstr /v /a:%1 /R "^$" "%~2" nul
del "%~2" > nul  
goto :eof