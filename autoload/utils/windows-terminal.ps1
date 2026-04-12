function quake {
  param (
    [string]$Command = ""
  )

  if (-Not ($Command)) {
    wt -w _quake
    return
  }

  wt -w _quake powershell -Command $Command
}

function qtop {
  quake "btop"
}

function floatingterm {
  param (
    [string]$Command = ""
  )

  if (-Not ($Command)) {
    wt -w floating -f
    return
  }

  wt -w floating -f powershell -Command $Command 
}

function ftop {
  floatingterm "btop"
}

