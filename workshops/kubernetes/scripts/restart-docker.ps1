# Restart Docker service
Write-Host "Restarting Docker..."
Restart-Service -DisplayName "Docker Desktop Service"
Write-Host "Docker restarted."