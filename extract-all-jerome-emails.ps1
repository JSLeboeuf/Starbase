# Extract ALL emails from Jerome (jlevac@mkmg.ca)
$tokenFile = Get-Content "C:\Users\Utilisateur\.google_workspace_mcp\credentials\token.json" | ConvertFrom-Json

$refreshBody = @{
    client_id = $tokenFile.client_id
    client_secret = $tokenFile.client_secret
    refresh_token = $tokenFile.refresh_token
    grant_type = "refresh_token"
}

$response = Invoke-RestMethod -Uri "https://oauth2.googleapis.com/token" -Method POST -Body $refreshBody -ContentType "application/x-www-form-urlencoded"
$accessToken = $response.access_token

$tokenFile.token = $accessToken
$tokenFile | ConvertTo-Json -Depth 10 | Out-File "C:\Users\Utilisateur\.google_workspace_mcp\credentials\token.json" -Encoding UTF8

$headers = @{ Authorization = "Bearer $accessToken" }

Write-Host "========================================" -ForegroundColor Magenta
Write-Host "  EXTRACTION TOUS LES EMAILS DE JEROME " -ForegroundColor Magenta
Write-Host "  (from:jlevac@mkmg.ca OR to:jlevac@mkmg.ca OR cc:jlevac@mkmg.ca)" -ForegroundColor Magenta
Write-Host "========================================" -ForegroundColor Magenta

# Get all Jerome emails
$allMsgs = @()
$pageToken = $null
do {
    $query = "from:jlevac@mkmg.ca OR to:jlevac@mkmg.ca OR cc:jlevac@mkmg.ca"
    $uri = "https://gmail.googleapis.com/gmail/v1/users/me/messages?q=$([uri]::EscapeDataString($query))&maxResults=500"
    if ($pageToken) { $uri += "&pageToken=$pageToken" }
    $result = Invoke-RestMethod -Uri $uri -Headers $headers
    if ($result.messages) {
        $allMsgs += $result.messages
        Write-Host "Found $($allMsgs.Count) emails..." -ForegroundColor Cyan
    }
    $pageToken = $result.nextPageToken
} while ($pageToken)

Write-Host "`nTotal emails with Jerome: $($allMsgs.Count)" -ForegroundColor Green
Write-Host "Extracting full content..." -ForegroundColor Yellow

$output = @()
$output += "============================================"
$output += "TOUS LES EMAILS AVEC JEROME (jlevac@mkmg.ca)"
$output += "Extracted: $(Get-Date)"
$output += "Total: $($allMsgs.Count) emails"
$output += "============================================"
$output += ""

$counter = 0
foreach ($msg in $allMsgs) {
    $counter++
    if ($counter % 25 -eq 0) {
        Write-Host "Processing $counter / $($allMsgs.Count)..." -ForegroundColor Gray
    }

    try {
        $detail = Invoke-RestMethod -Uri "https://gmail.googleapis.com/gmail/v1/users/me/messages/$($msg.id)?format=full" -Headers $headers

        $subject = ($detail.payload.headers | Where-Object { $_.name -eq "Subject" }).value
        $from = ($detail.payload.headers | Where-Object { $_.name -eq "From" }).value
        $to = ($detail.payload.headers | Where-Object { $_.name -eq "To" }).value
        $cc = ($detail.payload.headers | Where-Object { $_.name -eq "Cc" }).value
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
                } elseif ($part.parts) {
                    foreach ($subpart in $part.parts) {
                        if ($subpart.mimeType -eq "text/plain" -and $subpart.body.data) {
                            try {
                                $decoded = $subpart.body.data.Replace('-','+').Replace('_','/')
                                $body = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($decoded))
                                break
                            } catch { }
                        }
                    }
                }
            }
        }
        if (-not $body) { $body = $detail.snippet }

        # Get attachments
        $attachments = @()
        function Get-Attachments($parts) {
            foreach ($part in $parts) {
                if ($part.filename -and $part.filename -ne "") {
                    $script:attachments += $part.filename
                }
                if ($part.parts) {
                    Get-Attachments $part.parts
                }
            }
        }
        if ($detail.payload.parts) { Get-Attachments $detail.payload.parts }

        $output += "============================================================"
        $output += "DATE: $date"
        $output += "FROM: $from"
        $output += "TO: $to"
        if ($cc) { $output += "CC: $cc" }
        $output += "SUBJECT: $subject"
        if ($attachments.Count -gt 0) {
            $output += "PIECES JOINTES: $($attachments -join ', ')"
        }
        $output += "------------------------------------------------------------"
        $output += $body
        $output += ""

        # Also print to console
        Write-Host "---" -ForegroundColor Gray
        Write-Host "DATE: $date" -ForegroundColor Yellow
        Write-Host "FROM: $from"
        Write-Host "SUBJECT: $subject" -ForegroundColor Cyan
        if ($attachments.Count -gt 0) {
            Write-Host "PJ: $($attachments -join ', ')" -ForegroundColor Green
        }

    } catch {
        Write-Host "Error processing email: $_" -ForegroundColor Red
    }
}

# Save to file
$outputFile = "C:\Users\Utilisateur\jerome\JEROME-TOUS-EMAILS-COMPLET.txt"
$output | Out-File $outputFile -Encoding UTF8
Write-Host "`n========================================" -ForegroundColor Green
Write-Host "EXTRACTION COMPLETE!" -ForegroundColor Green
Write-Host "Total: $($allMsgs.Count) emails" -ForegroundColor Green
Write-Host "Saved to: $outputFile" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
