[CmdletBinding()]
param (
    [Parameter(mandatory=$true)][string]$File,
    [Parameter(mandatory=$true)][string]$Destination
)
$ErrorActionPreference = "Stop" # stop execution if any errors occur.

if(Test-Path ($Destination + (Split-Path $File -leaf))) { Write-Error "A file named $(Split-Path $File -leaf) already exists in $destination." }    # check if file already exists

$archivedFile = Copy-Item -Path $File -Destination "$destination" -PassThru   # perform the copy; store the result path in $archivedFile. -PassThru makes Copy-Item produce output to store in $archivedFile
if(Test-Path "$archivedFile") {   # test if copied file now exists
    Write-Host "Successfully copied $File into $destination" -ForegroundColor green # confirmation message
    Remove-Item -Path $File -Confirm    # prompt to delete original
}
else { Write-Error "Copy not found in $destination after copy operation. The original file still exists at $file." }