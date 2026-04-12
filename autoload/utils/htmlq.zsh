# HTML query utilities
htmlqq() {
  local url="$1"
  local selector="$2"
  local theme="${3:-Nord}"
  
  curl -L --silent "$url" | htmlq --pretty "$selector" | bat --language html --style="plain" --theme "$theme" --pager "$@"
}

htmlqqt() {
  local url="$1"
  local selector="$2"
  local theme="$3"
  
  if [ -z "$theme" ]; then
    theme=$(bat --list-themes | fzf)
  fi
  
  htmlqq "$url" "$selector" "$theme"
}
