param (
  [string]$Tname= $args[0]
)
Resolve-DnsName -Name $Tname -Type NS -ErrorAction SilentlyContinue | ft
Resolve-DnsName -Name $Tname -Type MX -ErrorAction SilentlyContinue | ft
$TAR=Resolve-DnsName -Name $Tname -Type A -ErrorAction SilentlyContinue
$TAR
$TAR | ForEach-Object{Resolve-DnsName -Name $_.IPAddress -Type PTR -ErrorAction SilentlyContinue | ft}