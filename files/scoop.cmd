@echo off
C:
cd C:/
title Etape 5 : Scoop
scoop update * && scoop cache rm * && scoop cleanup * && exit