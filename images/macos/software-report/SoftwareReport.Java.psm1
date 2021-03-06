function Get-JavaVersions {
    $defaultJavaPath = Get-Item env:JAVA_HOME
    $javaVersions = Get-Item env:JAVA_HOME_*_X64
    $sortRules = @{
        Expression = { [Int32]$_.Name.Split("_")[2] }  
        Descending = $false
    }

    return $javaVersions | Sort-Object $sortRules | ForEach-Object {
        $javaPath = $_.Value
        # Take semver from the java path
        $version = $javaPath.split('/')[5]
        $defaultPostfix = ($javaPath -eq $defaultJavaPath) ? " (default)" : ""

        [PSCustomObject] @{
            "Version" = $version + $defaultPostfix
            "Vendor" = "Adopt OpenJDK"
            "Environment Variable" = $_.Name
        }
    }
}