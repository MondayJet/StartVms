try
{
    "Logging in to Azure..."
    Connect-AzAccount -Identity
}
catch {
    Write-Error -Message $_.Exception
    throw $_.Exception
}
# Define a dictionary with resource groups and VMs
$vmDictionary = @{
    "staging_RG" = @("VM1", "VM2", "VM3")
    "Test_RG" = @("VM1", "VM2", "VM3")
    "Prod_RG" = @("VM1", "VM2", "VM3")
}

# Function to start VMs
function Start-VMs {
    param (
        [string]$ResourceGroup,
        [string]$VMName
    )

    Write-Output "Starting VM: $VMName in Resource Group: $ResourceGroup"
    Start-AzVM -ResourceGroupName $ResourceGroup -Name $VMName
}

# Loop through the dictionary and perform actions
foreach ($entry in $vmDictionary.GetEnumerator()) {
    $resourceGroup = $entry.Key
    $vms = $entry.Value

    foreach ($vm in $vms) {
        # Start VM
        Start-VMs -ResourceGroup $resourceGroup -VMName $vm
    }
}
