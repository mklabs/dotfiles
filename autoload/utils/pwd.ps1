
# pwd command in pwsh as this annoying output
#
# Path
# ----
# C:\Users\user\Documents\PowerShell
#
# This below only returns the path to stdout, which is more in line with unix pwd behavior
function pwdd { (Get-Item .).FullName }

# to copy cwd to clipboard directly
function pwdc {
  (Get-Item .).FullName | clip
  Write-Output "$(Get-Item .) copied to clipboard"
}
