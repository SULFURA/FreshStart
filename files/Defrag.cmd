@echo off
color 03
Mode 130,45

title Etape 7 : Defrag

defrag /c /o /u

:: Clear CMD
timeout /t 5 /nobreak
cls
exit