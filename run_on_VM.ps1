Get-AzVM -ResourceGroupName "Candidates_Homework_Lana" -Name "simple-vm"

$result = Invoke-AzVMRunCommand -ResourceGroupName 'Candidates_Homework_Lana' -Name 'simple-vm' -CommandId 'RunPowerShellScript' -ScriptPath 'test_script.ps1' 

$output = $result.Value[0].Message
Write-Output "Script Output: $output"