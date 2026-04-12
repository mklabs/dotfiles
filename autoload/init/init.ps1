# Make Ctrl+D logout current session
Set-PSReadlineKeyHandler -Key ctrl+d -Function DeleteCharOrExit
