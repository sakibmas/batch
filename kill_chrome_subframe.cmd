@echo off
echo Killing Chrome subframe/renderer processes...

for /f "tokens=2" %%i in ('tasklist /FI "IMAGENAME eq chrome.exe" /FO CSV /NH') do (
    wmic process where "ProcessId=%%~i" get CommandLine 2>nul | findstr /i "renderer utility gpu-process" >nul
    if not errorlevel 1 (
        echo Killing PID %%~i
        taskkill /PID %%~i /F
    )
)
echo Done.
pause
