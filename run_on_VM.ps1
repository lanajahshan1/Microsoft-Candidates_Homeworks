Get-AzVM -ResourceGroupName "test" -Name "simple-vm"
$command = "write-Output 'wee'"
write-Output "run Invoke-AzVMRunCommand"
Invoke-AzVMRunCommand -ResourceGroupName 'test' -Name 'simple-vm' -CommandId 'RunPowerShellScript' -ScriptPath $null -Command $command