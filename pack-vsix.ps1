Param ([Parameter(Mandatory=$true)][string]$version)

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