# Gets the time from the NTP server and formats it as "hour:minute"
function Get-Time {
  try {
    $output = w32tm /stripchart /computer:time.windows.com /samples:1 /dataonly | Out-String
    # Extract the time using a more robust regex
    if ($output -match '\d{2}:\d{2}:\d{2}') {
      $time = $Matches[0]
      ([datetime]$time).ToString("HH:mm") # Formats the time as "hour:minute"
    } else {
      Write-Warning "Unable to parse time from w32tm output."
      $null
    }
  } catch {
    Write-Warning "Error getting time from w32tm: $($_.Exception.Message)"
    $null
  }
}

# Clear the console
Clear-Host

# Infinite loop that updates the time every second
while ($true) {
  $time = Get-Time
  if ($time) {
    # Set the cursor position to the beginning of the line
    [Console]::SetCursorPosition(0, [Console]::CursorTop)
    Write-Host $time -NoNewline
  }
  Start-Sleep -Seconds 1
}
