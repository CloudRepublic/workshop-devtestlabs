param(
    [string]$username
)

# Read user config file, or create if it does not exist
$filepath = "C:\Users\$username\AppData\Roaming\Docker\settings.json"

If (-not (Test-Path $filepath -PathType Any))
{
    Write-Error "Path '$filepath' does not exist."
}

Write-Host "Getting JSON info..."
$settings = Get-Content $filepath | ConvertFrom-Json

Write-Host "Checking settings..."
Write-Host "AutoStart enabled: $($settings.autoStart)"
Write-Host "Kubernetes enabled: $($settings.kubernetesEnabled)"
Write-Host "WSL engine enabled: $($settings.wslEngineEnabled)"

Write-Host "Done."