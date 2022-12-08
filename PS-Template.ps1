Function Get-Something {
    <#
.SYNOPSIS
    A brief description of the Get-Something function.

.DESCRIPTION
    A detailed description of the Get-Something function.

.PARAMETER ComputerName
    A description of the ComputerName parameter.

.PARAMETER Credential
    A description of the Credential parameter.

.EXAMPLE
    Get-Something -ComputerName $value1 -Credential $value2

.NOTES
    Name:
    Author: JeffPie
    Version: 1.0
    DataCreated: 08/12/2022
#>
    [CmdletBinding()]
    PARAM (
        [Alias("CN", "__SERVER", "PSComputerName")]
        [String[]]$ComputerName = $env:COMPUTERNAME,

        [Alias("RunAs")]
        [System.Management.Automation.Credential()]
        [pscredential]
        $Credential = [System.Management.Automation.PSCredential]::Empty
    )#PARAM
    TRY {
        $FunctionName = $MyInvocation.MyCommand.Name


        $Splatting = @{
            ComputerName = $ComputerName
        }

        IF ($PSBoundParameters['Credential']) {
            Write-Verbose -Message "[$FunctionName] Appending Credential"
            $Splatting.Credential = $Credential
        }

        # MAIN CODE HERE
        Write-Verbose -Message "[$FunctionName] Connect to..."

    }
    CATCH {
        $PSCmdlet.ThrowTerminatingError($_)
    }#CATCH
    FINALLY {
        #Some Cleanup tasks
    }#FINALLY
}#Function