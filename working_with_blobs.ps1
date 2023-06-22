$containerName = 'blobscontainer'
$SourceStorageAccount = "lanastorageaccount1" 
$DestStorageAccount = "lanastorageaccount2"   

$SourceStorageContext = New-AzStorageContext -StorageAccountName $SourceStorageAccount -StorageAccountKey $SourceStorageKey
$DestStorageContext = New-AzStorageContext -StorageAccountName $DestStorageAccount -StorageAccountKey $DestStorageKey

$containerA = New-AzStorageContainer -Context $SourceStorageContext
$containerb = New-AzStorageContainer -Context $DestStorageContext

#az storage container create --account-name $accountB --name $containerName --auth-mode login

For ($i=0; $i -100; $i++) {
    $filename     = "file" + $i + ".txt"
    $path = ".\file" + $i + ".txt"
    New-Item -Path . -Name $filename -ItemType "file" -Value "This is a blob."
    Set-AzStorageBlobContent -Container $containerName -File $filename 
    Remove-Item -Path $path

    Start-CopyAzureStorageBlob -Context $SourceStorageContext -SrcContainer $ContainerName -SrcBlob $filename -DestContext $DestStorageContext -DestContainer $ContainerName -DestBlob $filename
}
