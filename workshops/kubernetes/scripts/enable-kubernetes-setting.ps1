param(
    [string]$username
)

$filepath = "C:\Users\$username\AppData\Roaming\Docker\settings.json"

Write-Host "Changing settings on file '$filepath'..."

# Fetch settings data
$data = Get-Content -Path $filepath | ConvertFrom-Json

# Enable Kubernetes
$data.kubernetesEnabled = $True

# Write back settings
Set-Content -Value ($data | ConvertTo-Json) -Path $filepath

Write-Host "Settings changed."