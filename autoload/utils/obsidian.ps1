# Copy files from Obsidian vault with fuzzy find (like unix cp)
function ocp {
  param (
    [string]$Destination
  )

  if (-Not $Destination) {
    Write-Error "Usage: ocp <destination>"
    return
  }

  $vaultRoot = (obsidian vault info=path).Trim()
  if (-Not $vaultRoot) {
    Write-Error "Could not determine vault path. Is Obsidian running?"
    return
  }

  $rawFiles = obsidian files
  $display = @()
  for ($i = 0; $i -lt $rawFiles.Count; $i++) {
    $display += "{0}: {1}" -f ($i + 1), $rawFiles[$i]
  }

  $tempPaths = [System.IO.Path]::GetTempFileName().Trim()
  $tempPreview = ([System.IO.Path]::GetTempFileName().Trim() -replace '\.tmp$', '.ps1')

  try {
    $rawFiles | Set-Content $tempPaths

    $previewScript = @"
`$idx = if (`$args -is [string]) { [int]`$args - 1 } else { [int]`$args[0] - 1 }
`$lines = Get-Content '$tempPaths'
if (`$idx -ge 0 -and `$idx -lt `$lines.Count) {
  bat --language md --style='plain' --color=always --theme=Nord ('$vaultRoot/' + `$lines[`$idx])
}
"@
    [System.IO.File]::WriteAllText($tempPreview, $previewScript)

    $selected = $display | fzf -m --preview="pwsh -NoProfile -File '$tempPreview' {}"

    if (-Not $selected) {
      return
    }

    $files = ($selected | ForEach-Object { ($_ -split ': ', 2)[1] }) | Where-Object { $_.Trim() -ne '' }

    if ((Test-Path $Destination -PathType Container)) {
      foreach ($file in $files) {
        $source = Join-Path $vaultRoot $file
        $destPath = Join-Path $Destination (Split-Path $file -Leaf)
        Copy-Item $source $destPath
      }
    }
    else {
      $source = Join-Path $vaultRoot $files[0]
      if ($files.Count -gt 1) {
        Write-Error "Destination is not a directory. Only copying the first selected file. ($($files.Count) files were selected)"
      }
      $destDir = Split-Path $Destination -Parent
      if ($destDir -And -Not (Test-Path $destDir)) {
        New-Item -ItemType Directory -Path $destDir -Force | Out-Null
      }
      Copy-Item $source $Destination
    }
  }
  finally {
    Remove-Item $tempPaths -Force -ErrorAction SilentlyContinue
    Remove-Item $tempPreview -Force -ErrorAction SilentlyContinue
  }
}
