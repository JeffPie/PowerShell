$a=1
while ($a -eq 1) {
	Write-host "Welcome to Exchange Online PowerShell Silly Mode" 
	#$username = Read-Host"Please input your username"
	connect-exchangeonline 

}

<#Check for EXO V2 module installation 
$Module = Get-Module ExchangeOnlineManagement -ListAvailable 
if($Module.count -eq 0)  
{  
  Write-Host Exchange Online PowerShell V2 module is not available  -ForegroundColor yellow   
  $Confirm= Read-Host Are you sure you want to install module? [Y] Yes [N] No  
  if($Confirm -match "[Y]")  
  {  
   Write-host "Installing Exchange Online PowerShell module" 
   Install-Module ExchangeOnlineManagement -Repository PSGallery -AllowClobber -Force 
  }  
  else  
  {  
   Write-Host EXO V2 module is required to connect Exchange Online.Please install module using Install-Module ExchangeOnlineManagement cmdlet.  
   Exit 
  } 
} 
Write-Host Connecting to Exchange Online... 
Connect-ExchangeOnline #>

$b = 1
while ($b -eq 1) {
	$selection = read-host "Select your action."
	if($selection -eq "q"){
		$b = 2
	}
	if($selection -eq 1) {
		$username = read-host "Please input your username"
		Connect-Exchangeonline -UserPrincipalName $username
	}
	if($selection -eq 2) {
		$c = 1
		while($c -eq 1){
			write-host "1. Disable a mail box`r`n 2.Enable Auto forwarding message.`r`n3.Quit`r`n"
			$sel = read-host "Please input your selection"
			if($sel -eq "q"){
				$c = 2
			}
			if($sel -eq "1"){
				$usernameTobeDisabled = read-host "Please enter username to be disabled"
				disableMailbox($usernameTobeDisabled)
			}
		}
	}
} #Function