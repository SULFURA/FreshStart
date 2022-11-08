@echo off
C:
cd C:/
scoop update * && scoop cache rm * && scoop cleanup * && exit