param(
    [string]$UserName,
    [string]$Password
)

# Install Docker
& "$PSScriptRoot\Artifactfile.ps1" -UserName $UserName -Password $Password

# Configure Docker settings
$filepath = "C:\Users\$UserName\AppData\Roaming\Docker\settings.json"

$data = @{}

if (-not(Test-Path -Path $filepath -PathType Leaf)){
    Write-Host "Creating file $filepath"

    New-Item -ItemType File -Path $filepath -Force -ErrorAction Stop

    $data.acceptCanaryUpdates = $False
    $data.activeOrganizationName = ""
    $data.autoDownloadUpdates = $False
    $data.autoStart = $True
    $data.cpus = 2
    $data.credentialHelper = "docker-credential-wincred.exe"
    $data.customWslDistroDir = ""
    $data.dataFolder = "C:\\ProgramData\\DockerDesktop\\vm-data"
    $data.deprecatedCgroupv1 = $False
    $data.disableHardwareAcceleration = $False
    $data.disableUpdate = $False
    $data.diskSizeMiB = 65536
    $data.diskTRIM = $True
    $data.displayRestartDialog = $True
    $data.displaySwitchWinLinContainers = $True
    $data.displayed18362Deprecation = $False
    $data.displayedElectronPopup = @()
    $data.enableIntegrationWithDefaultWslDistro = $True
    $data.exposeDockerAPIOnTCP2375 = $False
    $data.extensionsEnabled = $True
    $data.filesharingDirectories = @()
    $data.firstLaunchTime = 1654702030
    $data.integratedWslDistros = @()
    $data.kubernetesInitialInstallPerformed = $False
    $data.lastLoginDate = 0
    $data.latestBannerKey = ""
    $data.licenseTermsVersion = 0
    $data.lifecycleTimeoutSeconds = 600
    $data.memoryMiB = 2048
    $data.onlyMarketplaceExtensions = $False
    $data.openUIOnStartupDisabled = $False
    $data.overrideProxyExclude = ""
    $data.overrideProxyHttp = ""
    $data.overrideProxyHttps = ""
    $data.proxyHttpMode = "system"
    $data.settingsVersion = 17
    $data.showExtensionsSystemContainers = $False
    $data.showKubernetesSystemContainers = $False
    $data.skipWSLMountPerfWarning = $False
    $data.socksProxyPort = 0
    $data.swapMiB = 1024
    $data.swarmFederationExplicitlyLoggedOut = $False
    $data.tipLastId = 0
    $data.tipLastViewedTime = 0
    $data.updateAvailableTime = 0
    $data.updatePopupAppearanceTime = 0
    $data.updateSkippedBuild = ""
    $data.useCredentialHelper = $True
    $data.useNightlyBuildUpdates = $False
    $data.useVirtualizationFramework = $False
    $data.useVirtualizationFrameworkVirtioFS = $False
    $data.useVpnkit = $True
    $data.useWindowsContainers = $False
    $data.vpnKitMaxPortIdleTime = 300
    $data.vpnKitTransparentProxy = $False
    $data.vpnkitCIDR = "192.168.65.0/24"
    $data.wslEnableGrpcfuse = $False
} else {
    Write-Host "Changing settings on file '$filepath'..."

    # Fetch settings data
    $data = Get-Content -Path $filepath | ConvertFrom-Json   
}

# Enable Kubernetes
$data.kubernetesEnabled = $True
$data.displayedTutorial = $True
$data.skipUpdateToWSLPrompt = $True
$data.wslEngineEnabled = $False
$data.analyticsEnabled = $False
$data.disableTips = $True

# Accept license
$data.licenseTermsVersion = 2

# Write back settings
Set-Content -Value ($data | ConvertTo-Json) -Path $filepath

Write-Host "Docker settings set."