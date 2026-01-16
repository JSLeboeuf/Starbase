# Get the critical email about Jérôme/Félix cautionnement
$tokenFile = Get-Content "C:\Users\Utilisateur\.google_workspace_mcp\credentials\token.json" | ConvertFrom-Json
$headers = @{ Authorization = "Bearer $($tokenFile.token)" }

# Search for the specific email
$result = Invoke-RestMethod -Uri "https://gmail.googleapis.com/gmail/v1/users/me/messages?q=from:nicolas.marois+jerome+felix+cautionnement&maxResults=5" -Headers $headers

Write-Host "=== EMAIL COMPLET SUR JEROME/FELIX CAUTIONNEMENT ===" -ForegroundColor Cyan

foreach ($msg in $result.messages) {
    $detail = Invoke-RestMethod -Uri "https://gmail.googleapis.com/gmail/v1/users/me/messages/$($msg.id)?format=full" -Headers $headers

    $subject = ($detail.payload.headers | Where-Object { $_.name -eq "Subject" }).value
    $from = ($detail.payload.headers | Where-Object { $_.name -eq "From" }).value
    $date = ($detail.payload.headers | Where-Object { $_.name -eq "Date" }).value

    # Decode body
    $body = ""
    if ($detail.payload.body.data) {
        $decoded = $detail.payload.body.data.Replace('-','+').Replace('_','/')
        $body = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($decoded))
    } elseif ($detail.payload.parts) {
        foreach ($part in $detail.payload.parts) {
            if ($part.mimeType -eq "text/plain" -and $part.body.data) {
                $decoded = $part.body.data.Replace('-','+').Replace('_','/')
                $body = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($decoded))
                break
            }
        }
    }

    Write-Host "============================================"
    Write-Host "FROM: $from" -ForegroundColor Yellow
    Write-Host "DATE: $date"
    Write-Host "SUBJECT: $subject" -ForegroundColor Green
    Write-Host "--------------------------------------------"
    Write-Host $body
    Write-Host ""
}

# Also get the Amanda email
Write-Host "`n=== EMAIL A AMANDA (pression) ===" -ForegroundColor Cyan
$result = Invoke-RestMethod -Uri "https://gmail.googleapis.com/gmail/v1/users/me/messages?q=to:acockburn+pression&maxResults=3" -Headers $headers

foreach ($msg in $result.messages) {
    $detail = Invoke-RestMethod -Uri "https://gmail.googleapis.com/gmail/v1/users/me/messages/$($msg.id)?format=full" -Headers $headers

    $subject = ($detail.payload.headers | Where-Object { $_.name -eq "Subject" }).value
    $from = ($detail.payload.headers | Where-Object { $_.name -eq "From" }).value
    $date = ($detail.payload.headers | Where-Object { $_.name -eq "Date" }).value

    $body = ""
    if ($detail.payload.parts) {
        foreach ($part in $detail.payload.parts) {
            if ($part.mimeType -eq "text/plain" -and $part.body.data) {
                $decoded = $part.body.data.Replace('-','+').Replace('_','/')
                $body = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($decoded))
                break
            }
        }
    }

    Write-Host "============================================"
    Write-Host "FROM: $from" -ForegroundColor Yellow
    Write-Host "DATE: $date"
    Write-Host "SUBJECT: $subject" -ForegroundColor Green
    Write-Host "--------------------------------------------"
    Write-Host $body
}
