Get-AzVM -ResourceGroupName "test1" -Name "simple-vm"

Invoke-AzVMRunCommand -ResourceGroupName 'test' -Name 'simple-vm' -CommandId 'RunPowerShellScript' -ScriptPath 'test_script.ps1' 