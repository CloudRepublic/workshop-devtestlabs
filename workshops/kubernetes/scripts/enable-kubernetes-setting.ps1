param(
    [string]$username
)

$filepath = "C:\Users\$username\AppData\Roaming\Docker\settings.json"

# Fetch settings data
$data = Get-Content -Path $dockerSettingsFile | ConvertFrom-Json

# Enable Kubernetes
$data.kubernetesEnabled = $True

# Write back settings
Set-Content -Value ($data | ConvertTo-Json) -Path $dockerSettingsFile

# Restart Docker service
Restart-Service -DisplayName "Docker Desktop Service"