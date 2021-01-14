$downloadFile   = "wsl2-update.msi"
$logFile        = "wsl2-update_install.log"
$msiArguments = @(
    "/a"
    $downloadFile
    "/qn"
    "/L*v"
    $logFile
)

Write-Host "Downloading WSL2 update file..."

Invoke-WebRequest -Uri 'https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi' -outfile $downloadFile

Write-Host "Download complete."

Write-Host "Installing MSI..."

$proc = Start-Process -FilePath "msiexec.exe" -ArgumentList $msiArguments -Wait -NoNewWindow

Write-Host "MSI installation complete with exit-code: $($proc.ExitCode)."