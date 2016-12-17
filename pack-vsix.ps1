Param ([Parameter(Mandatory=$true)][string]$version)

# Update extension.vsixmanifest
$vsixmanifest = Get-Item ($(get-location).Path + "\UpdateAssemblyInfo\extension.vsixmanifest")
$tmpFile = $vsixmanifest.FullName + ".tmp"

Get-Content $vsixmanifest.FullName -encoding utf8 |
    %{$_ -replace ('<Identity Language="en-US" Id="UpdateAssemblyInfo" Publisher="SebastianLux" Version=".*" />'), ('<Identity Language="en-US" Id="UpdateAssemblyInfo" Publisher="SebastianLux" Version="' + $version + '" />') } |
    Set-Content $tmpFile -encoding utf8
Move-Item $tmpFile $vsixmanifest.FullName -force

# Update task.json
$splitVersion = $version -split '.', 0, "simplematch"
$taskdotjson = Get-Item ($(get-location).Path + "\UpdateAssemblyInfo\UpdateAssemblyInfoTask\task.json")
$tmpFile = $taskdotjson.FullName + ".tmp"
Get-Content $taskdotjson.FullName -encoding utf8 |
    %{$_ -replace ('"Major":  .*,'), ('"Major":  ' + $splitVersion[0] + ',')} |
    %{$_ -replace ('"Minor":  .*,'), ('"Minor":  ' + $splitVersion[1] + ',')} |
    %{$_ -replace ('"Patch":  .*'), ('"Patch":  ' + $splitVersion[2])} |
    Set-Content $tmpFile -encoding utf8
Move-Item $tmpFile $taskdotjson.FullName -force

# Create vsix package
Add-Type -Assembly "System.IO.Compression.FileSystem" ;

$tmpPath = $env:temp + "\UpdateAssemblyInfo\";
$zipFilePath = $(get-location).Path + "\UpdateAssemblyInfo-" + $version + ".vsix"

if(Test-Path $tmpPath)
{
    Remove-Item $tmpPath -recurse
}

New-Item $tmpPath -type directory
Copy-Item ($(get-location).Path + "\readme.md") $tmpPath
Copy-Item ($(get-location).Path + "\UpdateAssemblyInfo\*") $tmpPath -recurse

[System.IO.Compression.ZipFile]::CreateFromDirectory($tmpPath, $zipFilePath) ;

if(Test-Path $tmpPath)
{
    Remove-Item $tmpPath -recurse
}