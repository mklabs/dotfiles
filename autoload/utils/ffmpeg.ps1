# ffmpeg helpers — OBS MKV -> share-friendly MP4
# https://ffmpeg.org
#
# ffc converts the newest recording in W:\Media\OBS\<yyyy-MM> to an H.264 MP4
# that plays anywhere (Discord, browsers, phones):
#
#   - HDR (PQ/HLG, BT.2020) is tone-mapped to SDR BT.709 via zscale + tonemap
#   - always 8-bit yuv420p / High profile — never Hi10P, which Discord can't decode
#   - two-pass encode sized to fit --max-size (default 10 MB, Discord free tier)
#   - +faststart, so the moov atom sits at the front for streaming previews
#   - audio is always stripped unless --audio is passed
#   - sources wider than 1920 are scaled down to 1920
#
# Flags: --name N  --output P  --list  --fuzzy  --audio  --max-size MB  --crf N
function ffc {
  $OBSRoot = "W:\Media\OBS"
  $DefaultMaxSizeMB = 10

  $Name = $null
  $Output = $null
  $List = $false
  $Fuzzy = $false
  $KeepAudio = $false
  $MaxSizeMB = [double]$DefaultMaxSizeMB
  $Crf = $null

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
      '--audio' { $KeepAudio = $true }
      '--max-size' {
        $i++
        if ($i -ge $args.Count) { Write-Error "--max-size requires a value in MB"; return }
        if (-not [double]::TryParse($args[$i], [ref]$MaxSizeMB)) {
          Write-Error "--max-size must be a number (MB)"
          return
        }
        if ($MaxSizeMB -le 0) { Write-Error "--max-size must be greater than 0"; return }
      }
      '--crf' {
        $i++
        if ($i -ge $args.Count) { Write-Error "--crf requires a value"; return }
        $crfValue = 0
        if (-not [int]::TryParse($args[$i], [ref]$crfValue)) {
          Write-Error "--crf must be an integer"
          return
        }
        if ($crfValue -lt 0 -or $crfValue -gt 51) { Write-Error "--crf must be between 0 and 51"; return }
        $Crf = $crfValue
      }
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

  $mkvFiles = @(Get-ChildItem "$monthDir\*.mkv" | Sort-Object LastWriteTime -Descending)

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

  foreach ($bin in 'ffmpeg', 'ffprobe') {
    if (-not (Get-Command $bin -ErrorAction SilentlyContinue)) {
      Write-Error "$bin is not available"
      return
    }
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

  # Probe once: colour metadata decides the filter chain, duration decides the budget.
  $probeEntries = "stream=codec_type,width,height,r_frame_rate,color_range,color_transfer,color_primaries:format=duration"
  $probeJson = (& ffprobe -v error -show_entries $probeEntries -of json $inputFile.FullName 2>$null) -join "`n"
  if ($LASTEXITCODE -ne 0 -or -not $probeJson) {
    Write-Error "ffprobe failed on $($inputFile.Name)"
    return
  }
  $probe = $probeJson | ConvertFrom-Json

  $videoStream = @($probe.streams | Where-Object { $_.codec_type -eq 'video' }) | Select-Object -First 1
  if (-not $videoStream) {
    Write-Error "No video stream found in $($inputFile.Name)"
    return
  }
  $hasAudio = @($probe.streams | Where-Object { $_.codec_type -eq 'audio' }).Count -gt 0

  $duration = 0.0
  if ($probe.format -and $probe.format.duration) { $duration = [double]$probe.format.duration }

  $fps = 0.0
  if ($videoStream.r_frame_rate -match '^(\d+)/(\d+)$' -and [int]$matches[2] -gt 0) {
    $fps = [int]$matches[1] / [int]$matches[2]
  }

  $isHdr = $videoStream.color_transfer -in @('smpte2084', 'arib-std67')
  $isWideGamut = $videoStream.color_primaries -eq 'bt2020'
  $isFullRange = $videoStream.color_range -eq 'pc'

  # Build the filter chain. Only pay for the tonemap round-trip when the source needs it.
  $filters = @()
  if ($isHdr) {
    $filters += 'zscale=t=linear:npl=100', 'format=gbrpf32le', 'zscale=p=bt709'
    $filters += 'tonemap=tonemap=hable:desat=0'
    $filters += 'zscale=t=bt709:m=bt709:r=tv'
    $colorMode = "HDR ($($videoStream.color_transfer)) -> SDR BT.709, tonemap=hable"
  } elseif ($isWideGamut -or $isFullRange) {
    # zscale needs explicit input properties: an untagged SDR file (common for OBS)
    # otherwise fails with "no path between colorspaces".
    $inPrimaries = if ($videoStream.color_primaries -and $videoStream.color_primaries -ne 'unknown') { $videoStream.color_primaries } else { 'bt709' }
    $inTransfer = if ($videoStream.color_transfer -and $videoStream.color_transfer -ne 'unknown') { $videoStream.color_transfer } else { 'bt709' }
    $inRange = if ($isFullRange) { 'pc' } else { 'tv' }
    $filters += "zscale=pin=$inPrimaries`:tin=$inTransfer`:rin=$inRange`:p=bt709:t=bt709:m=bt709:r=tv"
    $colorMode = 'SDR -> BT.709 (range/gamut normalised)'
  } else {
    $colorMode = 'SDR BT.709 (passthrough)'
  }
  if ($videoStream.width -gt 1920) { $filters += "scale='min(1920,iw)':-2" }
  $filters += 'format=yuv420p'
  $vf = $filters -join ','

  $gop = if ($fps -gt 0) { [int][math]::Round($fps * 2) } else { 120 }
  if ($gop -lt 48) { $gop = 48 }

  # Level 4.2 only covers 1080p60 — omit it for anything wider/faster and let x264 choose.
  $effectiveWidth = [math]::Min([int]$videoStream.width, 1920)
  $useLevel = ($effectiveWidth -le 1920 -and ($fps -le 0 -or $fps -le 60))

  $audioKbps = if ($KeepAudio -and $hasAudio) { 160 } else { 0 }

  # Budget in decimal MB, minus 2% for container/framing overhead.
  $useBitrate = $null -eq $Crf
  $videoKbps = 0
  if ($useBitrate) {
    if ($duration -le 0) {
      Write-Error "Could not read duration from $($inputFile.Name); use --crf instead of --max-size"
      return
    }
    $totalKbps = [math]::Floor(($MaxSizeMB * 8000) / $duration)
    $videoKbps = [math]::Floor(($totalKbps - $audioKbps) * 0.98)
    if ($videoKbps -gt 8000) {
      $Crf = 20
      $useBitrate = $false
      Write-Warning "Budget allows ${totalKbps}k — capped at 8000k, using --crf 20 instead"
    } elseif ($videoKbps -lt 150) {
      Write-Error "A $MaxSizeMB MB target leaves only ${videoKbps}k for $([math]::Round($duration))s of video; raise --max-size or use --crf"
      return
    }
  }

  $common = @(
    '-hide_banner', '-y', '-i', $inputFile.FullName,
    '-map', '0:v:0',
    '-vf', $vf,
    '-c:v', 'libx264', '-profile:v', 'high', '-pix_fmt', 'yuv420p',
    '-preset', 'slow', '-g', "$gop"
  )
  if ($useLevel) { $common += @('-level', '4.2') }
  if ($useBitrate) {
    $maxRate = [int]($videoKbps * 1.5)
    $bufSize = [int]($videoKbps * 2)
    $common += @('-b:v', "${videoKbps}k", '-maxrate', "${maxRate}k", '-bufsize', "${bufSize}k")
  } else {
    $common += @('-crf', "$Crf")
  }

  $colorArgs = @('-colorspace', 'bt709', '-color_primaries', 'bt709', '-color_trc', 'bt709', '-color_range', 'tv')
  $audioArgs = @()
  if ($KeepAudio -and $hasAudio) {
    $audioArgs = @('-map', '0:a:0', '-c:a', 'aac', '-b:a', '160k', '-ac', '2')
  }

  $logBase = Join-Path $env:TEMP "ffc-pass-$([guid]::NewGuid().ToString('N'))"
  $stopwatch = [System.Diagnostics.Stopwatch]::StartNew()

  try {
    if ($useBitrate) {
      $pass1 = $common + @('-an', '-pass', '1', '-passlogfile', $logBase, '-f', 'null', 'NUL')
      & ffmpeg @pass1
      if ($LASTEXITCODE -ne 0) { Write-Error "ffmpeg pass 1 failed"; return }

      $pass2 = $common + $audioArgs + $colorArgs + @(
        '-pass', '2', '-passlogfile', $logBase, '-movflags', '+faststart', $outputPath
      )
      & ffmpeg @pass2
    } else {
      $pass1 = $common + $audioArgs + $colorArgs + @('-movflags', '+faststart', $outputPath)
      & ffmpeg @pass1
    }
    if ($LASTEXITCODE -ne 0) { Write-Error "ffmpeg failed"; return }
  } finally {
    $stopwatch.Stop()
    Remove-Item "$logBase*" -Force -ErrorAction SilentlyContinue
  }

  $outFile = Get-Item -LiteralPath $outputPath -ErrorAction SilentlyContinue
  if (-not $outFile) {
    Write-Error "Output not found: $outputPath"
    return
  }

  $sizeMB = [math]::Round($outFile.Length / 1MB, 2)
  $audioLabel = if ($KeepAudio -and $hasAudio) { 'aac 160k stereo' } else { 'stripped' }
  $rateLabel = if ($useBitrate) { "${videoKbps}k two-pass" } else { "crf $Crf" }

  Write-Host ""
  Write-Host "$($inputFile.Name) -> $($outFile.Name)"
  Write-Host "  colour : $colorMode"
  Write-Host "  video  : h264 high, yuv420p, $($videoStream.width)x$($videoStream.height) @ $([math]::Round($fps)) fps, $rateLabel"
  Write-Host "  audio  : $audioLabel"
  Write-Host "  size   : $sizeMB MB (limit $MaxSizeMB MB), faststart on, $([math]::Round($stopwatch.Elapsed.TotalSeconds))s"
}
