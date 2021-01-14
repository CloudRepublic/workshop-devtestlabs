$regPath = "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\OOBE"

If(Get-ItemProperty -Path $regPath)
{
    Write-Host "Enabling DisablePrivacyExperience value..."
    Set-ItemProperty -Path $regPath -Name DisablePrivacyExperience -Value 1
}
Else
{
    Write-Host "Creating DisablePrivacyExperience registry key..."
    New-ItemProperty -Path $regPath -Name DisablePrivacyExperience -PropertyType DWord -Value 1
}

Write-Host "Policy change completed."