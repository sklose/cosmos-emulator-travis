# Write-Host "Downloading Cosmos Emulator"
# curl https://aka.ms/cosmosdb-emulator -o .\cosmos.msi

# Write-Host "Installing Emulator"
# Start-Process -Wait .\cosmos.msi -ArgumentList "/quiet"

# Write-Host "Available Powershell Modules"
# Get-Module -ListAvailable

# Write-Host "Loading CosmosDB Module"
# Import-Module "$env:ProgramFiles\Azure Cosmos DB Emulator\PSModules\Microsoft.Azure.CosmosDB.Emulator"

# Write-Host "Current Emulator Status"
# Get-CosmosDbEmulatorStatus

# New-Variable Key -Scope Global -Option Constant -Value "$env:MASTER_KEY"
# New-Variable Timeout -Scope Global -Option Constant -Value 3600
# New-Variable PartitionCount -Scope Global -Option Constant -Value 10

# Write-Host "Starting Emulator"
# Start-CosmosDbEmulator -AllowNetworkAccess -NoFirewall -NoUI -Key $Key -Timeout $Timeout -PartitionCount $PartitionCount

# Write-Host "Current Emulator Status"
# Get-CosmosDbEmulatorStatus

# Write-Host "Launching Cosmos Client"
# node index.js

# Storage Emulator

# Azure storage emulator

Write-Host "Set-NetFirewallProfile"
Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False

# # SQL DB
Write-Host "curl SqlLocalDB.MSI"
curl 'https://download.microsoft.com/download/8/D/D/8DD7BDBA-CEF7-4D8E-8C16-D9F69527F909/ENU/x64/SqlLocalDB.MSI' -o .\SqlLocalDB.MSI
Write-Host "install SqlLocalDB.MSI"
Start-Process -Wait .\SqlLocalDB.MSI -ArgumentList "/qn","IACCEPTSQLLOCALDBLICENSETERMS=YES"
# Start-Process -Wait msiexec -ArgumentList "/i",".\SqlLocalDB.MSI","/qn","IACCEPTSQLLOCALDBLICENSETERMS=YES" -RedirectStandardOutput "Output.txt" -RedirectStandardError "OutputError.txt"

Start-Sleep -s 60

Get-ChildItem -Path "$env"
Get-ChildItem -Path "C:\"
Get-ChildItem -Path "C:\Program Files"
Get-ChildItem -Path "C:\Program Files (x86)"
Get-ChildItem -Path "C:\Program Files\Microsoft SQL Server"
Get-ChildItem -Path "C:\Program Files\Microsoft SQL Server\110"
Get-ChildItem -Path "C:\Program Files\Microsoft SQL Server\110\Tools"
Get-ChildItem -Path "C:\Program Files\Microsoft SQL Server\110\Tools\Binn"

Write-Host "Get Output.txt"
Get-Content -Path "Output.txt"

Write-Host "Get OutputError.txt"
Get-Content -Path "OutputError.txt"

Write-Host "Downloading Storage Emulator"
curl 'https://go.microsoft.com/fwlink/?linkid=717179&clcid=0x409' -o .\az_storage_emulator.msi

Write-Host "Installing Storage Emulator"
Start-Process -Wait .\az_storage_emulator.msi -ArgumentList "/quiet"

Get-ChildItem -Path "C:\"
Get-ChildItem -Path "C:\Program Files"
Get-ChildItem -Path "C:\Program Files (x86)"

Write-Host "Swap IP"
$vm_ip = (Get-NetIPAddress -InterfaceAlias "Ethernet" -AddressFamily "IPv4").IPAddress
$storage_emulator_config_path = "C:\Program Files (x86)\Microsoft SDKs\Azure\Storage Emulator\AzureStorageEmulator.exe.config"
((Get-Content -path $storage_emulator_config_path -Raw) -replace '127.0.0.1', $vm_ip ) | Set-Content -Path $storage_emulator_config_path

# Start-Sleep -s 60

Write-Host "SqlLocalDB.exe create MSSQLLocalDB"
Start-Process -Wait "C:\Program Files\Microsoft SQL Server\110\Tools\Binn\SqlLocalDB.exe" -ArgumentList "create","MSSQLLocalDB"

Write-Host "SqlLocalDB.exe start MSSQLLocalDB"
Start-Process -Wait "C:\Program Files\Microsoft SQL Server\110\Tools\Binn\SqlLocalDB.exe" -ArgumentList "start","MSSQLLocalDB"

Write-Host  "AzureStorageEmulator.exe init"
Start-Process -Wait "C:\Program Files (x86)\Microsoft SDKs\Azure\Storage Emulator\AzureStorageEmulator.exe"  -ArgumentList "init","/server=(localdb)\MSSQLLocalDb", "-inprocess"

Start-Sleep -s 60

Write-Host "AzureStorageEmulator.exe start"
Start-Process -Wait "C:\Program Files (x86)\Microsoft SDKs\Azure\Storage Emulator\AzureStorageEmulator.exe"  -ArgumentList "start"

Start-Sleep -s 60

Write-Host  "AzureStorageEmulator.exe status"
Start-Process -Wait "C:\Program Files (x86)\Microsoft SDKs\Azure\Storage Emulator\AzureStorageEmulator.exe"  -ArgumentList "status", "-inprocess"

Write-Host "Launching Storage Client"
node storage_index.js

Start-Sleep -s 60
