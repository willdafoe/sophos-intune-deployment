<#
.SYNOPSIS
Function runs the Intune WinApp utility with input and output folders specified, and runs the tool silently.
.DESCRIPTION
<place-holder>
.PARAMETER SetupFile
Path to the Setup file for the application to be deployed with inTune.
.PARAMETER InputFolder
Path to the input folder that contains the necessary files for the .intunewin package
.PARAMETER OutputFolder
Path to the output folder that will contain the resulting .intunewin package
.EXAMPLE
Create-IntuneWinPackage -IntuneWinappPath .\IntuneWinAppUtil.exe -InputPath .\input -OutputPath .\output
.NOTES
<place holder>
.LINK
<place holder: advanced function help>
.LINK
<place holder: comment based help>
#>
[CmdletBinding()]
param(
    [ValidateNotNullOrEmpty()]
    [Parameter(Mandatory=$true,HelpMessage="The path to the installation file to use for the intune deployment.")][String]$SetupFile,
    [ValidateNotNullOrEmpty()]
    [Parameter(Mandatory=$true,HelpMessage="The path to the input directory that contains the files needed to create the .intunewin package")][String]$InputFolder,
    [ValidateNotNullOrEmpty()]
    [Parameter(Mandatory=$false,HelpMessage="The path to the output directory the will contain the resulting .intunewin package")][String]$OutputFolder="$(Split-path -Path $InputFolder -Parent)\_Output\$(Split-path -Path $InputFolder -Leaf)"
)

If ( -not (Test-Path -Path "$InputFolder")){
    throw "Cannot find source folder: [$InputFolder]"
    return
}

If ( -not (Test-Path -Path "$InputFolder\$SetupFile")){
    throw "Cannot find setupfile: [$SetupFile]"
    return
}

If ( -not (Test-Path -Path "$OutputFolder")){
    New-Item -Path $OutputFolder -ItemType Directory -Force | Out-Null
}

If ( -not (Test-Path -Path "$PSScriptRoot\IntuneWinAppUtil.exe")){
    throw "Cannot find IntuneWinAppUtil.exe at: [$PSScriptRoot]"
    return
}


Start-Process -FilePath "$PSScriptRoot\IntuneWinAppUtil.exe" -ArgumentList "-c $InputFolder -s $SetupFile -o $OutputFolder -q" -Wait

$SetupFilePath=(Get-Item -Path "$InputFolder\$SetupFile").FullName
$fileNameOnly=[System.IO.Path]::GetFileNameWithoutExtension($SetupFilePath)
$intunewinfile = $("$fileNameOnly.intunewin")

If (Test-Path -Path "$OutputFolder\$intunewinfile") {
    Write-Output -InputObject "[$intunewinfile] file successfully created"
} else {
    throw "File [$intunewinfile] not created"
    return
}
