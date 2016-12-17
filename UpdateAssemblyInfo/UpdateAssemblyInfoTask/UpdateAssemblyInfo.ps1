Param (
    [string]$rootFolder = $(get-location).Path,
    [string]$filePattern,
    [string]$assemblyProduct,
    [string]$assemblyCopyright,
    [string]$assemblyCompany,
    [string]$assemblyTrademark,
    [string]$assemblyConfiguration,
    [string]$assemblyVersion, 
    [string]$assemblyFileVersion, 
    [string]$assemblyInformationalVersion
)

# Write all params to the console.
Write-Host ("Root folder: " + $rootFolder)
Write-Host ("File pattern: " + $filePattern)
Write-Host ("Product: " + $assemblyProduct)
Write-Host ("Copyright: " + $assemblyCopyright)
Write-Host ("Company: " + $assemblyCompany)
Write-Host ("Trademark: " + $assemblyTrademark)
Write-Host ("Configuration: " + $assemblyConfiguration)
Write-Host ("Version: " + $assemblyVersion)
Write-Host ("File version: " + $assemblyFileVersion)
Write-Host ("InformationalVersion: " + $assemblyInformationalVersion)

function UpdateAssemblyInfo()
{
    foreach ($file in $input) 
    {
        Write-Host ($file.FullName)
        $tmpFile = $file.FullName + ".tmp"

        $fileContent = Get-Content $file.FullName -encoding utf8

        $fileContent = TryReplace "AssemblyProduct" $assemblyProduct;
        $fileContent = TryReplace "AssemblyCopyright" $assemblyCopyright;
        $fileContent = TryReplace "AssemblyCompany" $assemblyCompany;
        $fileContent = TryReplace "AssemblyTrademark" $assemblyTrademark;
        $fileContent = TryReplace "AssemblyConfiguration" $assemblyConfiguration;
        $fileContent = TryReplace "AssemblyVersion" $assemblyVersion;
        $fileContent = TryReplace "AssemblyFileVersion" $assemblyFileVersion;
        $fileContent = TryReplace "AssemblyInformationalVersion" $assemblyInformationalVersion;
        
        Set-Content $tmpFile -value $fileContent -encoding utf8
    
        Move-Item $tmpFile $file.FullName -force
    }
}

function TryReplace($attributeName, $value)
{
    if($value)
    {
        $attribute = $attributeName + '("' + $value + '")';
        $fileContent = $fileContent -replace ($attributeName +'\(".*"\)'), $attribute
    }

    return $fileContent
}

function ValidateVersionString($versionString)
{
    $versionStringRegex= [System.Text.RegularExpressions.Regex]::Match($versionString, "^[0-9]+(\.[0-9]+){1,3}$");

    return $versionStringRegex.Success;
}

function ValidateParams()
{
    if($assemblyVersion -and (-not (ValidateVersionString $assemblyVersion)))
    {
        Write-Host ("'$assemblyVersion' is not a valid parameter for attribute 'AssemblyVersion'")
        return $false
    }

    if($assemblyFileVersion -and (-not (ValidateVersionString $assemblyFileVersion)))
    {
        Write-Host ("'$assemblyFileVersion' is not a valid parameter for attribute 'AssemblyFileVersion'")
        return $false
    }

    return $true
 }

if(ValidateParams)
{
    Write-Host ("Updating all files recursive...")
    Get-Childitem -Path $rootFolder -recurse |? {$_.Name -like $filePattern} | UpdateAssemblyInfo; 
}