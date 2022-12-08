function Connect-ExchangeOnline {
<# .DESCRIPTION 
    1. Access all mail-box by name search
    2. Change Password
    3. Set up autoreply
    4. Get account policy
#>
    <#
    .SYNOPSIS
        Function to Connect to an Exchange Online

    .DESCRIPTION
        Function to Connect to an Exchange Online

    .PARAMETER ConnectionUri
        Specifies the Connection Uri to use
        Default is https://ps.outlook.com/powershell/

    .PARAMETER Credential
        Specifies the credential to use

    .EXAMPLE
        PS C:\> Connect-ExchangeOnline

    .EXAMPLE
        PS C:\> Connect-ExchangeOnline -Credential (Get-Credential)

    .NOTES
        Francois-Xavier Cat
        lazywinadmin.com
        @lazywinadmin
    .LINK
        https://github.com/lazywinadmin/PowerShell
#>

    param
    (
        [system.string]$ConnectionUri = 'https://ps.outlook.com/powershell/',
        [Parameter(Mandatory)]
        [Alias('RunAs')]
        [pscredential]
        [System.Management.Automation.Credential()]
        $Credential
    )
    PROCESS {
        TRY {
            # Make sure the credential username is something like admin@domain.com
            if ($Credential.username -notlike '*@*') {
                Write-Error 'Must be email format'
                break
            }

            $Splatting = @{
                ConnectionUri     = $ConnectionUri
                ConfigurationName = 'microsoft.exchange'
                Authentication    = 'Basic'
                AllowRedirection  = $true
            }
            IF ($PSBoundParameters['Credential']) { $Splatting.Credential = $Credential }
            
            # Load Exchange cmdlets (Implicit remoting)
            Import-PSSession -Session (New-PSSession @Splatting -ErrorAction Stop) -ErrorAction Stop
        }
        CATCH {
            $PSCmdlet.ThrowTerminatingError($_)
        }
    }
}