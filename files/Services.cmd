@echo off
color 03
Mode 130,45
goto Cleanup
goto Cleanup
goto Cleanup
goto Cleanup
goto Cleanup
goto Cleanup
goto Cleanup
goto Cleanup
title Etape 1 : Services

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
exit