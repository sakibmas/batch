@echo off
del /F/S/Q %temp%
del /F/S/Q %windir%\temp
del /F/S/Q %windir%\Prefetch
del /F/S/Q "C:\Documents and Settings\user\Recent"
RD /S /Q "%systemdrive%\$Recycle.bin"
RD /S /Q "%WinDir%\System32\GroupPolicy"
net stop wuauserv /y
net stop BITS /y
net stop cryptsvc /y
RD /S /Q C:\WINDOWS\SoftwareDistribution
RD /S /Q %windir%\system32\catroot2
RD /S /Q "%ProgramData%\Microsoft\Windows Defender\Scans\History\Service"
RD /S /Q "C:\Documents and Settings\All Users\Application Data\Microsoft\Crypto\RSA\MachineKeys"
del /F/S/Q c:\windows\windowsupdate.log
reg delete HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate /f
net start wuauserv /y
net start BITS /y
net start cryptsvc /y
for /F "tokens=*" %1 in ('wevtutil.exe el') DO wevtutil.exe cl "%1"
ForFiles /p "C:\Windows\System32\winevt\Logs" /s /d -7 /c "cmd /c del /Q @file"
ForFiles /p "C:\inetpub\logs" /s /d -7 /c "cmd /c del /Q @file"
