Function disableMailbox {
<#
    .SYNOPSIS
        This is a test script
 
    .DESCRIPTION
        The function menue let people choose the process they want to process
 
    .EXAMPLE
       Enter 1 if you want to login 
       Enter 2 if you want to disable an email account
       Enter q to quit

    .PARAMETER ComputerName
        A description of the ComputerName parameter.

    .PARAMETER Credential
        A description of the Credential parameter.

    .NOTES
    Name:
    Author: JeffPie
    Version: 1.0
    DataCreated: 08/12/2022
    Purpose/Change: Initial script development
#>
    [CmdletBinding(SupportsShouldProcess=$True,ConfirmImpact='Low')]
    PARAM
    (
        [Parameter(Mandatory,
            ValueFromPipeline=$True,
            ValueFromPipelineByPropertyName=$True,
            HelpMessage='What Computer name would you like to target?')]
        [Alias('host')]
        [ValidateLength(3,30)]
        [string[]]$ComputerName,

        [string]$Logname = 'errors.txt'
    )#PARAM

    BEGIN
    {
        Write-Verbose "Beginning $($MyInvocation.Mycommand)"
        Write-Verbose "Deleting $Logname"
        Remove-Item $LogName -ErrorActionSilentlyContinuePS-Template.ps1
    }

    PROCESS
    {
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
    }
    END
    {
        Write-Verbose "Ending" #Some Cleanup tasks
    }#END
}#Function

