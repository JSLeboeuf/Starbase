# Search for Valerie's emails with Drive links and project tracking
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

function Search-Full($query, $label) {
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
            } catch { $body = $detail.snippet }
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
        if (-not $body) { $body = $detail.snippet }

        # Check for drive links
        $driveLinks = [regex]::Matches($body, 'https://drive\.google\.com/[^\s<>"]+|https://docs\.google\.com/[^\s<>"]+')

        Write-Host "`n-----------------------------------------------------------" -ForegroundColor Gray
        Write-Host "DATE: $date" -ForegroundColor Yellow
        Write-Host "FROM: $from"
        Write-Host "SUBJECT: $subject" -ForegroundColor Cyan

        if ($driveLinks.Count -gt 0) {
            Write-Host "LIENS DRIVE:" -ForegroundColor Green
            $driveLinks | ForEach-Object { Write-Host "  $($_.Value)" -ForegroundColor Green }
        }

        Write-Host "EXTRAIT: $($detail.snippet.Substring(0, [Math]::Min(300, $detail.snippet.Length)))..."
    }
}

# Search Valerie's emails with drive links
Search-Full "from:valerie@mkmg.ca drive.google.com" "VALERIE - LIENS DRIVE"
Search-Full "from:valerie@mkmg.ca docs.google.com" "VALERIE - LIENS DOCS"
Search-Full "from:valerie@mkmg.ca suivi projet" "VALERIE - SUIVI PROJET"
Search-Full "from:valerie@mkmg.ca tableau" "VALERIE - TABLEAU"
Search-Full "from:valerie@rhsupport.ca" "VALERIE - RH SUPPORT"

# Search for any project tracking
Search-Full "suivi projet drive.google.com" "SUIVI PROJET AVEC DRIVE"
Search-Full "tableau suivi" "TABLEAU SUIVI"
Search-Full "spreadsheet projet" "SPREADSHEET PROJET"

# Search for evaluations in drive
Search-Full "evaluation drive.google.com" "EVALUATION AVEC DRIVE"
Search-Full "rapport drive.google.com 6plex OR terrasse OR langlois" "RAPPORT DRIVE PROJETS"
