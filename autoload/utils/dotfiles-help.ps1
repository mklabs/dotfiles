# dotfiles-command — render COMMANDS.md via glow
# dotfiles-help — compact command list parsed from COMMANDS.md
# https://github.com/charmbracelet/glow
function dotfiles-command {
  glow "$PSScriptRoot\..\..\COMMANDS.md"
}

function dotfiles-help {
  param(
    [switch]$Category
  )

  $md = "$PSScriptRoot\..\..\COMMANDS.md"

  $rows = [System.Collections.Generic.List[object]]::new()
  $section = $null
  $cols = $null

  foreach ($line in Get-Content -LiteralPath $md) {
    if ($line -match '^##\s+(.+)$') {
      $section = $matches[1].Trim()
      $cols = $null
      continue
    }
    if ($line -notmatch '^\s*\|') { continue }

    $cells = ($line -replace '\\\|', '¶').Trim('|') -split '\|' | ForEach-Object {
      ($_.Trim() -replace '[`*]', '' -replace '¶', '|')
    }

    if ($cells.Count -lt 2 -or $cells[0] -match '^-+$') { continue }

    if ($cells[0] -in @('Command', 'Alias', 'Binding')) {
      $cols = $cells
      continue
    }

    if (-not $cols -or $cols[1] -notin @('Description', 'Target')) { continue }

    $desc = if ($cols[1] -eq 'Target') { "alias for $($cells[1])" } else { $cells[1] }
    $rows.Add([pscustomobject]@{ Section = $section; Name = $cells[0]; Description = $desc })
  }

  $maxLen = 0
  foreach ($r in $rows) { if ($r.Name.Length -gt $maxLen) { $maxLen = $r.Name.Length } }
  $pad = $maxLen + 3

  Write-Output "Usage: dotfiles-help [-c]   (full docs: dotfiles-command)"
  Write-Output ""

  if ($Category) {
    $current = $null
    $first = $true
    foreach ($r in $rows) {
      if ($r.Section -ne $current) {
        $current = $r.Section
        if (-not $first) { Write-Output "" }
        $first = $false
        Write-Output $current
      }
      Write-Output ("  {0,-$pad}{1}" -f $r.Name, $r.Description)
    }
  } else {
    Write-Output "Commands:"
    Write-Output ""
    $seen = [System.Collections.Generic.HashSet[string]]::new([System.StringComparer]::OrdinalIgnoreCase)
    foreach ($r in $rows) {
      if (-not $seen.Add(($r.Name -split '\s')[0])) { continue }
      Write-Output ("  {0,-$pad}{1}" -f $r.Name, $r.Description)
    }
  }
}