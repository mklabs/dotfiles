# Pomodoro timers
# https://gist.github.com/bashbunni/f6b04fc4703903a71ce9f70c58345106

function Show-TimerProgress([double]$minutes) {
    $totalSeconds = [math]::Round($minutes * 60)
    for ($i = 0; $i -le $totalSeconds; $i++) {
        $percent = ($i / $totalSeconds)
        $barWidth = 30
        $filled = [math]::Round($percent * $barWidth)
        $empty = $barWidth - $filled
        $bar = ('#' * $filled) + ('-' * $empty)
        Write-Progress -Activity "Timer Running..." `
            -Status "[$bar] $i / $totalSeconds sec" `
            -PercentComplete ($percent * 100)
        Start-Sleep -Seconds 1
    }
    Write-Progress -Activity "Timer Done!" -Completed
}

function work([double]$minutes = 30) {
    $timeout = $minutes * 60
    echo "Setting up timer with $timeout`s ($minutes`min)"
    Show-TimerProgress $minutes
    New-BurntToastNotification `
        -Text 'Take a Break 😊', 'Work Timer is up!' `
        -Sound 'Alarm2'
}

function rest([double]$minutes = 10) {
    $timeout = $minutes * 60
    echo "Setting up timer with $timeout`s ($minutes`min)"
    Show-TimerProgress $minutes
    New-BurntToastNotification `
        -Text 'Get back to work 😬', 'Break is over!' `
        -Sound 'Alarm2'
}

