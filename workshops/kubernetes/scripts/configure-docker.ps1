param(
    [string]$username
)

# Read user config file, or create if it does not exist
$filepath = "C:\Users\$username\AppData\Roaming\Docker"

If (-not (Test-Path $filepath -PathType Any))
{
    try {
        New-Item -Path $filepath -ItemType Directory -ErrorAction Stop | Out-Null
    }
    catch {
        Write-Error -Message "Unable to create directory '$filepath'. Error was: $_" -ErrorAction Stop
    }

    
}