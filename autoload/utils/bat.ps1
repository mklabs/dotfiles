Remove-Item alias:cat -ErrorAction SilentlyContinue

function cat() {
  bat -pp @args
}
