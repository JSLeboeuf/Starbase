# Test Gmail API access
$tokenFile = Get-Content "C:\Users\Utilisateur\.google_workspace_mcp\credentials\token.json" | ConvertFrom-Json
$accessToken = $tokenFile.token

Write-Host "=== TESTING GMAIL ACCESS ===" -ForegroundColor Cyan

# Get recent emails
$headers = @{ Authorization = "Bearer $accessToken" }

try {
    # Get list of messages
    $messages = Invoke-RestMethod -Uri "https://gmail.googleapis.com/gmail/v1/users/me/messages?maxResults=20" -Headers $headers

    Write-Host "Found $($messages.messages.Count) recent emails" -ForegroundColor Green
    Write-Host ""

    # Get details of each message
    foreach ($msg in $messages.messages) {
        $detail = Invoke-RestMethod -Uri "https://gmail.googleapis.com/gmail/v1/users/me/messages/$($msg.id)?format=metadata&metadataHeaders=Subject&metadataHeaders=From&metadataHeaders=Date" -Headers $headers

        $subject = ($detail.payload.headers | Where-Object { $_.name -eq "Subject" }).value
        $from = ($detail.payload.headers | Where-Object { $_.name -eq "From" }).value
        $date = ($detail.payload.headers | Where-Object { $_.name -eq "Date" }).value

        Write-Host "---" -ForegroundColor Gray
        Write-Host "From: $from" -ForegroundColor Yellow
        Write-Host "Subject: $subject"
        Write-Host "Date: $date" -ForegroundColor Gray
    }
} catch {
    Write-Host "Error: $_" -ForegroundColor Red
}
