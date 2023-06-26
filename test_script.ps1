
$sourceStorageAccountName = "lanastorageaccount11"
$sourceContainerName = "sourceblobcontainer"

$keyA = (Get-AzStorageAccountKey -ResourceGroupName "test" -Name $sourceStorageAccountName)[0].Value
$sourceContext = New-AzStorageContext -StorageAccountName $sourceStorageAccountName -StorageAccountKey $keyA
New-AzStorageContainer -Name $sourceContainerName -Context $sourceContext -Permission Container


$blobName = "file$i.txt"

New-Item -Path . -Name $blobName -ItemType "file" -Value "This is a blob." -Force
Set-AzStorageBlobContent -Container $sourceContainerName -File $blobName -Blob $blobName -Context $sourceContext -Force
Remove-Item -Path "file$i.txt" -Force
