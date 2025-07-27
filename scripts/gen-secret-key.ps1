<#
.SYNOPSIS
    Generates a base64-encoded SECRET_KEY for Apache Superset.

.DESCRIPTION
    Creates a strong random 42-byte key encoded in base64.
    Store this key in your Helm values YAML as the Superset SECRET_KEY.

.EXAMPLE
    .\gen-secret-key.ps1
#>

$length = 42

# Generate array of 42 random bytes
$randomBytes = for ($i=0; $i -lt $length; $i++) {
    Get-Random -Minimum 0 -Maximum 256
}

# Convert to byte array and then base64 string
$byteArray = [byte[]]$randomBytes
$secretKey = [Convert]::ToBase64String($byteArray)

Write-Output "Generated Superset SECRET_KEY:"
Write-Output $secretKey
