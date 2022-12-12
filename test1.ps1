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
} #Function