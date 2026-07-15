# ffmpeg helpers
function ffc {
  $OBSRoot = "W:\Media\OBS"

  $Name = $null
  $Output = $null
  $List = $false
  $Fuzzy = $false

  for ($i = 0; $i -lt $args.Count; $i++) {
    switch ($args[$i]) {
      '--name' {
        $i++
        if ($i -ge $args.Count) { Write-Error "--name requires a value"; return }
        $Name = $args[$i]
      }
      '--output' {
        $i++
        if ($i -ge $args.Count) { Write-Error "--output requires a value"; return }
        $Output = $args[$i]
      }
      '--list' { $List = $true }
      '--fuzzy' { $Fuzzy = $true }
      default { Write-Error "Unknown flag: $($args[$i])"; return }
    }
  }

  if (-not (Test-Path $OBSRoot)) {
    Write-Error "OBS root not found: $OBSRoot"
    return
  }

  $monthDir = Join-Path $OBSRoot (Get-Date -Format "yyyy-MM")

  if (-not (Test-Path $monthDir)) {
    Write-Error "Month directory not found: $monthDir"
    return
  }

  $mkvFiles = Get-ChildItem "$monthDir\*.mkv" | Sort-Object LastWriteTime -Descending

  if ($mkvFiles.Count -eq 0) {
    Write-Error "No .mkv files found in $monthDir"
    return
  }

  if ($List) {
    eza -a --color=always --long --git -- $mkvFiles.FullName
    return
  }

  if ($Fuzzy) {
    if (-not (Get-Command fzf -ErrorAction SilentlyContinue)) {
      Write-Error "fzf is required for --fuzzy"
      return
    }
    $selected = $mkvFiles.Name | fzf
    if (-not $selected) { return }
    $inputFile = $mkvFiles | Where-Object { $_.Name -eq $selected } | Select-Object -First 1
  } else {
    $inputFile = $mkvFiles | Select-Object -First 1
  }

  if (-not (Get-Command ffmpeg -ErrorAction SilentlyContinue)) {
    Write-Error "ffmpeg is not available"
    return
  }

  $inputStem = [System.IO.Path]::GetFileNameWithoutExtension($inputFile.Name)
  $outputStem = if ($Name) { $Name } else { $inputStem }

  if ($Output) {
    $lastChar = $Output[-1]
    $outputIsDir = $lastChar -eq '\' -or $lastChar -eq '/' -or (Test-Path -LiteralPath $Output -PathType Container)
    $outputPath = if ($outputIsDir) { Join-Path $Output "$outputStem.mp4" } else { $Output }
  } else {
    $outputPath = Join-Path $monthDir "$outputStem.mp4"
  }

  $outputParent = Split-Path $outputPath -Parent
  if ($outputParent -and -not (Test-Path $outputParent)) {
    New-Item -ItemType Directory -Path $outputParent -Force | Out-Null
  }

  ffmpeg -i $inputFile.FullName -an $outputPath
}
