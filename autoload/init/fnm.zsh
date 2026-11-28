# fnm: https://github.com/Schniz/fnm
# Dynamic env, not a captured `fnm env` snapshot: the multishell path is tied to
# the shell that created it, so a hardcoded one breaks when it is cleaned up.
if command -v fnm >/dev/null 2>&1; then
  eval "$(fnm env --use-on-cd --shell zsh)"
fi
