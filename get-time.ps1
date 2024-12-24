# Gets the time from the NTP server and formats it as "hour:minute"
function Get-Time {
  $output = w32tm /stripchart /computer:time.windows.com /samples:1 /dataonly
  if ($output -match '(\d{2}:\d{2}:\d{2}), (.+)') {
    $time = $Matches[1]
    ([datetime]$time).ToString("HH:mm") # Formats the time as "hour:minute"
  } else {
    Write-Warning "Unable to parse time from w32tm output."
    $null
  }
}

# Infinite loop that prints the time every second
while ($true) {
  $time = Get-Time
  if ($time) {
    Write-Host $time
  }
  Start-Sleep -Seconds 1
}