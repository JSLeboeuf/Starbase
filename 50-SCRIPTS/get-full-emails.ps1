# Get full content of key emails
$tokenFile = Get-Content "C:\Users\Utilisateur\.google_workspace_mcp\credentials\token.json" | ConvertFrom-Json
$accessToken = $tokenFile.token
$headers = @{ Authorization = "Bearer $accessToken" }

function Get-EmailBody($messageId) {
    $detail = Invoke-RestMethod -Uri "https://gmail.googleapis.com/gmail/v1/users/me/messages/$messageId?format=full" -Headers $headers

    $subject = ($detail.payload.headers | Where-Object { $_.name -eq "Subject" }).value
    $from = ($detail.payload.headers | Where-Object { $_.name -eq "From" }).value
    $to = ($detail.payload.headers | Where-Object { $_.name -eq "To" }).value
    $date = ($detail.payload.headers | Where-Object { $_.name -eq "Date" }).value

    # Decode body
    $body = ""
    if ($detail.payload.body.data) {
        $body = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($detail.payload.body.data.Replace('-','+').Replace('_','/')))
    } elseif ($detail.payload.parts) {
        foreach ($part in $detail.payload.parts) {
            if ($part.mimeType -eq "text/plain" -and $part.body.data) {
                $body = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($part.body.data.Replace('-','+').Replace('_','/')))
                break
            }
        }
    }

    Write-Host "============================================================" -ForegroundColor Cyan
    Write-Host "FROM: $from" -ForegroundColor Yellow
    Write-Host "TO: $to" -ForegroundColor Yellow
    Write-Host "DATE: $date"
    Write-Host "SUBJECT: $subject" -ForegroundColor Green
    Write-Host "------------------------------------------------------------"
    Write-Host $body
    Write-Host ""
}

# Search for key emails
$keySearches = @(
    "Entente entre les partenaires",
    "from:nicolas.marois",
    "from:jlevac",
    "Jerome Levac",
    "Convention actionnaires",
    "48 portes"
)

foreach ($query in $keySearches) {
    Write-Host "`n=== SEARCHING: $query ===" -ForegroundColor Magenta
    $encoded = [uri]::EscapeDataString($query)
    $result = Invoke-RestMethod -Uri "https://gmail.googleapis.com/gmail/v1/users/me/messages?q=$encoded&maxResults=5" -Headers $headers

    if ($result.messages) {
        foreach ($msg in $result.messages) {
            Get-EmailBody $msg.id
        }
    }
}
