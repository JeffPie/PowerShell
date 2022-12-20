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
