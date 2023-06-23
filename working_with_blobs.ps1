if (-not (Get-Module -ListAvailable Az.Storage)) {
  Install-Module -Name Az.Storage -Force
}

Connect-AzAccount

Set-AzContext -Subscription 75a700f9-db14-47c2-b97c-4481c0611f0b

$sourceStorageAccountName = "lanastorageaccount1"
$destinationStorageAccount = "lanastorageaccount2"
$sourceContainerName = "sourceblobcontainer"
$destinationContainerName = "destinationblobcontainer"

$keyA = (Get-AzStorageAccountKey -ResourceGroupName "Candidates_Homework_Lana" -Name $sourceStorageAccountName)[0].Value
$keyB = (Get-AzStorageAccountKey -ResourceGroupName "Candidates_Homework_Lana" -Name $destinationStorageAccount)[0].Value

$sourceContext = New-AzStorageContext -StorageAccountName $sourceStorageAccountName -StorageAccountKey $keyA
$destinationContext = New-AzStorageContext -StorageAccountName $destinationStorageAccount -StorageAccountKey $keyB

New-AzStorageContainer -Name $sourceContainerName -Context $sourceContext -Permission Container
New-AzStorageContainer -Name $destinationContainerName -Context $destinationContext -Permission Container

for ($i = 1; $i -le 100; $i++) {
  $blobName = "file$i.txt"

    New-Item -Path . -Name $blobName -ItemType "file" -Value "This is a blob." -Force
    $blob = Set-AzStorageBlobContent -Container $sourceContainerName -File $blobName -Blob $blobName -Context $sourceContext -Force
    Remove-Item -Path "file$i.txt" -Force
}

for ($i = 1; $i -le 100; $i++) {
  $blobName = "file$i.txt"

  $copyStatus = Start-AzStorageBlobCopy -SrcContainer $sourceContainerName -SrcBlob $blobName -DestContainer $destinationContainerName -DestBlob $blobName -Context $sourceContext -DestContext $destinationContext

  if ($copyStatus) {
      Write-Host "Blob '$blobName' copied to destination storage account successfully."
  } else {
      Write-Host "Failed to copy blob '$blobName' to destination storage account."
  }
}


Disconnect-AzAccount
