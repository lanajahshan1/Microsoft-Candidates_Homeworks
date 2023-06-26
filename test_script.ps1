
$sourceStorageAccountName = "lanastorageaccount11"
$sourceContainerName = "sourceblobcontainer"

write-Output "1"
$keyA = (Get-AzStorageAccountKey -ResourceGroupName "test" -Name $sourceStorageAccountName)[0].Value

write-Output "2"
$sourceContext = New-AzStorageContext -StorageAccountName $sourceStorageAccountName -StorageAccountKey $keyA


write-Output "3"
New-AzStorageContainer -Name $sourceContainerName -Context $sourceContext -Permission Container


write-Output "4"
$blobName = "file1.txt"

New-Item -Path . -Name $blobName -ItemType "file" -Value "This is a blob." -Force

write-Output "5"
Set-AzStorageBlobContent -Container $sourceContainerName -File $blobName -Blob $blobName -Context $sourceContext -Force

write-Output "6"
Remove-Item -Path "file1.txt" -Force
