# Gets the time from the NTP server and formats it as "hour:minute:second"
function Get-Time {
  try {
    $output = w32tm /stripchart /computer:time.windows.com /samples:1 /dataonly | Out-String
    # Extract the time using a more robust regex
    if ($output -match '\d{2}:\d{2}:\d{2}') {
      $time = $Matches[0]
      return [datetime]$time
    } else {
      Write-Warning "Unable to parse time from w32tm output."
      return $null
    }
  } catch {
    Write-Warning "Error getting time from w32tm: $($_.Exception.Message)"
    return $null
  }
}

# Clear the console
Clear-Host

# Get the initial time from the NTP server
$startTime = Get-Time
if ($startTime) {
    # Set the cursor position and print initial time (HH:mm)
    [Console]::SetCursorPosition(0, [Console]::CursorTop)
    Write-Host $startTime.ToString("HH:mm") -NoNewline
}

# Infinite loop to update the time every second
while ($true) {
    $currentTime = (Get-Date)  # Get the current system time
    $elapsedTime = $currentTime - $startTime  # Calculate elapsed time since NTP request

    # Only display the hour and minute, formatted as "HH:mm"
    $formattedTime = $startTime.AddSeconds($elapsedTime.TotalSeconds).ToString("HH:mm")

    # Set the cursor position to the beginning of the line and display the updated time
    [Console]::SetCursorPosition(0, [Console]::CursorTop)
    Write-Host $formattedTime -NoNewline
    
    Start-Sleep -Seconds 1  # Sleep for 1 second
}
