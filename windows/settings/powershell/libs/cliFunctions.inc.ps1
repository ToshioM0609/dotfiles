<#
	.SYNOPSIS
	command line editing functions library

	.DESCRIPTION
    command line function library for powershell.

	.NOTES
	@Author		Furukawa, Atsushi <atsushifx@aglabo.com>
	@License 	MIT License https://opensource.org/licenses/MIT

	@date		2023-05-31
	@Version 	1.0.0

THIS CODE IS MADE AVAILABLE AS IS, WITHOUT WARRANTY OF ANY KIND.
THE ENTIRE RISK OF THE USE OR THE RESULTS FROM THE USE OF THIS CODE REMAINS WITH THE USER.
#>
Set-StrictMode -version latest

<#
	.SYNOPSIS
	execute command

	.DESCRIPTION
	execute command wrapper for history
	if -send (equal call from command line editing)
	emulate edit command line for execute command

	.PARAMETER command

	.PARAMETER send

	.NOTES

#>
function Execute_Command() {
	param(
		[Parameter(Mandatory)][string]$command,
		[Switch]$send
	)

	if ($send) {
		# execute command with readline function
		[Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
		[Microsoft.PowerShell.PSConsoleReadLine]::InvokePrompt()
		[Microsoft.PowerShell.PSConsoleReadLine]::Insert($command)
		if ($?) {
			[Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine()
		}
	}
 else {
		Invoke-Expression($command)
	}
}

<#
	.SYNOPSIS
	select command line using peco and execute it.
	caution: for execute this function, you must install tac, peco

	.DESCRIPTION
	display history and select using tac & peco
	then select, execute it.
	use -send switch, this function execute command like key input.

	.NOTES
	using this function, you must install peco, busybox/coreutils
#>
function Execute_History() {
	param(
		[switch]$send
	)
	$history = ((Get-Content -Path (Get-PSReadLineOption).HistorySavePath -Tail 20) | 
	                     Where-Object { $_ -ne "" } |  
											 Select-Object -Unique )
	
	$command = ($history) | tac | fzf --select-1 
	if ($?) {
		Execute_Command $command -send:$send
	}
 else {
		[Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine()
	}
}

Set-Alias -Name hh -Value "Execute_History"

<#
	.SYNOPSIS
	Get Process Object of Parent Process called by ProcessID

	.DESCRIPTION


	.PARAMETER ProcessId
	Child Process ID: Get Parent Process from this ID


	.NOTES
	This function requires appropriate permissions as it uses WMI.
	Some security software may block WMI queries.

	.LINK
	Get-Process
	Get-WmiObject
 #>
function global:Get-ParentProcessId {
	param (
		[Parameter(Mandatory = $true,
			Position = 0,
			ValueFromPipeline = $true,
			ValueFromPipelineByPropertyName = $true)]
		[int]$ProcessID
	)

	process {
		$query = "SELECT ParentProcessId FROM Win32_Process WHERE ProcessId = $ProcessId"
		$parentID = (Get-WmiObject -Query $query).ParentProcessId
		$parentID
	}
}
