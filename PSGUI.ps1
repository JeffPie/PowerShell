Add-Type -assembly system.windows.forms
$main_form = New-Object System.windows.forms.form
$main_form.Text = 'GUI for Powershell Silly Mode'
$main_form.Width = 800
$main_form.Height = 800
$main_form.AutoSize = $true
$main_form.ShowDialog()