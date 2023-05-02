function MoveAllSpecifiedExtensionFile {
 
<# 
  
.SYNOPSIS 
 
MoveAllSpecifiedExtensionFile moves all Microsoft Word documents of all types in the specified source folder and its subfolders to a new destination folder. 
  
.DESCRIPTION 
 
The function queries the given source folder including sub-folders to find Word documents of all types, 
and moves all found files to the Destination folder. 
  
.PARAMETER SourceFolder
  
Mandatory. Enter the source folder of your Microsoft Word documents.
  
.PARAMETER DestinationFolder
 
Optional. Enter the Destination folder to move the Word documents to. If you omit this parameter, the Word documents will be moved to a new folder called "Word Documents" in the source folder.
 
.EXAMPLE 
 
MoveAllSpecifiedExtensionFile -SourceFolder "C:\Documents" -DestinationFolder "C:\My Documents"
 
.NOTES 

  
#>
 
[CmdletBinding()]

param (
    [Parameter(Mandatory=$true)]
    [string]$SourceFolder,
    [string]$DestinationFolder
)

function Move-WordDocuments {
    param (
        [string]$SourceDirectory = (Get-Location),
        [string]$DestinationDirectory = (Get-Location)
    )

    # Create the destination directory if it doesn't exist
    if (-not (Test-Path $DestinationDirectory)) {
        New-Item -ItemType Directory -Path $DestinationDirectory | Out-Null
    }

    # Get all the Word documents in the source directory and its subdirectories
    $wordDocuments = Get-ChildItem -Path $SourceDirectory -Recurse -Include *.doc,*.docx | Where-Object { $_.Attributes -notcontains 'Directory' -and $_.Extension -match '^(.doc|.docx)$' }

    # Move the Word documents to the destination directory
    foreach ($document in $wordDocuments) {
        Move-Item $document.FullName -Destination $DestinationDirectory
    }
}

# Call the Move-WordDocuments function to move all Word documents to the destination folder
Move-WordDocuments -SourceDirectory $SourceFolder -DestinationDirectory $DestinationFolder

}

MoveAllSpecifiedExtensionFile