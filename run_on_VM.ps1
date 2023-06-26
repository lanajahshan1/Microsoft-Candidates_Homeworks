Get-AzVM -ResourceGroupName "test" -Name "simple-vm"

Invoke-AzVMRunCommand -ResourceGroupName 'test' -Name 'simple-vm' -CommandId 'RunPowerShellScript' -ScriptPath 'test_script.ps1' 