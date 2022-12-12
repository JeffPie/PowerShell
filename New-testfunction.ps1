##From https://docs.microsoft.com/en-us/previous-versions/technet-magazine/hh360993(v=msdn.10)
Function Get-Something
{
<#
    .SYNOPSIS
        Describe the function here
 
    .DESCRIPTION
        Describe the function in more detail
 
    .EXAMPLE
        Give an example of how to use it
 
    .EXAMPLE
        Give another example of how to use it
 
    .PARAMETER ComputerName
        The Computer name to query. Just one.
 
    .PARAMETER LogName
        The name of a file to write failed Computer names to. Defaults to errors.txt.
 
    .INPUTS
        Input is from command line or called from a script.
 
    .OUTPUTS
        This will output the logfile.
 
    .NOTES
    Name:
    Author: JeffPie
    Version: 1.0
    DataCreated: 08/12/2022
    Purpose/Change: Initial script development
#>
    [CmdletBinding(SupportsShouldProcess=$True,ConfirmImpact='Low')]
    param
    (
        [Parameter(Mandatory,
            ValueFromPipeline=$True,
            ValueFromPipelineByPropertyName=$True,
            HelpMessage='What Computer name would you like to target?')]
        [Alias('host')]
        [ValidateLength(3,30)]
        [string[]]$ComputerName,

        [string]$Logname = 'errors.txt'
    )

    BEGIN
    {
        Write-Verbose "Beginning $($MyInvocation.Mycommand)"
        Write-Verbose "Deleting $Logname"
        Remove-Item $LogName -ErrorActionSilentlyContinue
    }

    PROCESS
    {
        Write-Verbose "Processing $($MyInvocation.Mycommand)"

        ForEach ($Computer in $ComputerName) {
            Write-Verbose "Processing $Computer"
            IF ($pscmdlet.ShouldProcess($Computer)) {
                # use $Computer here
            }
        }
    }
    END
    {
        Write-Verbose "Ending $($MyInvocation.Mycommand)"
    }
}

function disableMailbox($user){
	Disable-Mailbox -Identity $user
}

$a=1
while ($a -eq 1) {
	$selection = read-host "Select your action."
	if($selection -eq "q"){
		$a = 2
	}
	if($selection -eq 1) {
		$username = read-host "Please input your username"
		Connect-Exchangeonline -UserPrincipalName $username
	}
	if($selection -eq 2) {
		$b = 1
		while($b -eq 1){
			write-host "1. Disable a mail box`r`n 2.Enable Auto forwarding message.`r`n3.Quit`r`n"
			$sel = read-host "Please input your selection"
			if($sel -eq "q"){
				$b = 2
			}
			if($sel -eq "1"){
				$usernameTobeDisabled = read-host "Please enter username to be disabled"
				disableMailbox($usernameTobeDisabled)
			}
	
		}
	}
}
