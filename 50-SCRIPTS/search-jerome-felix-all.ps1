# Search all Jerome and Felix emails for any links or project tracking
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

function Search-AllEmails($query, $label) {
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
        $date = ($detail.payload.headers | Where-Object { $_.name -eq "Date" }).value

        # Get body
        $body = ""
        if ($detail.payload.body.data) {
            try {
                $decoded = $detail.payload.body.data.Replace('-','+').Replace('_','/')
                $body = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($decoded))
            } catch { }
        } elseif ($detail.payload.parts) {
            foreach ($part in $detail.payload.parts) {
                if ($part.mimeType -eq "text/plain" -and $part.body.data) {
                    try {
                        $decoded = $part.body.data.Replace('-','+').Replace('_','/')
                        $body = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($decoded))
                        break
                    } catch { }
                }
            }
        }

        # Check for any URL links
        $allLinks = [regex]::Matches($body, 'https?://[^\s<>"'']+')
        $hasLinks = $allLinks.Count -gt 0

        Write-Host "`n---" -ForegroundColor Gray
        Write-Host "DATE: $date" -ForegroundColor Yellow
        Write-Host "FROM: $from"
        Write-Host "SUBJECT: $subject" -ForegroundColor Cyan
        if ($hasLinks) {
            Write-Host "LIENS:" -ForegroundColor Green
            $allLinks | Select-Object -First 5 | ForEach-Object { Write-Host "  $($_.Value)" -ForegroundColor Green }
        }
        Write-Host "SNIPPET: $($detail.snippet.Substring(0, [Math]::Min(200, $detail.snippet.Length)))..."
    }
}

# Search Jerome emails with attachments
Search-AllEmails "from:jlevac@mkmg.ca has:attachment" "JEROME - AVEC PIECES JOINTES"

# Search Felix emails with attachments
Search-AllEmails "from:felixhamel1991@gmail.com has:attachment" "FELIX - AVEC PIECES JOINTES"

# Search for specific project terms
Search-AllEmails "from:jlevac@mkmg.ca (echeancier OR budget OR financement OR evaluation)" "JEROME - ECHEANCIER/BUDGET/FINANCEMENT"
Search-AllEmails "from:felixhamel1991@gmail.com (echeancier OR budget OR financement OR evaluation)" "FELIX - ECHEANCIER/BUDGET/FINANCEMENT"

# Search for 6plex or terrasse from them
Search-AllEmails "from:jlevac@mkmg.ca 6plex" "JEROME - 6PLEX"
Search-AllEmails "from:felixhamel1991@gmail.com terrasse" "FELIX - TERRASSE"
