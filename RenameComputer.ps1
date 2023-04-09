Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Force -ErrorAction SilentlyContinue
$Bios = Get-WmiObject Win32_BIOS
Rename-Computer -NewName $Bios.SerialNumber -Restart
