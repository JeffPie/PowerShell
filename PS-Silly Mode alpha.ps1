#Check for EXO V2 module installation 
Write-host ":) Welcome to Exchange Online PowerShell Silly Mode! Checking if ExchangeOnline Module installed...`r`n"

$Module = Get-Module ExchangeOnlineManagement -ListAvailable 
if($Module.count -eq 0)  {  
     Write-Host Exchange Online PowerShell V2 module is not available  -ForegroundColor yellow   
    $Confirm= Read-Host Are you sure you want to install module? [Y] Yes [N] No  
    if($Confirm -match "[yY]")  
    {  
     Write-host "Installing Exchange Online PowerShell module`r`n" 
     Install-Module ExchangeOnlineManagement -Repository PSGallery -AllowClobber -Force 
     }  
     else  
     {  
      Write-Host EXO V2 module is required to connect Exchange Online.Please install module to using ExchangeOnlineManagement cmdlet.  
     } 
}
else { Write-Host 'Excellent! Looks like you are good to go!'`r`n}

#Connect to exchange online
$a = 1

while ($a -eq 1) {
	Write-host "To use Silly Mode you need to login your MS365 account`r`n" 
	#$username = Read-Host"Please input your username"
	$Confirm= Read-Host Do you want to login your ExchangeOnline [Y] Yes [N] No  
 		 if($Confirm -match "[yY]")  
 		 {  
 			 Write-host "Please put your Username & Password in the pop up window to login Exchange Online PowerShell module" 
             Write-Host Connecting to Exchange Online...
             Connect-ExchangeOnline 
             Write-Host You have login successfully!`r`n
             $a = 2 
 		 }  
 		 else  
 		 {   
            Write-Output '  Thank you for using PowerShell Silly Mode
  	See you next time!'	 
             }
}

### Main Funtion start from here
$b = 1
while ($b -eq 1) {
Write-host "<<<PowerShell Silly Mode Main Menu>>>"`r`n"What can I do for you? `r`n
1.List All Users`r`n
2.List All Users' Mailbox`r`n
3.List User's Mailbox Statistics`r`n
4.List User's Mailbox AutoReply Configuration`r`n 
5.Enable User's AutoReply`r`n
6.Disable User's AutoReply`r`n
7.List User's MailboxPermission`r`n
8.Add User's MailboxPermission`r`n
9.Remove User's MailboxPermission`r`n 
Q.Quit`r`n"

$selection = Read-host 'Please input the number of your selection'

    if ($selection -eq 1) {
        Get-Recipient | out-host -Paging 
        Read-host "press 'ENTER' key to return to Main Menu"
    }#List all User

    if ($selection -eq 2) {
        Get-EXOMailbox | out-host -Paging 
        Read-host "press 'ENTER' key to return to Main Menu"
    }#List all Mailbox

    if($selection -eq 3) {
        $username = read-host "Please input user's username in format Firstname.Lastname" 
		Get-MailboxStatistics -Identity $username | out-host -Paging
        Read-host "press 'ENTER' key to return to Main Menu"
	}#Get Mailbox Statistics
	
    if($selection -eq 4) {
        $username = read-host "Please input user's username in format Firstname.Lastname" 
		Get-MailboxAutoReplyConfiguration -Identity $username
        Read-host "press 'ENTER' key to return to Main Menu"
    }#Get user's MailboxAutoReplyConfiguration

    if ($selection -eq 5) {
        Write-Host 'Which User You are going to Enable AutoReply?'
        $username = read-host "Please input user's username in format Firstname.Lastname" 
        $message = read-host  "Please Copy and Edit the AutoReply message here: <html><body>Hi XXX,<br>This is Line 1, delete and put your message here.<br>Regards,<br>Name</body></html>"
        Set-MailboxAutoReplyConfiguration -Identity $username -AutoReplyState "Enabled" -ExternalAudience "Known" -InternalMessage $message -ExternalMessage $message -Confirm
        Write-Host "$username's Mailbox AutoReplay has been successfully enabled! "
        "This is NOT a scheduled AutoReply, DON'T forget to Disable it when user comes back to office!"
        Read-host "press 'ENTER' key to return to Main Menu"
    }#Enable User's AutoReply

    if ($selection -eq 6) {
        Write-Host 'Which User You are going to Disable AutoReply?'
        $username = read-host "Please input user's username in format Firstname.Lastname" 
        Set-MailboxAutoReplyConfiguration -Identity $username -AutoReplyState "Disabled" -Confirm
        Write-Host "User:$username's Mailbox AutoReplay has been Disabled!"
        Read-host "press 'ENTER' key to return to Main Menu"
    }#Disable User's AutoReply

    if ($selection -eq 7) {
        Write-Host 'Which User You are going to List Mailbox Permission?'
        $username = read-host "Please input user's username in format Firstname.Lastname" 
        Get-MailboxPermission -Identity $username 
        Read-host "press 'ENTER' key to return to Main Menu"
    }#List User's MailboxPermission

    if ($selection -eq 8) {
        Write-Host 'Which User You are going to List Mailbox Permission?'
        $username = read-host "Please input user's username in format Firstname.Lastname"
        $permissionuser = read-host "Please input the username who have the permission in format Firstname.Lastname"  
        Get-MailboxPermission -Identity $username -AccessRights FullAccess -User $permissionuser -Confirm
        Read-host "press 'ENTER' key to return to Main Menu"
    }#Add User's MailboxPermission

    if ($selection -eq 9) {
        Write-Host 'Which User You are going to List Mailbox Permission?'
        $username = read-host "Please input user's username in format Firstname.Lastname"
        $permissionuser = read-host "Please input the username who will be removed from permission in format Firstname.Lastname"  
        Get-MailboxPermission -Identity $username -AccessRights FullAccess -User $permissionuser -Confirm
        Read-host "press 'ENTER' key to return to Main Menu"
    }#Remove User's MailboxPermission

    if($selection -match "[qQ]"){
        Disconnect-ExchangeOnline -Confirm:$false -InformationAction Ignore -ErrorAction SilentlyContinue
        Write-Host "Disconnected active ExchangeOnline session"
        $b = 2
	}
}#Function

<#
function FullAccess {
    $MB_FullAccess = $global:Mailbox | Get-MailboxPermission -User $UPN -ErrorAction SilentlyContinue | Select-Object Identity
    if ($MB_FullAccess.count -ne 0) {
        $ExportResult = @{'User Name' = $Identity; 'AccessType' = "Full Access"; 'Delegated Mailbox Name' = $MB_FullAccess.Identity -join (",") }
    }
    else {
        $ExportResult = @{'User Name' = $Identity; 'AccessType' = "Full Access"; 'Delegated Mailbox Name' = "-" }
    }
    $ExportResults = New-Object PSObject -Property $ExportResult
    $ExportResults | Select-object 'User Name', 'AccessType', 'Delegated Mailbox Name' | Export-csv -path $global:ExportCSVFileName -NoType -Append -Force
}
function SendAs {
    $MB_SendAs = Get-RecipientPermission -Trustee $UPN -ErrorAction SilentlyContinue | Select-Object Identity
    if ($MB_SendAs.count -ne 0) {
        $ExportResult = @{'User Name' = $Identity; 'AccessType' = "Send As"; 'Delegated Mailbox Name' = $MB_SendAs.Identity -join (",") }
    }
    else {
        $ExportResult = @{'User Name' = $Identity; 'AccessType' = "Send As"; 'Delegated Mailbox Name' = "-" }
    }
    $ExportResults = New-Object PSObject -Property $ExportResult
    $ExportResults | Select-object 'User Name', 'AccessType', 'Delegated Mailbox Name' | Export-csv -path $global:ExportCSVFileName -NoType -Append -Force
    
}
function SendOnBehalfTo {
    $MB_SendOnBehalfTo = $global:Mailbox | Where-Object { $_.GrantSendOnBehalfTo -match $Identity } -ErrorAction SilentlyContinue | Select-Object Name
    if ($MB_SendOnBehalfTo.count -ne 0) {
        $ExportResult = @{'User Name' = $Identity; 'AccessType' = "Send on Behalf"; 'Delegated Mailbox Name' = $MB_SendOnBehalfTo.Name -join (",") }
    }
    else {
        $ExportResult = @{'User Name' = $Identity; 'AccessType' = "Send on Behalf"; 'Delegated Mailbox Name' = "-" }
    }
    $ExportResults = New-Object PSObject -Property $ExportResult
    $ExportResults | Select-object 'User Name', 'AccessType', 'Delegated Mailbox Name' | Export-csv -path $global:ExportCSVFileName -NoType -Append -Force
}


Connect_Exo 
$global:ExportCSVFileName = "MailboxesUserHasAccessTo_" + ((Get-Date -format "MMM-dd hh-mm-ss tt").ToString()) + ".csv"
$global:Mailbox = Get-Mailbox -ResultSize Unlimited
if (($UPN -ne "")) {
    $UserInfo = $global:Mailbox | Where-Object { $_.UserPrincipalName -eq "$UPN" } | Select-Object Identity
    $Identity = $UserInfo.Identity
    if ($FullAccess.IsPresent) {
        FullAccess
    }
    if ($SendAs.IsPresent) {
        SendAs
    }
    if ($SendOnBehalf.IsPresent) {
        SendOnBehalfTo
    }
    if((($FullAccess.IsPresent) -eq $false) -and (($SendAs.IsPresent) -eq $false) -and (($SendOnBehalf.IsPresent) -eq $false)){
        FullAccess
        SendAs
        SendOnBehalfTo
    }
}
elseif (($CSV -ne "")) {
    Import-Csv $CSV -ErrorAction Stop | ForEach-Object {
        $UPN = $_.UPN
        $UserInfo = $global:Mailbox | Where-Object { $_.UserPrincipalName -eq "$UPN" } | Select-Object Identity
        $Identity = $UserInfo.Identity
        Write-Progress "Processing for the Mailbox: $Identity"
        if ($FullAccess.IsPresent) {
            FullAccess
        }
        if ($SendAs.IsPresent) {
            SendAs
        }
        if ($SendOnBehalf.IsPresent) {
            SendOnBehalfTo
        }
        if((($FullAccess.IsPresent) -eq $false) -and (($SendAs.IsPresent) -eq $false) -and (($SendOnBehalf.IsPresent) -eq $false)){
            FullAccess
            SendAs
            SendOnBehalfTo
        }
    }
}
else {
    $MBCount = 0
    $global:Mailbox | ForEach-Object {
        $MBCount = $MBCount + 1
        $UPN = $_.UserPrincipalName
        $Identity = $_.Identity
        Write-Progress -Activity "Processing for  : $Identity" -Status "Processing mailbox Count: $MBCount" 
        if ($FullAccess.IsPresent) {
            FullAccess
        }
        if ($SendAs.IsPresent) {
            SendAs
        }
        if ($SendOnBehalf.IsPresent) {
            SendOnBehalfTo
        }
        if((($FullAccess.IsPresent) -eq $false) -and (($SendAs.IsPresent) -eq $false) -and (($SendOnBehalf.IsPresent) -eq $false)){
            FullAccess
            SendAs
            SendOnBehalfTo
        }
    }
}
if ((Test-Path -Path $global:ExportCSVFileName) -eq "True") {     
    Write-Host "The Output file availble in `"$global:ExportCSVFileName`"" -ForegroundColor Green 
    $prompt = New-Object -ComObject wscript.shell    
    $userInput = $prompt.popup("Do you want to open output files?", 0, "Open Output File", 4)    
    if ($userInput -eq 6) {    
        Invoke-Item "$global:ExportCSVFileName"
    }  
}
Disconnect-ExchangeOnline -Confirm:$false -InformationAction Ignore -ErrorAction SilentlyContinue
Write-Host "Disconnected active ExchangeOnline session"
#>
