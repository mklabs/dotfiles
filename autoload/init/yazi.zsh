# Yazi file manager
# https://github.com/sxyazi/yazi
y() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
  yazi $@ --cwd-file="$tmp"
  if [ -f "$tmp" ] && [ -r "$tmp" ]; then
    local cwd="$(cat "$tmp")"
    [ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && cd "$cwd"
    rm -f "$tmp"
  fi
}
