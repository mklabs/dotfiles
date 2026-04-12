function htmlqq {
  param (
    [string]$URL,
    [string]$Selector,
    [string]$Theme = "Nord"
  )

  curl -L --silent $URL | htmlq --pretty $Selector | bat --language html --style="plain" --theme $Theme -P @args
}

function htmlqqt {
  param (
    [string]$URL,
    [string]$Selector,
    [string]$Theme = ""
  )

  if (-Not ($Theme)) {
    $Theme = bat --list-themes | fzf
  }

  htmlqq $URL $Selector $Theme @args 
}

