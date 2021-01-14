$filepath = Join-Path -Path $env:APPDATA -ChildPath "/docker/settings.json"

# Fetch settings data
$data = Get-Content -Path $filepath | ConvertFrom-Json

# Enable Kubernetes
$data.kubernetesEnabled = $True

# Write back settings
Set-Content -Value ($data | ConvertTo-Json) -Path $filepath

# Restart Docker service
Restart-Service -DisplayName "Docker Desktop Service"