# Prompt

## Starship
# https://starship.rs
# https://github.com/starship/starship
Invoke-Expression (&starship init powershell)
Invoke-Expression -Command $(starship completions power-shell | Out-String)

# https://learn.microsoft.com/en-us/windows/terminal/tutorials/new-tab-same-directory
function Invoke-Starship-PreCommand {
  $loc = $executionContext.SessionState.Path.CurrentLocation;
  $prompt = "$([char]27)]9;12$([char]7)"
  if ($loc.Provider.Name -eq "FileSystem")
  {
    $prompt += "$([char]27)]9;9;`"$($loc.ProviderPath)`"$([char]27)\"
  }
  $host.ui.Write($prompt)
}

# Icons
# https://github.com/devblackops/Terminal-Icons
Import-Module Terminal-Icons

# PSReadLine
# https://github.com/PowerShell/PSReadLine
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView

# Fzf
# https://github.com/junegunn/fzf
# https://github.com/kelleyma49/PSFzf
Import-Module PSFzf
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+f' -PSReadlineChordReverseHistory 'Ctrl+r'

