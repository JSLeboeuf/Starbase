# Extract all emails with Nicolas Marois and Jerome Levac
$tokenFile = Get-Content "C:\Users\Utilisateur\.google_workspace_mcp\credentials\token.json" | ConvertFrom-Json
$headers = @{ Authorization = "Bearer $($tokenFile.token)" }

function Get-FullEmail($msgId) {
    $detail = Invoke-RestMethod -Uri "https://gmail.googleapis.com/gmail/v1/users/me/messages/$msgId`?format=full" -Headers $headers

    $subject = ($detail.payload.headers | Where-Object { $_.name -eq "Subject" }).value
    $from = ($detail.payload.headers | Where-Object { $_.name -eq "From" }).value
    $to = ($detail.payload.headers | Where-Object { $_.name -eq "To" }).value
    $date = ($detail.payload.headers | Where-Object { $_.name -eq "Date" }).value

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
            } elseif ($part.parts) {
                foreach ($subpart in $part.parts) {
                    if ($subpart.mimeType -eq "text/plain" -and $subpart.body.data) {
                        $decoded = $subpart.body.data.Replace('-','+').Replace('_','/')
                        $body = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($decoded))
                        break
                    }
                }
            }
        }
    }

    Write-Host "============================================================" -ForegroundColor Cyan
    Write-Host "FROM: $from" -ForegroundColor Yellow
    Write-Host "TO: $to" -ForegroundColor Yellow
    Write-Host "DATE: $date"
    Write-Host "SUBJECT: $subject" -ForegroundColor Green
    Write-Host "------------------------------------------------------------"
    if ($body) { Write-Host $body } else { Write-Host $detail.snippet }
    Write-Host ""
}

Write-Host "========================================" -ForegroundColor Magenta
Write-Host "  EMAILS AVEC NICOLAS MAROIS (avocat)  " -ForegroundColor Magenta
Write-Host "========================================" -ForegroundColor Magenta

$result = Invoke-RestMethod -Uri "https://gmail.googleapis.com/gmail/v1/users/me/messages?q=from:nicolas.marois+OR+to:nicolas.marois&maxResults=50" -Headers $headers
Write-Host "Found $($result.messages.Count) emails with Nicolas Marois`n"

foreach ($msg in $result.messages) {
    Get-FullEmail $msg.id
}

Write-Host "`n========================================" -ForegroundColor Magenta
Write-Host "  EMAILS AVEC JEROME LEVAC (jlevac@mkmg.ca)  " -ForegroundColor Magenta
Write-Host "========================================" -ForegroundColor Magenta

$result = Invoke-RestMethod -Uri "https://gmail.googleapis.com/gmail/v1/users/me/messages?q=from:jlevac@mkmg.ca+OR+to:jlevac@mkmg.ca&maxResults=50" -Headers $headers
Write-Host "Found $($result.messages.Count) emails with Jerome Levac`n"

foreach ($msg in $result.messages) {
    Get-FullEmail $msg.id
}

Write-Host "`n========================================" -ForegroundColor Magenta
Write-Host "  EMAILS AVEC CEDRIC LEBOEUF  " -ForegroundColor Magenta
Write-Host "========================================" -ForegroundColor Magenta

$result = Invoke-RestMethod -Uri "https://gmail.googleapis.com/gmail/v1/users/me/messages?q=from:info@cedricleboeuf.com+OR+to:info@cedricleboeuf.com+OR+from:cedric+OR+to:cedric&maxResults=50" -Headers $headers
Write-Host "Found $($result.messages.Count) emails with Cedric`n"

foreach ($msg in $result.messages) {
    Get-FullEmail $msg.id
}
