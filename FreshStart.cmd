:: Copyright (C) 2022 SULFURAX
:: 
:: This program is free software: you can redistribute it and/or modify
:: it under the terms of the GNU Affero General Public License as published
:: by the Free Software Foundation, either version 3 of the License, or
:: (at your option) any later version.
:: 
:: This program is distributed in the hope that it will be useful,
:: but WITHOUT ANY WARRANTY; without even the implied warranty of
:: MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
:: GNU Affero General Public License for more details.
:: 
:: You should have received a copy of the GNU Affero General Public License
:: along with this program.  If not, see <https://www.gnu.org/licenses/>.

@echo off
color 03
Mode 130,45
title Script FreshStart 1.8
setlocal EnableDelayedExpansion

C:

:: Disable LUA
Reg.exe add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableLUA" /t REG_DWORD /d "0" /f

:: Dossier
mkdir C:\SULFURAX\FreshStart >nul 2>&1
mkdir C:\SULFURAX\Backup >nul 2>&1
cd C:\SULFURAX\FreshStart >nul 2>&1

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
set local=1.8
set localtwo=%local%
if exist "%temp%\Updater.bat" DEL /S /Q /F "%temp%\Updater.bat" >nul 2>&1
curl -g -L -# -o "%temp%\Updater.bat" "https://raw.githubusercontent.com/SULFURA/FreshStart/main/files/FreshStart_Version" >nul 2>&1
call "%temp%\Updater.bat"
IF "%local%" gtr "%localtwo%" (
	cls
	Mode 65,16
	echo.
	echo                        You need to Update
    echo                          - FreshStart -
	echo  ______________________________________________________________
	echo.
	echo                       Current version: %localtwo%
	echo.
	echo                         New version: %local%
	echo.
	echo  ______________________________________________________________
	echo.
	echo      [ Y ] To Update FreshStart
	echo.
	echo      [ N ] Skip Update
	echo.
	%SystemRoot%\System32\choice.exe /c:YN /n /m "%DEL%                                >:"
	set choice=!errorlevel!
	if !choice! equ 1 (
		curl -L -o %0 "https://github.com/SULFURA/FreshStart/releases/latest/download/FreshStart.cmd" >nul 2>&1
		call %0
		exit /b
	)
	Mode 130,45
)

:: Restore Point
powershell -ExecutionPolicy Unrestricted -NoProfile Enable-ComputerRestore -Drive 'C:\', 'D:\', 'E:\', 'F:\', 'G:\' >nul 2>&1
powershell -ExecutionPolicy Unrestricted -NoProfile Checkpoint-Computer -Description 'FreshStart Restore Point' >nul 2>&1

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

::Startup
goto Startup
:Startup
curl -g -L -# -o "C:\Users\%username%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\FreshStart.cmd" "https://raw.githubusercontent.com/SULFURA/FreshStart/main/FreshStart.cmd" >nul 2>&1

::NSudo
goto NSudo
:NSudo
C:
rmdir /S /Q "C:\SULFURAX\FreshStart\"
curl -g -L -# -o "C:\SULFURAX\FreshStart\NSudo.exe" "https://github.com/SULFURA/FreshStart/raw/main/files/NSudo.exe"

:: DownloadScripts
goto DownloadScripts

:DownloadScripts
cls
echo.
echo Don't touch anything, let the Script play alone
echo.
curl -g -L -# -o "C:\SULFURAX\FreshStart\RefreshNetwork.cmd" "https://raw.githubusercontent.com/SULFURA/FreshStart/main/files/RefreshNetwork.cmd"
curl -g -L -# -o "C:\SULFURAX\FreshStart\Services.cmd" "https://raw.githubusercontent.com/SULFURA/Verification/main/files/Script.cmd"
curl -g -L -# -o "C:\SULFURAX\FreshStart\Cleanup.cmd" "https://raw.githubusercontent.com/SULFURA/FreshStart/main/files/Cleanup.cmd"
curl -g -L -# -o "C:\SULFURAX\FreshStart\CleanupEventLogs.cmd" "https://raw.githubusercontent.com/SULFURA/FreshStart/main/files/CleanupEventLogs.cmd"
curl -g -L -# -o "C:\SULFURAX\FreshStart\scoop.cmd" "https://raw.githubusercontent.com/SULFURA/FreshStart/main/files/scoop.cmd"
curl -g -L -# -o "C:\SULFURAX\FreshStart\Winget.cmd" "https://raw.githubusercontent.com/SULFURA/FreshStart/main/files/Winget.cmd"
curl -g -L -# -o "C:\SULFURAX\FreshStart\WUpdate.cmd" "https://raw.githubusercontent.com/SULFURA/FreshStart/main/files/WUpdate.cmd"
curl -g -L -# -o "C:\SULFURAX\FreshStart\WUpdate.ps1" "https://raw.githubusercontent.com/SULFURA/FreshStart/main/files/WUpdate.ps1"
curl -g -L -# -o "C:\SULFURAX\FreshStart\Priority.cmd" "https://raw.githubusercontent.com/SULFURA/FreshStart/main/files/Priority.cmd"
curl -g -L -# -o "C:\SULFURAX\FreshStart\Defrag.cmd" "https://raw.githubusercontent.com/SULFURA/FreshStart/main/files/Defrag.cmd"
curl -g -L -# -o "C:\SULFURAX\FreshStart\Checkup.cmd" "https://raw.githubusercontent.com/SULFURA/FreshStart/main/files/Checkup.cmd"
curl -g -L -# -o "C:\SULFURAX\FreshStart\WDefender.cmd" "https://raw.githubusercontent.com/SULFURA/FreshStart/main/files/WDefender.cmd"

:: RefreshNetwork
goto RefreshNetwork

:RefreshNetwork
cls
cd "C:\SULFURAX\FreshStart\"
NSudo.exe -U:T -P:E "C:\SULFURAX\FreshStart\RefreshNetwork.cmd"
echo.
echo Don't touch anything, let the Script play alone
echo.
timeout /t 30 /nobreak

:: Services
goto Services

:Services
cls
cd "C:\SULFURAX\FreshStart\"
NSudo.exe -U:T -P:E "C:\SULFURAX\FreshStart\Services.cmd"
echo.
echo Don't touch anything, let the Script play alone
echo.
timeout /t 20 /nobreak

:: Cleanup
goto Cleanup

:Cleanup 
cls
cd "C:\SULFURAX\FreshStart\"
NSudo.exe -U:T -P:E "C:\SULFURAX\FreshStart\Cleanup.cmd"
echo.
echo Don't touch anything, let the Script play alone
echo.
timeout /t 60 /nobreak

:: Cleanup Event Logs
goto CleanupEventLogs

:CleanupEventLogs
cls
cd "C:\SULFURAX\FreshStart\"
NSudo.exe -U:T -P:E "C:\SULFURAX\FreshStart\CleanupEventLogs.cmd"
echo.
echo Don't touch anything, let the Script play alone
echo.
timeout /t 40 /nobreak

:: Scoop Update / RM : Cleanup
goto scoop

:scoop
cls
cd "C:\SULFURAX\FreshStart\"
start scoop.cmd
echo.
echo Don't touch anything, let the Script play alone
echo.
timeout /t 20 /nobreak

:: Set Winget
goto Winget

:Winget
cls
cd "C:\SULFURAX\FreshStart\"
start Winget.cmd
echo.
echo Don't touch anything, let the Script play alone
echo.
timeout /t 50 /nobreak

:: Set WUpdate
goto WUpdate

:WUpdate
cls
cd "C:\SULFURAX\FreshStart\"
start WUpdate.cmd
echo.
echo Don't touch anything, let the Script play alone
echo.
timeout /t 50 /nobreak

:: Set Priority
goto Priority

:Priority
cls
cd "C:\SULFURAX\FreshStart\"
NSudo.exe -U:T -P:E "C:\SULFURAX\FreshStart\Priority.cmd"
echo.
echo Don't touch anything, let the Script play alone
echo.
timeout /t 20 /nobreak

:: Defrag
goto Defrag


:Defrag
cls
cd "C:\SULFURAX\FreshStart\"
NSudo.exe -U:T -P:E "C:\SULFURAX\FreshStart\Defrag.cmd"
echo.
echo Don't touch anything, let the Script play alone
echo.
timeout /t 60 /nobreak

:: Checkup
goto Checkup

:Checkup
cls
cd "C:\SULFURAX\FreshStart\"
NSudo.exe -U:T -P:E "C:\SULFURAX\FreshStart\Checkup.cmd"
echo.
echo Don't touch anything, let the Script play alone
echo.
timeout /t 60 /nobreak

:: WDefender
goto WDefender

:WDefender
cls
cd "C:\SULFURAX\FreshStart\"
NSudo.exe -U:T -P:E "C:\SULFURAX\FreshStart\WDefender.cmd"
echo.
echo Don't touch anything, let the Script play alone
echo.
timeout /t 60 /nobreak

:: End
goto End

:End
cls
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