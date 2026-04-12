# Touch like command
function touch {
    param (
        [string]$Path
    )

    if (-Not (Test-Path $Path)) {
        # Create a new file if it doesn't exist
        New-Item -Path $Path -ItemType File -Force | Out-Null
    } else {
        # Update the last write time of the existing file
        (Get-Item $Path).LastWriteTime = Get-Date
    }
}

