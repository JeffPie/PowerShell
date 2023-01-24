#Check for EXO V2 module installation 
Write-host "
____________________________________
/ :) Welcome to PowerShell Exchange \
\ Online Silly Mode!                /
____________________________________
        \   ^__^
         \  (oo)\_______
            (__)\       )\/\
                ||----w |
                ||     ||
"-ForegroundColor  Cyan
Write-Host "Checking if ExchangeOnline Module installed...`r`n" 

$Module = Get-Module ExchangeOnlineManagement -ListAvailable 
if($Module.count -eq 0)  {  
     Write-Host Exchange Online PowerShell module is not available`r`nTo use PowerShell Silly Mode you need to install Exchange Online Module -ForegroundColor yellow   
    $Confirm= Read-Host Are you sure you want to install module? [Y] Yes [N] No  
    if($Confirm -match "[yY]")  
    {  
     Write-host "Installing Exchange Online PowerShell module...`r`n" 
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
            Write-Host "
_____________________________________________
/ :) Thank you for using PowerShell Exchange \
\ Online Silly Mode! See you next time!      /
_____________________________________________
        \   ^__^
         \  (oo)\_______
            (__)\       )\/\
                ||----w |
                ||     ||
"-ForegroundColor  Cyan
    
    Start-Sleep -Seconds 2
    Exit
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
10.Enable Group Mailbox AutoReply`r`n
Q.Quit`r`n" -ForegroundColor Yellow

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
        Write-Host 'Which User You need to Enable AutoReply?'
        $username = read-host "Please input user's username in format Firstname.Lastname" 
        $message = read-host  "Please Copy and Edit the AutoReply message between: <pre> </pre>"
        $starttime = read-host "Please put the start time of autoreply in format 'mm/dd/yyyy 6:00:00 AM' set time should minus 11 hours from Hobart Time"
        $endtime = read-host "Please put the start time of autoreply in format 'mm/dd/yyyy 6:00:00 AM' set time should minus 11 hours from Hobart Time"
        $confirm = Read-Host  "Confirm`r`nAre you sure you want to Set the automatic reply configuration for mailbox Identity:$username`r`n[Y] Yes [N] No"
            if ($confirm -match "[yY]"){
            Set-MailboxAutoReplyConfiguration -Identity $username -AutoReplyState "Scheduled" -StartTime "$starttime" -EndTime "$endtime" -ExternalMessage $message -ExternalAudience All -InternalMessage $null
            Write-Host "$username's Mailbox AutoReplay has been successfully enabled! " -ForegroundColor DarkGreen -BackgroundColor White
            "This is NOT a scheduled AutoReply, DON'T forget to Disable it when user comes back to office!" 
            Read-host "press 'ENTER' key to return to Main Menu"
            }
            else {
            $b = 1
            }
        
    }#Enable User's AutoReply

    if ($selection -eq 6) {
        Write-Host 'Which User You are need to Disable AutoReply?'
        $username = read-host "Please input user's username in format Firstname.Lastname" 
        $confirm = Read-Host  "Confirm`r`nAre you sure you want to perform this action?`r`nRemove the automatic reply configuration for mailbox Identity:$username`r`n[Y] Yes [N] No"
            if ($confirm -match "[yY]"){
            Set-MailboxAutoReplyConfiguration -Identity $username -AutoReplyState "Disabled"
            Write-Host "User:$username's Mailbox AutoReplay has been Disabled!" -ForegroundColor DarkGreen -BackgroundColor White
            Read-host "press 'ENTER' key to return to Main Menu"
            }#Disable User's AutoReply
            else {
                $b = 1
            }
    }    
    if ($selection -eq 7) {
        Write-Host 'Which User You need to List Mailbox Permission?'
        $username = read-host "Please input user's username in format Firstname.Lastname" 
        Get-MailboxPermission -Identity $username 
        Read-host "press 'ENTER' key to return to Main Menu"
    }#List User's MailboxPermission

    if ($selection -eq 8) {
        Write-Host 'Which User You need to Add a Mailbox Permission?'
        $username = read-host "Please input user's username in format Firstname.Lastname"
        $permissionuser = read-host "Please input the username who have the permission in format Firstname.Lastname"  
        $confirm = Read-Host  "Confirm`r`nAre you sure you want to perform this action?`r`nGive $permissionuser permission to access $username's mailbox:`r`n[Y] Yes [N] No"
            if ($confirm -match "[yY]"){
            Add-MailboxPermission -Identity $username -AccessRights FullAccess -User $permissionuser
            Write-Host "The permission has been successfully Added!" -ForegroundColor DarkGreen -BackgroundColor White
            Read-host "press 'ENTER' key to return to Main Menu"
            }
            else{
                    $b = 1
            }
    }#Add User's MailboxPermission

    if ($selection -eq 9) {
        Write-Host 'Which User You need to Remove a Mailbox Permission?'
        $username = read-host "Please input user's username in format Firstname.Lastname"
        $permissionuser = read-host "Please input the username who will be removed from permission in format Firstname.Lastname"  
        $confirm = Read-Host  "Confirm`r`nAre you sure you want to perform this action?`r`nRemove $permissionuser permission to access $username's mailbox:`r`n[Y] Yes [N] No"
            if ($confirm -match "[yY]"){
            Remove-MailboxPermission -Identity $username -AccessRights FullAccess -User $permissionuser -Confirm:$false
            Write-Host "The permission has been successfully Removed!" -ForegroundColor DarkGreen -BackgroundColor White
            Read-host "press 'ENTER' key to return to Main Menu"
            }
            else{
                    $b = 1
            }#Remove User's MailboxPermission
        }
     if ($selection -eq 10) {
        Write-Host 'Which User You need to Enable AutoReply?'
        $username = read-host "Please input user's username in format Firstname.Lastname" 
        $message = read-host  "Please Copy and Edit the AutoReply message between: <pre> </pre>"
        $starttime = read-host "Please put the start time of autoreply in format 'mm/dd/yyyy 6:00:00 AM' set time should minus 11 hours from Hobart Time"
        $endtime = read-host "Please put the start time of autoreply in format 'mm/dd/yyyy 6:00:00 AM' set time should minus 11 hours from Hobart Time"
        Set-MailboxAutoReplyConfiguration -Identity $username -AutoReplyState "Scheduled" -StartTime "$starttime" -EndTime "$endtime" -ExternalMessage $message -ExternalAudience All -InternalMessage $null
        Write-Host "$username's Mailbox AutoReplay has been successfully enabled! " -ForegroundColor DarkGreen -BackgroundColor White
        "This is NOT a scheduled AutoReply, DON'T forget to Disable it when user comes back to office!" 
        Read-host "press 'ENTER' key to return to Main Menu"
        }
         #Enable User's AutoReply
           
    if($selection -match "[qQ]"){
        Disconnect-ExchangeOnline -Confirm:$false -InformationAction Ignore -ErrorAction SilentlyContinue
        Write-Host "Disconnected From ExchangeOnline session" -ForegroundColor Blue -BackgroundColor White
        $b = 2
	}
}#Function
Write-Host "
_____________________________________________
/ :) Thank you for using PowerShell Exchange \
\ Online Silly Mode! See you next time!      /
_____________________________________________
        \   ^__^
         \  (oo)\_______
            (__)\       )\/\
                ||----w |
                ||     ||
"-ForegroundColor  Cyan
Read-host "To Exit Please Press 'ENTER' key"