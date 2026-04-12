
# Splits PATH entries and pipe it through fzf for filtering
function envpath($command) {
  $env:PATH -split ';' | fzf
}

