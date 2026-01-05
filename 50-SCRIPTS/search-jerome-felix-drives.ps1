# Search for Jerome and Felix Drive links for project management
$tokenFile = Get-Content "C:\Users\Utilisateur\.google_workspace_mcp\credentials\token.json" | ConvertFrom-Json

$refreshBody = @{
    client_id = $tokenFile.client_id
    client_secret = $tokenFile.client_secret
    refresh_token = $tokenFile.refresh_token
    grant_type = "refresh_token"
}

$response = Invoke-RestMethod -Uri "https://oauth2.googleapis.com/token" -Method POST -Body $refreshBody -ContentType "application/x-www-form-urlencoded"
$accessToken = $response.access_token
$headers = @{ Authorization = "Bearer $accessToken" }

function Get-EmailsWithDriveLinks($query, $label) {
    Write-Host "`n========================================" -ForegroundColor Magenta
    Write-Host "  $label" -ForegroundColor Magenta
    Write-Host "========================================" -ForegroundColor Magenta

    $allMsgs = @()
    $pageToken = $null
    do {
        $uri = "https://gmail.googleapis.com/gmail/v1/users/me/messages?q=$([uri]::EscapeDataString($query))&maxResults=100"
        if ($pageToken) { $uri += "&pageToken=$pageToken" }
        $result = Invoke-RestMethod -Uri $uri -Headers $headers
        if ($result.messages) { $allMsgs += $result.messages }
        $pageToken = $result.nextPageToken
    } while ($pageToken)

    Write-Host "Trouves: $($allMsgs.Count) emails" -ForegroundColor Cyan

    foreach ($msg in $allMsgs) {
        $detail = Invoke-RestMethod -Uri "https://gmail.googleapis.com/gmail/v1/users/me/messages/$($msg.id)?format=full" -Headers $headers

        $subject = ($detail.payload.headers | Where-Object { $_.name -eq "Subject" }).value
        $from = ($detail.payload.headers | Where-Object { $_.name -eq "From" }).value
        $to = ($detail.payload.headers | Where-Object { $_.name -eq "To" }).value
        $date = ($detail.payload.headers | Where-Object { $_.name -eq "Date" }).value

        # Get full body
        $body = ""
        if ($detail.payload.body.data) {
            try {
                $decoded = $detail.payload.body.data.Replace('-','+').Replace('_','/')
                $body = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($decoded))
            } catch { $body = $detail.snippet }
        } elseif ($detail.payload.parts) {
            foreach ($part in $detail.payload.parts) {
                if ($part.mimeType -eq "text/plain" -and $part.body.data) {
                    try {
                        $decoded = $part.body.data.Replace('-','+').Replace('_','/')
                        $body = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($decoded))
                        break
                    } catch { }
                } elseif ($part.mimeType -eq "text/html" -and $part.body.data -and -not $body) {
                    try {
                        $decoded = $part.body.data.Replace('-','+').Replace('_','/')
                        $body = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($decoded))
                    } catch { }
                }
            }
        }
        if (-not $body) { $body = $detail.snippet }

        # Extract drive/docs links
        $driveLinks = [regex]::Matches($body, 'https://(drive|docs)\.google\.com/[^\s<>"''\)]+')

        if ($driveLinks.Count -gt 0) {
            Write-Host "`n============================================================" -ForegroundColor Cyan
            Write-Host "DATE: $date" -ForegroundColor Yellow
            Write-Host "FROM: $from" -ForegroundColor Yellow
            Write-Host "TO: $to"
            Write-Host "SUBJECT: $subject" -ForegroundColor Green
            Write-Host "LIENS DRIVE/DOCS:" -ForegroundColor Magenta
            $driveLinks | ForEach-Object { Write-Host "  $($_.Value)" -ForegroundColor Magenta }
            Write-Host "------------------------------------------------------------"
            Write-Host $detail.snippet
        }
    }
}

# Search Jerome's emails with Drive links
Get-EmailsWithDriveLinks "from:jlevac@mkmg.ca (drive.google.com OR docs.google.com)" "JEROME - LIENS DRIVE/DOCS"

# Search Felix's emails with Drive links
Get-EmailsWithDriveLinks "from:felixhamel1991@gmail.com (drive.google.com OR docs.google.com)" "FELIX - LIENS DRIVE/DOCS"
Get-EmailsWithDriveLinks "from:felixhamel0902@gmail.com (drive.google.com OR docs.google.com)" "FELIX (autre email) - LIENS DRIVE/DOCS"

# Search for project management / suivi / gestion
Get-EmailsWithDriveLinks "from:jlevac@mkmg.ca (suivi OR gestion OR projet OR tableau OR spreadsheet)" "JEROME - GESTION PROJET"
Get-EmailsWithDriveLinks "from:felixhamel1991@gmail.com (suivi OR gestion OR projet OR tableau)" "FELIX - GESTION PROJET"

# Search for sheets specifically
Get-EmailsWithDriveLinks "from:jlevac@mkmg.ca sheets.google.com" "JEROME - GOOGLE SHEETS"
Get-EmailsWithDriveLinks "from:felixhamel1991@gmail.com sheets.google.com" "FELIX - GOOGLE SHEETS"
