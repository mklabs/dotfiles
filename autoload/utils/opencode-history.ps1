# opencode-history.ps1 — search opencode prompt history with fzf
#
# OpenCode stores the TUI prompt input history (up/down arrow) as JSONL in:
#
#   ~/.local/state/opencode/prompt-history.jsonl
#   ($XDG_STATE_HOME/opencode/prompt-history.jsonl, with a
#   %LOCALAPPDATA%\opencode fallback on older setups)
#
# Each line is one JSON object: { "input": "...", "mode": "normal|shell",
# "parts": [...] }. Newest entries are appended last, capped at 50.
#
# Functions:
#
# och   — Standalone: fuzzy-search past opencode prompts with fzf and print the
#         selected prompt to stdout. `-Copy` copies it to the clipboard.
#         `-Query <text>` seeds the fzf query. `-NoShell` hides shell-mode
#         entries.
#
# Invoke-FzfOpencodeHistory — PSReadLine handler: opens fzf over past prompts,
#         prefilled with the current input, and replaces the buffer with the
#         selected prompt. Bound to Ctrl+O (like Ctrl+R for shell history).

function Get-OpencodeHistoryPath {
  $candidates = @()
  if ($env:XDG_STATE_HOME) { $candidates += Join-Path $env:XDG_STATE_HOME "opencode\prompt-history.jsonl" }
  $candidates += Join-Path $HOME ".local\state\opencode\prompt-history.jsonl"
  if ($env:LOCALAPPDATA) { $candidates += Join-Path $env:LOCALAPPDATA "opencode\prompt-history.jsonl" }

  foreach ($candidate in $candidates) {
    if (Test-Path -LiteralPath $candidate) { return $candidate }
  }
  return $null
}

function Get-OpencodeHistory {
  [CmdletBinding()]
  param(
    [switch]$ExcludeShell
  )

  $path = Get-OpencodeHistoryPath
  if (-not $path) { return }

  $entries = @(Get-Content -LiteralPath $path -Encoding utf8 | ForEach-Object {
    try { $_ | ConvertFrom-Json } catch { $null }
  })

  $result = [System.Collections.Generic.List[object]]::new()
  $previous = $null
  for ($i = $entries.Count - 1; $i -ge 0; $i--) {
    $entry = $entries[$i]
    if (-not $entry -or [string]::IsNullOrWhiteSpace($entry.input)) { continue }
    if ($ExcludeShell -and $entry.mode -eq "shell") { continue }
    if ($entry.input -eq $previous) { continue }
    $previous = $entry.input
    $result.Add([pscustomobject]@{ Input = $entry.input; Mode = $entry.mode })
  }

  $result
}

function Get-OpencodeHistorySpaceBelow {
  $windowHeight = [Console]::WindowHeight
  $windowTop = [Console]::WindowTop
  $cursorY = [Console]::CursorTop
  $windowHeight - ($cursorY - $windowTop)
}

function Invoke-FzfOpencodeHistory {
  <#
  .SYNOPSIS
    Fuzzy-search opencode prompt history with fzf and replace the current input.
  #>
  [CmdletBinding()]
  param()

  $line = $null
  $cursor = $null
  [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)
  $currentPrompt = $line.Substring(0, $cursor)

  $entries = Get-OpencodeHistory
  if ($entries.Count -eq 0) { return }

  try {
    $originalPromptY = [Console]::CursorTop
    $savedCursorX = [Console]::CursorLeft

    # skip a line to make room for fzf's UI
    [Console]::WriteLine()

    $spaceBelow = Get-OpencodeHistorySpaceBelow
    $minHeight = 15
    $scrollLines = 0
    if ($spaceBelow -lt $minHeight) {
      $scrollLines = $minHeight - $spaceBelow
    }

    # Use .NET Process for explicit stream control so stdin feeds the entries,
    # stdout is captured, and the fzf TUI renders to the console (stderr).
    $psi = New-Object System.Diagnostics.ProcessStartInfo
    $psi.FileName = "fzf"
    $psi.UseShellExecute = $false
    $psi.RedirectStandardOutput = $true
    $psi.RedirectStandardError = $false
    $psi.RedirectStandardInput = $true
    $psi.StandardOutputEncoding = [System.Text.Encoding]::UTF8
    $psi.StandardInputEncoding = [System.Text.Encoding]::UTF8
    $psi.WorkingDirectory = $PWD.Path
    $psi.ArgumentList.Add('--layout=reverse')
    $psi.ArgumentList.Add('--border')
    $psi.ArgumentList.Add('--height=40%')
    $psi.ArgumentList.Add('--inline-info')
    $psi.ArgumentList.Add('--bind=ctrl-r:toggle-sort')
    $psi.ArgumentList.Add('--query')
    $psi.ArgumentList.Add($currentPrompt)

    $process = New-Object System.Diagnostics.Process
    $process.StartInfo = $psi
    $process.Start() | Out-Null

    $stdin = $process.StandardInput
    foreach ($entry in $entries) { $stdin.WriteLine($entry.Input) }
    $stdin.Close()

    $output = $process.StandardOutput.ReadToEnd().Trim()
    $process.WaitForExit()

    # Restore cursor to original position
    [Console]::CursorTop = $originalPromptY - $scrollLines
    [Console]::CursorLeft = $savedCursorX

    if ($output) {
      # Replace entire line with the selected prompt
      [Microsoft.PowerShell.PSConsoleReadLine]::Replace(0, $line.Length, $output)
    }
  }
  catch {
    Write-Debug "Opencode history fzf failed: $_"
  }
}

function och {
  <#
  .SYNOPSIS
    Fuzzy-search opencode prompt history with fzf.
  .PARAMETER Query
    Seed the fzf query.
  .PARAMETER Copy
    Copy the selected prompt to the clipboard instead of printing it.
  .PARAMETER NoShell
    Hide shell-mode entries (started with `!`).
  #>
  [CmdletBinding()]
  param(
    [string]$Query,
    [switch]$Copy,
    [switch]$NoShell
  )

  $entries = Get-OpencodeHistory -ExcludeShell:$NoShell
  if ($entries.Count -eq 0) {
    Write-Error "No opencode prompt history found."
    return
  }

  $fzfArgs = @('--layout=reverse', '--border', '--height=40%', '--inline-info', '--bind=ctrl-r:toggle-sort')
  if ($Query) { $fzfArgs += "--query=$Query" }

  $selected = $entries.Input | fzf @fzfArgs
  if (-not $selected) { return }

  if ($Copy) {
    $selected | Set-Clipboard
    Write-Host "Copied to clipboard:"
  }
  $selected
}

# Bind Ctrl+O to fuzzy-search opencode prompts (like Ctrl+R for shell history)
Set-PSReadLineKeyHandler -Chord 'Ctrl+O' -ScriptBlock {
  Invoke-FzfOpencodeHistory
}