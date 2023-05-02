function ConvertWordTo-PDF {
 
<# 
  
.SYNOPSIS 
 
ConvertTo-PDF converts Microsoft Word documents to PDF files. 
  
.DESCRIPTION 
 
The cmdlet queries the given source folder including sub-folders to find *.docx and *.doc files, 
converts all found files and saves them as pdf in the Destination folder. After completition, the Destination
folder with the newly created PDF files will be opened with Windows Explorer.
  
.PARAMETER SourceFolder
  
Mandatory. Enter the source folder of your Microsoft Word documents.
  
.PARAMETER DestinationFolder
 
Optional. Enter the Destination folder to save the created PDF documents. If you omit this parameter, pdf files will
be saved in the Source Folder.
 
.EXAMPLE 
 
ConvertWordTo-PDF -SourceFolder C:\Temp -DestinationFolder C:\Temp1
ConvertWordTo-PDF -SourceFolder C:\temp
  
.NOTES 

  
#>
 
[CmdletBinding()]

param (
    [Parameter(Mandatory=$true)]
    [string]$SourceFolder,
    [string]$DestinationFolder
)
function ConvertWordTo-PDF {
    param (
        [string]$SourceDirectory = (Get-Location),
        [string]$DestinationDirectory = (Get-Location)
    )

    $i = 0
 
    $word = New-Object -ComObject word.application 
    $FormatPDF = 17
    $word.visible = $true
    $types = '*.docx','*.doc'
 
    If ((Test-Path $SourceFolder) -eq $false) {
     
    throw "Error. Source Folder $SourceFolder not found." } 
 
    If ((Test-Path $DestinationFolder) -eq $false) {
     
    New-Item -ItemType Directory -Path $DestinationFolder -Force | Out-Null
    }
     
    $files = Get-ChildItem -Path $SourceFolder -Include $Types -Recurse -ErrorAction Stop
    
    Write-Warning "Converting Files to PDF ..."
 
     
    foreach ($f in $files) {
 
        $path = $DestinationFolder + '\' + $f.Name.Substring(0,($f.Name.LastIndexOf('.'))) + '.pdf'
        $doc = $word.documents.open($f.FullName) 
        $doc.saveas([ref] $path,[ref] $FormatPDF) 
        $doc.close()
        Write-Output "$($f.Name)"
        $i++
 
    }
    ''
    Write-Output "$i file(s) converted."
    Start-Sleep -Seconds 2 
    Invoke-Item $DestinationFolder
    $word.Quit()
     
     
}

ConvertWordTo-PDF