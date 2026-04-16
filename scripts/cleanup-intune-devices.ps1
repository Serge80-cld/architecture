Write-Host "Removing Intune devices inactive for 90 days..." -ForegroundColor Yellow

$devices = Get-IntuneManagedDevice |
    Where-Object { $_.lastSyncDateTime -lt (Get-Date).AddDays(-90) }

foreach ($d in $devices) {
    Write-Host "Deleting $($d.deviceName)" -ForegroundColor Red
    Remove-IntuneManagedDevice -managedDeviceId $d.id
}
