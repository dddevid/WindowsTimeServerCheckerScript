# Ottiene l'ora dal server NTP e la formatta come "ora:minuto"
function Get-Time {
  $time = w32tm /stripchart /computer:time.windows.com /samples:1 /dataonly | ForEach-Object {
    $_.Split(',')[1].Trim()
  }
  $time = $time -replace '\.\d+s', '' # Rimuove i secondi e la parte decimale
  $time = $time -replace '\+|-', ''  # Rimuove il segno più o meno
  ([datetime]$time).ToString("HH:mm") # Formatta l'ora come "ora:minuto"
}

# Ciclo infinito che stampa l'ora ogni secondo
while ($true) {
  Write-Host (Get-Time)
  Start-Sleep -Seconds 1
}
