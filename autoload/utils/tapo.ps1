
function tapo {
  param (
    [string]$Device = ""
  )

  $Light_ip = "192.168.0.133"
  $Tv_ip = "192.168.0.153"

  $Target = ($Device -eq "light") ? "$Light_ip" : 
    ($Device -eq "tv") ? "$Tv_ip" : 
    ""

  if (-Not $Target) {
    echo "❌ Invalid device target. You must specify either light or tv as a first argument."
    return
  }

  $Args = $args -join " "
  $username = $env:KASA_USERNAME
  $password = $env:KASA_PASSWORD
  
  if (-Not $username -or -Not $password) {
    Write-Error "KASA_USERNAME and KASA_PASSWORD environment variables are required. Set them in your shell profile or PowerShell session."
    return
  }
  
  kasa --username $username --password $password --host $target $args
}

function tapojson {
  param (
    [string]$Device = ""
  )

  $Light_ip = "192.168.0.133"
  $Tv_ip = "192.168.0.153"

  $Target = ($Device -eq "light") ? "$Light_ip" : 
    ($Device -eq "tv") ? "$Tv_ip" : 
    ""

  if (-Not $Target) {
    echo "❌ Invalid device target. You must specify either light or tv as a first argument."
    return
  }

  $Args = $args -join " "
  $username = $env:KASA_USERNAME
  $password = $env:KASA_PASSWORD
  
  if (-Not $username -or -Not $password) {
    Write-Error "KASA_USERNAME and KASA_PASSWORD environment variables are required. Set them in your shell profile or PowerShell session."
    return
  }
  
  kasa --json --username $username --password $password --host $target $Args
}

function bulb {
  param (
    [string]$Command = ""
  )

  $Light_ip = "192.168.0.133"

  if ($Command -eq "") {
    # echo "❌ Invalid `$Command parameter."
    tapo light toggle
    return
  }

  if ($Command -eq "state") {
    tapo light state
    return
  }

  if ($Command -eq "info") {
    tapo light sysinfo
    return
  }

  if ($Command -eq "on") {
    tapo light on
    return
  }

  if ($Command -eq "off") {
    tapo light off
    return
  }

  if ($Command -eq "dimm" -or $Command -eq "down") {
    $brightness = tapojson light sysinfo | jq -r ".brightness"
    $bIsOn = (tapojson light sysinfo | jq -r ".device_on") -eq "True"
    $new_val = [int]$brightness - 10

    if (-Not $bIsOn) {
      tapo light on
    }

    echo "Brightness is set to $brightness, let's decrease it with $new_val"
    $username = $env:KASA_USERNAME
    $password = $env:KASA_PASSWORD
    if (-Not $username -or -Not $password) {
      Write-Error "KASA_USERNAME and KASA_PASSWORD environment variables are required."
      return
    }
    kasa --username $username --password $password --host $Light_ip brightness $new_val
    return
  }

  if ($Command -eq "brighten" -or $Command -eq "up") {
    $brightness = tapojson light sysinfo | jq -r ".brightness"
    $bIsOn = (tapojson light sysinfo | jq -r ".device_on") -eq "True"
    $new_val = [int]$brightness + 10

    if (-Not $bIsOn) {
      tapo light on
    }

    echo "Brightness is set to $brightness, let's increase it a tad with $new_val"
    $username = $env:KASA_USERNAME
    $password = $env:KASA_PASSWORD
    if (-Not $username -or -Not $password) {
      Write-Error "KASA_USERNAME and KASA_PASSWORD environment variables are required."
      return
    }
    kasa --username $username --password $password --host $Light_ip brightness $new_val
    return
  }

  tapo light $Command @args
}


