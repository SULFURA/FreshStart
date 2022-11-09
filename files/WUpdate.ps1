
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -force

Install-Module -Name PSWindowsUpdate -Force

Get-WindowsUpdate

Install-WindowsUpdate -NotCategory "Drivers" -AcceptAll -Install -AutoReboot

Exit-PSSession
Exit