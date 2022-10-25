@echo off
color 03
Mode 130,45
setlocal EnableDelayedExpansion

title Etape 3 : Cleanup Event Logs

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
exit