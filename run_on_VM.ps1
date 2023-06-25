Get-AzVM -ResourceGroupName "test" -Name "simple-vm"

write-Output "run Invoke-AzVMRunCommand"
$result = Invoke-AzVMRunCommand -ResourceGroupName 'test' -Name 'simple-vm' -CommandId 'RunPowerShellScript' -ScriptPath 'test_script.ps1'


$output = $result.Value[0].Message
Write-Output "Script Output: $output"
