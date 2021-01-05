function Format-Json([Parameter(Mandatory, ValueFromPipeline)][String] $json) {
    $indent = 0;
    ($json -Split '\n' |
        % {
            if ($_ -match '[\}\]]') {
                # This line contains  ] or }, decrement the indentation level
                $indent--
            }
            $line = (' ' * $indent * 2) + $_.TrimStart().Replace(':  ', ': ')
            if ($_ -match '[\{\[]') {
                # This line contains [ or {, increment the indentation level
                $indent++
            }
            $line
        }) -Join "`n"
}

$dockerSettingsFile = $env:APPDATA + "/docker/settings.json";

$data = Get-Content -path $dockerSettingsFile | ConvertFrom-Json

# Enable kubernetes
$data.kubernetesEnabled = $True
# Disable the WSL engine to prevent an elevation popup
$data.wslEngineEnabled = $False

$json = $data | ConvertTo-Json | Format-Json

Set-Content -value $json -path $dockerSettingsFile