$downloadFile   = "wsl2-update.msi"
$logFile        = "wsl2-update_install.log"

Write-Host "Downloading WSL2 update file..."

Invoke-WebRequest -Uri 'https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi' -outfile $downloadFile

Write-Host "Download complete."

Write-Host "Installing MSI..."

msiexec.exe /a $downloadFile /l*v $logFile /quiet

Write-Host "MSI installation complete."