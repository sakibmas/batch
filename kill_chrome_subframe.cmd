@echo off
setlocal enabledelayedexpansion

set TOTAL=0

for /f "skip=1 tokens=5" %%M in ('tasklist /FI "IMAGENAME eq chrome.exe" /FO TABLE /NH') do (
    set MEM=%%M
    set MEM=!MEM:,=!
    set /a TOTAL+=!MEM!
)

set /a TOTAL_MB=TOTAL/1024

echo ================================
echo  Chrome Memory Utilization
echo ================================
echo  Total (KB) : %TOTAL% KB
echo  Total (MB) : %TOTAL_MB% MB
echo ================================

echo Killing Chrome subframe/renderer processes...

for /f "tokens=2" %%i in ('tasklist /FI "IMAGENAME eq chrome.exe" /FO CSV /NH') do (
    wmic process where "ProcessId=%%~i" get CommandLine 2>nul | findstr /i "renderer utility gpu-process" >nul
    if not errorlevel 1 (
        echo Killing PID %%~i
        taskkill /PID %%~i /F
    )
)
echo Done.
