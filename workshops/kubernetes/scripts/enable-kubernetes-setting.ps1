param(
    [string]$username
)

$filepath = "C:\Users\$username\AppData\Roaming\Docker\settings.json"

$data = Get-Content -Path $dockerSettingsFile | ConvertFrom-Json

$data.kubernetesEnabled = $True

Set-Content -Value ($data | ConvertTo-Json) -Path $dockerSettingsFile