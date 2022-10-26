@echo off
C:
cd C:/
title Etape 4 : Scoop
scoop update * && scoop cache rm * && scoop cleanup *

:: Clear CMD
timeout /t 5 /nobreak
cls
exit