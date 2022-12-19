Add-Type -assembly system.windows.forms
$main_form = New-Object System.windows.forms.form
$main_form.Text = 'GUI for Powershell Silly Mode'
$main_form.Width = 800
$main_form.Height = 800
$main_form.AutoSize = $true


#Sign in ExchangeOnline 


<#$answer = [System.Windows.MessageBox]::Show( "Do you want to login your ExchangeOnline?", " Login Confirmation", "YesNoCancel", "Warning" )
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
#>

#Create Label 
$Label = New-Object System.Windows.Forms.Label
$Label.Text = 'All Alias'
$Label.Location = New-Object System.Drawing.Point(0,10)
$Label.AutoSize = $true
$main_form.Controls.Add($Label)
#Drop-Down List
$ComboBox = New-Object System.Windows.Forms.ComboBox
$ComboBox.Width = 300
$Users = Get-Alias 
Foreach ($User in $Users)
{
$ComboBox.Items.Add($User);
}
$ComboBox.Location  = New-Object System.Drawing.Point(60,10)
$main_form.Controls.Add($ComboBox)



$main_form.ShowDialog() #This line will show GUI, add code before this line
