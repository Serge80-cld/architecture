$apps = Get-ChildItem "C:\Sources" -Directory

foreach ($app in $apps) {
    if (Test-Path "$($app.FullName)\install\install.ps1") {
        Write-Host "Packaging $($app.Name)..." -ForegroundColor Cyan
        IntuneWinAppUtil.exe -c $app.FullName -s "install\install.ps1" -o "C:\Packages"
    }
}
