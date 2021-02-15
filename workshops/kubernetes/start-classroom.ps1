
param (
    [Parameter()]
    [string]
    $DevTestLabName,
    [Parameter()]
    [string]
    $ResourceGroup
)

If( -Not (Get-Module -Name Az -ListAvailable) )
{
    throw "The PowerShell module 'Az' is not installed. Please see https://docs.microsoft.com/en-us/powershell/azure/install-az-ps for the installation manual."
}



####################
## Functions
####################

Function Select-Tenant()
{
    # If >1 tenant is available, let user select the prefered tenant for this script
    If ($azTenants.Count -gt 1)
    {
        do {
            try {
                Write-Host "Please select the tenant you wish to use for this script, or 'q' to quit:"

                for ($i = 0; $i -lt $azTenants.Count; $i++) {
                    Write-Host "  $($i+1))  $($azTenants[$i].Name)   (tenant ID: $($azTenants[$i].Id))"        
                }

                $tenantId = $host.ui.ReadLine()

                If ("q" -eq $tenantId) {
                    return
                }

                $parsedTenantId = ([int]$tenantId) - 1

                If ($parsedTenantId -ge 0 -And $parsedTenantId -lt $azTenants.Count)
                {
                    Write-Host "Using tenant $($azTenants[$parsedTenantId].Name) for script execution"
                    $tenantSelected = $True
                    Set-AzContext -Tenant $azTenants[$parsedTenantId].Id | Out-Null
                }
            } catch {
                $tenantSelected = $False
                Write-Host $_
            }
        } while(-Not $tenantSelected)
    }
}


Function Select-Subscription()
{
    $azSubscriptions = Get-AzSubscription

    # If >1 subscription is available, let user select the prefered subscription for this script
    If ($azSubscriptions.Count -gt 1)
    {
        do {
            try {
                Write-Host "Please select the subscription you wish to use for this script, or 'q' to quit:"

                for ($i = 0; $i -lt $azSubscriptions.Count; $i++) {
                    Write-Host "  $($i+1))  $($azSubscriptions[$i].Name)   (subscription ID: $($azSubscriptions[$i].Id))"        
                }

                $subscriptionId = $host.ui.ReadLine()

                If ("q" -eq $subscriptionId) {
                    return
                }

                $parsedSubscriptionId = ([int]$subscriptionId) - 1

                If ($parsedSubscriptionId -ge 0 -And $parsedSubscriptionId -lt $azSubscriptions.Count)
                {
                    Write-Host "Using subscription $($azSubscriptions[$parsedSubscriptionId].Name) for script execution"
                    $subscriptionSelected = $True
                    Set-AzContext -Subscription $azSubscriptions[$parsedSubscriptionId].Id | Out-Null
                }
            } catch {
                $subscriptionSelected = $False
                Write-Host $_
            }
        } while(-Not $subscriptionSelected)
    }
}



Function Get-DtlVirtualMachines()
{
    param(
        [string] $subscriptionId
    )

    $listUri = 'https://management.azure.com/subscriptions/{0}/resourceGroups/{1}/providers/Microsoft.DevTestLab/labs/{2}/virtualmachines?api-version=2018-09-15' -f $subscriptionId, $script:ResourceGroup, $script:DevTestLabName
    $allVMs = @()

    do {
        $result = Invoke-RestMethod -Method GET -Uri $listUri -Headers $headers
        
        $allVMs += $result.value
        $listUri = $result.nextLink
    } while($null -ne $listUri)

    return $allVMs
}




####################
## Main script
####################


do {
    try {
        # Get all tenants that are authorized for this user
        $azTenants = Get-AzTenant
        $connected = $True
    } catch {
        $connected = $False
        
        # PowerShell is not connected yet; connect Powershell to Azure first
        Connect-AzAccount
    }
} while (-Not $connected)


Select-Tenant
Select-Subscription

# Start the DevTestLab machines in the given environment
$token = (Get-AzAccessToken).Token
$headers = @{
    Authorization = "Bearer $token"
}

# Get all VMs
$labVMs = Get-DtlVirtualMachines -subscriptionId (Get-AzContext).Subscription

# Start all machines
foreach ($labVM in $labVMs) {
    Write-Host "Starting machine $($labVM.name)... " -NoNewline

    $result = Start-AzVM -Id $labVM.id -NoWait

    Write-Host $result.StatusCode

    if ($result.StatusCode -ne 'Accepted') {
        Write-Error "##[error]Failed to start DTL machine: $($labVM.name)"
        Write-Error $result
    }
}