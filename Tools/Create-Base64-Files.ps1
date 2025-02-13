param (
    # Specify a comma-separated list of files you want to convert to Base64
    [string]$FilePaths = "C:\PowerShell\config.txt,C:\PowerShell\setup.cer,C:\PowerShell\setup.msi"
)

# Convert the comma-separated list to an array
$filePathsArray = $FilePaths.Split(',')

# Loop through each file in the list
foreach ($filePath in $filePathsArray) {
    # Check if the file exists
    if (-not (Test-Path -Path $filePath)) {
        Write-Error "The specified file '$filePath' does not exist."
        continue
    }

    try {
        # Read the file and encode it to Base64
        $fileContent = Get-Content -Path $filePath -Encoding Byte
        $base64Content = [Convert]::ToBase64String($fileContent)

        # Create an output file name by adding .B64.txt to the original file name
        $outputFile = "$($filePath).B64.txt"

        # Write the Base64 content to the output file
        Set-Content -Path $outputFile -Value $base64Content -Force

        Write-Host "Base64 encoding for '$filePath' completed successfully."
        Write-Host "Encoded file saved to: $outputFile"
    } catch {
        Write-Error "An error occurred during the encoding process for '$filePath': $_"
    }
}
