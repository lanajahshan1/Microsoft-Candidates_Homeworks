if (-not (Get-Module -ListAvailable Az.Storage)) {
  Install-Module -Name Az.Storage -Force
}

Write-Host "1"
Set-AzContext -Subscription 75a700f9-db14-47c2-b97c-4481c0611f0b
Write-Host "2"
$keyA = (Get-AzStorageAccountKey -ResourceGroupName "Candidates_Homework_Lana" -Name "lanastorageaccount1")[0].Value
$keyB = (Get-AzStorageAccountKey -ResourceGroupName "Candidates_Homework_Lana" -Name "lanastorageaccount2")[0].Value
Write-Host "3"

$sourceContext = New-AzStorageContext -StorageAccountName "lanastorageaccount1" -StorageAccountKey $keyA
$destinationContext = New-AzStorageContext -StorageAccountName "lanastorageaccount2" -StorageAccountKey $keyB
Write-Host "4"
New-AzStorageContainer -Name "sourceblobcontainer" -Context $sourceContext -Permission Container
New-AzStorageContainer -Name "destinationblobcontainer" -Context $destinationContext -Permission Container
Write-Host "5"
for ($i = 1; $i -le 100; $i++) {
  $blobName = "file$i.txt"

    New-Item -Path . -Name $blobName -ItemType "file" -Value "This is a blob." -Force
    Set-AzStorageBlobContent -Container "sourceblobcontainer" -File $blobName -Blob $blobName -Context $sourceContext -Force
    Remove-Item -Path "file$i.txt" -Force
    Start-AzStorageBlobCopy -SrcContainer $"sourceblobcontainer" -SrcBlob $blobName -DestContainer "destinationblobcontainer" -DestBlob $blobName -Context $sourceContext -DestContext $destinationContext
}

