Write-Host "Downloading Cosmos Emulator"
curl https://aka.ms/cosmosdb-emulator -o .\cosmos.msi

Write-Host "Installing Emulator"
Start-Process -wait .\cosmos.msi -ArgumentList "/quiet"

Write-Host "Available Powershell Modules"
Get-Module -ListAvailable

Write-Host "Loading CosmosDB Module"
Import-Module "$env:ProgramFiles\Azure Cosmos DB Emulator\PSModules\Microsoft.Azure.CosmosDB.Emulator"

Write-Host "Current Emulator Status"
Get-CosmosDbEmulatorStatus

New-Variable Key -Scope Global -Option Constant -Value "$env:MASTER_KEY"
New-Variable Timeout -Scope Global -Option Constant -Value 3600
New-Variable PartitionCount -Scope Global -Option Constant -Value 10

Write-Host "Starting Emulator"
Start-CosmosDbEmulator -AllowNetworkAccess -NoFirewall -NoUI -Key $Key -Timeout $Timeout -PartitionCount $PartitionCount

Write-Host "Current Emulator Status"
Get-CosmosDbEmulatorStatus

Write-Host "Launching Cosmos Client"
node index.js

# Storage Emulator

# Azure storage emulator
Write-Host "Downloading Storage Emulator"
curl 'https://go.microsoft.com/fwlink/?linkid=717179&clcid=0x409' -o .\az_storage_emulator.msi

Write-Host "Installing Storage Emulator"
Start-Process -wait .\az_storage_emulator.msi -ArgumentList "/quiet"

Write-Host  "AzureStorageEmulator.exe start"
Start-Process -wait "C:\Program Files (x86)\Microsoft SDKs\Azure\Storage Emulator\AzureStorageEmulator.exe"  -ArgumentList "start"

Start-Sleep -s 60

Write-Host  "AzureStorageEmulator.exe status"
Start-Process -wait "C:\Program Files (x86)\Microsoft SDKs\Azure\Storage Emulator\AzureStorageEmulator.exe"  -ArgumentList "status"

Write-Host "Launching Storage Client"
node storage_index.js
