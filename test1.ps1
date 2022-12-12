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