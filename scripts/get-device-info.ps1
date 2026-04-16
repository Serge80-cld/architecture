Write-Host "Collecting device info..." -ForegroundColor Cyan

$info = @{
    ComputerName = $env:COMPUTERNAME
    SerialNumber = (Get-WmiObject Win32_BIOS).SerialNumber
    OSVersion    = (Get-WmiObject Win32_OperatingSystem).Version
    EntraJoin    = (dsregcmd /status | Select-String "AzureAdJoined").ToString()
    IntuneMDM    = (dsregcmd /status | Select-String "MDMUrl").ToString()
}

$info | Format-List
