# eza - modern ls replacement
# https://github.com/eza-community/eza

lls() {
  eza -a --color=always --git "$@"
}

ll() {
  eza -a --color=always --long --git --icons=always "$@"
}

lll() {
  eza -a --color=always --long --git "$@"
}

tree() {
  eza -a -T --level=2 "$@"
}
