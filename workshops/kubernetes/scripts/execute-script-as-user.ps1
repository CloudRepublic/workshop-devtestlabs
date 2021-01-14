param(
    [string]$username,
    [string]$password,
    [string]$scriptFile
)

function Set-LocalAccountTokenFilterPolicy
{
    [CmdletBinding()]
    param(
        [int] $Value = 1
    )

    $oldValue = 0

    $regPath ='HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System'
    $policy = Get-ItemProperty -Path $regPath -Name LocalAccountTokenFilterPolicy -ErrorAction SilentlyContinue

    if ($policy)
    {
        $oldValue = $policy.LocalAccountTokenFilterPolicy
    }

    if ($oldValue -ne $Value)
    {
        Set-ItemProperty -Path $regPath -Name LocalAccountTokenFilterPolicy -Value $Value
    }

    return $oldValue
}


#####
# Main execution
#####

$secPassword = ConvertTo-SecureString -String $password -AsPlainText -Force
$credential = New-Object System.Management.Automation.PSCredential("$env:COMPUTERNAME\$($username)", $secPassword)
$command = "$PSScriptRoot\$scriptFile"

$oldPolicyValue = Set-LocalAccountTokenFilterPolicy
try
{
    Write-Host "Executing command '$command' as (local) user '$username'..."
    Invoke-Command -ComputerName $env:COMPUTERNAME -Credential $credential -FilePath $command
    Write-Host "Command executed succesfully"
}
finally
{
    Set-LocalAccountTokenFilterPolicy -Value $oldPolicyValue | Out-Null
}