@echo off
color 03
Mode 130,45
setlocal EnableDelayedExpansion

title Etape 4 : Scoop

scoop update * && scoop cache rm * && scoop cleanup *

:: Clear CMD
timeout /t 5 /nobreak
cls
exit