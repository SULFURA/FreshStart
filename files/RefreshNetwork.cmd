@echo off
color 03
Mode 130,45
setlocal EnableDelayedExpansion

title Etape 6 : Refresh Network

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
exit