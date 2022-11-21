@echo off
color 03
Mode 130,45
C:
cd "%ProgramFiles%\Windows Defender\"

cls
Mode 65,16
echo.
echo            Do you want make a complete scan WDefender ?
echo              - You need to enable Windows Defender -
echo         You may experience performance loss during the scan
echo  ______________________________________________________________
echo.
echo      [ Y ] To make a scan
echo.
echo      [ N ] Skip scan
echo.
choice /c:YN /n /m "%DEL%                                >:"
if %errorlevel% equ 1 (
    Mode 130,45
    cd "%ProgramFiles%\Windows Defender\"
    MpCmdRun -SignatureUpdate
    echo.
    echo.
    MpCmdRun -Scan -ScanType -BootSectorScan
    MpCmdRun -Scan -ScanType 2
) else (
    Mode 130,45
    timeout /t 5 /nobreak
    cls
    exit
)