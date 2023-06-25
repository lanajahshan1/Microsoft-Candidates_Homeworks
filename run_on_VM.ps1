Get-AzVM -ResourceGroupName "test" -Name "simple-vm"

write-Output "run Invoke-AzVMRunCommand"
Invoke-AzVMRunCommand -ResourceGroupName 'test' -Name 'simple-vm' -CommandId 'RunPowerShellScript' -ScriptPath 'test_script.ps1'