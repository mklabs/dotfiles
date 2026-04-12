# Pomodoro timers (bashbunni style)
# Requires: timer and terminal-notifier
# https://gist.github.com/bashbunni/f6b04fc4703903a71ce9f70c58345106

alias work="timer 60m && terminal-notifier -message 'Pomodoro' -title 'Work Timer is up! Take a Break 😊' -sound Crystal"
alias rest="timer 10m && terminal-notifier -message 'Pomodoro' -title 'Break is over! Get back to work 😬' -sound Crystal"
