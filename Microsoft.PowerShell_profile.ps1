
$bUseDebug = (-not [string]::IsNullOrEmpty($env:DEBUG_PWSH))

$Directories = @(
  'autoload/init'
  'autoload/completions'
  'autoload/utils'
  'autoload/after'
)

foreach ($Dir in $Directories) {
  Get-ChildItem $PSScriptRoot/$Dir | ForEach-Object { 
    $AbsolutePath = (Resolve-Path $_).Path

    # no DEBUG_PWSH environment variable set
    if (-not $bUseDebug) {
      . $AbsolutePath
      return
    }

    # with DEBUG_PWSH environment variable set
    $sw = [System.Diagnostics.Stopwatch]::StartNew()
    . $AbsolutePath
    $sw.Stop()

    # show milliseconds with 3 decimal places
    $ms = '{0:N3}' -f ($sw.Elapsed.TotalMilliseconds)
    echo "... Loaded $AbsolutePath in $ms ms"
  }
}

# Simpler one line version (but does not display debug info with $DEBUG_PWSH env variable)
#
# Get-ChildItem $PSScriptRoot/autoload/init | ForEach-Object { . (Resolve-Path $_).Path }
# Get-ChildItem $PSScriptRoot/autoload/completions | ForEach-Object { . (Resolve-Path $_).Path }
# Get-ChildItem $PSScriptRoot/autoload/utils | ForEach-Object { . (Resolve-Path $_).Path }
# Get-ChildItem $PSScriptRoot/autoload/after | ForEach-Object { . (Resolve-Path $_).Path }
