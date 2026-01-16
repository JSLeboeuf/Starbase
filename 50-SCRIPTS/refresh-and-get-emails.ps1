# Refresh token and get emails
$tokenFile = Get-Content "C:\Users\Utilisateur\.google_workspace_mcp\credentials\token.json" | ConvertFrom-Json

# Refresh the token
$refreshBody = @{
    client_id = $tokenFile.client_id
    client_secret = $tokenFile.client_secret
    refresh_token = $tokenFile.refresh_token
    grant_type = "refresh_token"
}

Write-Host "Refreshing token..." -ForegroundColor Yellow
$response = Invoke-RestMethod -Uri "https://oauth2.googleapis.com/token" -Method POST -Body $refreshBody -ContentType "application/x-www-form-urlencoded"
$accessToken = $response.access_token
Write-Host "Token refreshed!" -ForegroundColor Green

# Update token file
$tokenFile.token = $accessToken
$tokenFile.expiry = (Get-Date).AddSeconds($response.expires_in).ToString("yyyy-MM-ddTHH:mm:ss.ffffffzzz")
$tokenFile | ConvertTo-Json -Depth 10 | Out-File "C:\Users\Utilisateur\.google_workspace_mcp\credentials\token.json" -Encoding UTF8

$headers = @{ Authorization = "Bearer $accessToken" }

# Search for Jérôme emails
Write-Host "`n=== EMAILS WITH JEROME ===" -ForegroundColor Cyan
$result = Invoke-RestMethod -Uri "https://gmail.googleapis.com/gmail/v1/users/me/messages?q=jerome&maxResults=10" -Headers $headers

foreach ($msg in $result.messages) {
    $detail = Invoke-RestMethod -Uri "https://gmail.googleapis.com/gmail/v1/users/me/messages/$($msg.id)?format=metadata&metadataHeaders=Subject&metadataHeaders=From&metadataHeaders=To&metadataHeaders=Date" -Headers $headers

    $subject = ($detail.payload.headers | Where-Object { $_.name -eq "Subject" }).value
    $from = ($detail.payload.headers | Where-Object { $_.name -eq "From" }).value
    $date = ($detail.payload.headers | Where-Object { $_.name -eq "Date" }).value

    Write-Host "---"
    Write-Host "From: $from" -ForegroundColor Yellow
    Write-Host "Subject: $subject"
    Write-Host "Date: $date" -ForegroundColor Gray
    Write-Host "Snippet: $($detail.snippet)"
}

# Search for VETA partnership emails
Write-Host "`n=== EMAILS ABOUT VETA PARTNERSHIP ===" -ForegroundColor Cyan
$result = Invoke-RestMethod -Uri "https://gmail.googleapis.com/gmail/v1/users/me/messages?q=VETA+actionnaire+OR+partenaire+OR+convention&maxResults=10" -Headers $headers

foreach ($msg in $result.messages) {
    $detail = Invoke-RestMethod -Uri "https://gmail.googleapis.com/gmail/v1/users/me/messages/$($msg.id)?format=metadata&metadataHeaders=Subject&metadataHeaders=From&metadataHeaders=To&metadataHeaders=Date" -Headers $headers

    $subject = ($detail.payload.headers | Where-Object { $_.name -eq "Subject" }).value
    $from = ($detail.payload.headers | Where-Object { $_.name -eq "From" }).value
    $date = ($detail.payload.headers | Where-Object { $_.name -eq "Date" }).value

    Write-Host "---"
    Write-Host "From: $from" -ForegroundColor Yellow
    Write-Host "Subject: $subject"
    Write-Host "Date: $date" -ForegroundColor Gray
    Write-Host "Snippet: $($detail.snippet)"
}

# Search for lawyer emails
Write-Host "`n=== EMAILS FROM LAWYER (nicolas.marois) ===" -ForegroundColor Cyan
$result = Invoke-RestMethod -Uri "https://gmail.googleapis.com/gmail/v1/users/me/messages?q=from:nicolas.marois&maxResults=10" -Headers $headers

foreach ($msg in $result.messages) {
    $detail = Invoke-RestMethod -Uri "https://gmail.googleapis.com/gmail/v1/users/me/messages/$($msg.id)?format=metadata&metadataHeaders=Subject&metadataHeaders=From&metadataHeaders=To&metadataHeaders=Date" -Headers $headers

    $subject = ($detail.payload.headers | Where-Object { $_.name -eq "Subject" }).value
    $from = ($detail.payload.headers | Where-Object { $_.name -eq "From" }).value
    $date = ($detail.payload.headers | Where-Object { $_.name -eq "Date" }).value

    Write-Host "---"
    Write-Host "From: $from" -ForegroundColor Yellow
    Write-Host "Subject: $subject"
    Write-Host "Date: $date" -ForegroundColor Gray
    Write-Host "Snippet: $($detail.snippet)"
}
