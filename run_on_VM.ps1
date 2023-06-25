Get-AzVM -ResourceGroupName "test1" -Name "simple-vm"

write-Output "run Invoke-AzVMRunCommand"
Invoke-AzVMRunCommand -ResourceGroupName 'test1' -Name 'simple-vm' -CommandId 'RunPowerShellScript' -ScriptPath 'working_with_blobs.ps1' 