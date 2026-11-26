# listening.ps1 — list processes and their listening ports
#
# listening — Lists processes with their listening ports. By default restricts
#             to loopback addresses only (127.0.0.1 / ::1) — useful for spotting
#             dev-server style processes (node, etc.). With -All, lists ALL
#             listeners.
# pk        — fzf-select a listening process and kill it after a Y/n confirm.

function listening-rows {
  param(
    [switch]$All
  )

  $conns = Get-NetTCPConnection -State Listen
  if (-not $All) {
    $conns = $conns | Where-Object { $_.LocalAddress -in @('127.0.0.1', '::1') }
  }

  foreach ($c in $conns) {
    $p = Get-Process -Id $c.OwningProcess -ErrorAction SilentlyContinue
    [pscustomobject]@{
      Port    = $c.LocalPort
      Address = $c.LocalAddress
      PID     = $c.OwningProcess
      Process = $p.ProcessName
    }
  }
}

function listening {
  param(
    [switch]$All
  )

  listening-rows -All:$All | Sort-Object Process, Port
}

function pk {
  param(
    [switch]$All
  )

  if (-not (Get-Command fzf -ErrorAction SilentlyContinue)) {
    Write-Error "fzf is required for pk"
    return
  }

  $rows = @(listening-rows -All:$All)
  if ($rows.Count -eq 0) {
    Write-Error "No listening processes found."
    return
  }

  $map = @{}
  $lines = foreach ($r in $rows) {
    $line = '{0,-6} {1,-14} {2,-8} {3}' -f $r.Port, $r.Address, $r.PID, $r.Process
    $map[$line] = $r
    $line
  }

  $fzfArgs = @('--layout=reverse', '--border', '--height=40%', '--inline-info')
  $selected = $lines | fzf @fzfArgs
  if (-not $selected) { return }

  $row = $map[$selected]
  $ans = Read-Host "Kill $($row.Process) (PID $($row.PID), port $($row.Port))? [Y/n]"
  if ($ans -match '^[nN]$') { return }

  Stop-Process -Id $row.PID
  Write-Output "Killed $($row.Process) (PID $($row.PID))."
}