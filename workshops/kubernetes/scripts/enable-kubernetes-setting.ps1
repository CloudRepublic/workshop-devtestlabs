$filepath = Join-Path -Path $env:APPDATA -ChildPath "/docker/settings.json"

Write-Host "Changing settings on file '$filepath'..."

# Fetch settings data
$data = Get-Content -Path $filepath | ConvertFrom-Json

# Enable Kubernetes
$data.kubernetesEnabled = $True

# Write back settings
Set-Content -Value ($data | ConvertTo-Json) -Path $filepath

Write-Host "Settings changed."

# Restart Docker service
Write-Host "Restarting Docker..."
Restart-Service -DisplayName "Docker Desktop Service"
Write-Host "Docker restarted."