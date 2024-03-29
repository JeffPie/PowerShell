Function Get-Something {
<#
    .SYNOPSIS
        Describe the function here
 
    .DESCRIPTION
        Describe the function in more detail

    .EXAMPLE
        Get-Something -ComputerName $value1 -Credential $value2

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
        Write-Verbose "Ending $($MyInvocation.Mycommand)"#Some Cleanup tasks
    }#END
}#Function

