Enable automatic replies without any schedule (on until disabled) and only send to internal senders and external senders who match user contacts.
Set-MailboxAutoReplyConfiguration -Identity "Lene.Hau" -AutoReplyState "Enabled" -ExternalAudience "Known" -InternalMessage "I'm out..." -ExternalMessage "I'm out..."

Enable automatic replies with a schedule and dont send to external senders.
Set-MailboxAutoReplyConfiguration -Identity "Lene.Hau" -AutoReplyState "Scheduled" -ExternalAudience "None" -InternalMessage "I'm out..." -StartTime (Get-Date) -EndTime (Get-Date).AddDays(7)

Disable automatic replies.
Set-MailboxAutoReplyConfiguration -Identity "Lene.Hau" -AutoReplyState "Disabled"

Get-MailboxPermission
Get-MailboxPermission -Identity john@contoso.com | Format-List


Get-MailboxPermission 
Add-MailboxPermission                                                   
Remove-MailboxPermission         

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
