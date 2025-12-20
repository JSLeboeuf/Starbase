# Extract ALL emails with Marie-Christine Parisien from Gmail
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

# Create folder for attachments
$attachmentFolder = "C:\Users\Utilisateur\jerome\MARIE-CHRISTINE-PARISIEN-PJ"
if (-not (Test-Path $attachmentFolder)) {
    New-Item -ItemType Directory -Path $attachmentFolder | Out-Null
}

Write-Host "========================================" -ForegroundColor Magenta
Write-Host "  EXTRACTION EMAILS MARIE-CHRISTINE PARISIEN" -ForegroundColor Magenta
Write-Host "  (mcparisien@hotmail.com)" -ForegroundColor Magenta
Write-Host "========================================" -ForegroundColor Magenta

# Get all Marie-Christine emails
$allMsgs = @()
$pageToken = $null
do {
    $query = "from:mcparisien@hotmail.com OR to:mcparisien@hotmail.com OR cc:mcparisien@hotmail.com OR marie-christine parisien"
    $uri = "https://gmail.googleapis.com/gmail/v1/users/me/messages?q=$([uri]::EscapeDataString($query))&maxResults=500"
    if ($pageToken) { $uri += "&pageToken=$pageToken" }
    $result = Invoke-RestMethod -Uri $uri -Headers $headers
    if ($result.messages) {
        $allMsgs += $result.messages
        Write-Host "Found $($allMsgs.Count) emails..." -ForegroundColor Cyan
    }
    $pageToken = $result.nextPageToken
} while ($pageToken)

Write-Host "`nTotal: $($allMsgs.Count) emails" -ForegroundColor Green
Write-Host "Extracting with attachments..." -ForegroundColor Yellow

$output = @()
$output += "============================================"
$output += "EMAILS MARIE-CHRISTINE PARISIEN"
$output += "(mcparisien@hotmail.com)"
$output += "Extracted: $(Get-Date)"
$output += "Total: $($allMsgs.Count) emails"
$output += "Attachments saved to: $attachmentFolder"
$output += "============================================"
$output += ""

$attachmentList = @()
$counter = 0
$attachmentCount = 0

foreach ($msg in $allMsgs) {
    $counter++
    if ($counter % 10 -eq 0) {
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
                }
            }
        }
        if (-not $body) { $body = $detail.snippet }

        # Get and download attachments
        $attachments = @()

        function Process-Parts($parts, $messageId, $dateStr) {
            foreach ($part in $parts) {
                if ($part.filename -and $part.filename -ne "" -and $part.body.attachmentId) {
                    $script:attachments += $part.filename

                    # Create safe filename with date prefix
                    $datePrefix = ""
                    try {
                        $parsedDate = [DateTime]::Parse($dateStr)
                        $datePrefix = $parsedDate.ToString("MMddyyyyHHmmss")
                    } catch {
                        $datePrefix = (Get-Date).ToString("MMddyyyyHHmmss")
                    }

                    $safeFilename = $part.filename -replace '[\\/:*?"<>|]', '_'
                    $destFile = Join-Path $attachmentFolder "${datePrefix}_${safeFilename}"

                    # Check if already exists
                    if (-not (Test-Path $destFile)) {
                        try {
                            $attData = Invoke-RestMethod -Uri "https://gmail.googleapis.com/gmail/v1/users/me/messages/$messageId/attachments/$($part.body.attachmentId)" -Headers $headers
                            $bytes = [System.Convert]::FromBase64String($attData.data.Replace('-','+').Replace('_','/'))
                            [System.IO.File]::WriteAllBytes($destFile, $bytes)
                            $script:attachmentCount++

                            $script:attachmentList += [PSCustomObject]@{
                                Date = $dateStr
                                From = $from
                                Subject = $subject
                                Filename = $part.filename
                                SavedAs = $destFile
                            }
                        } catch { }
                    }
                }

                # Recurse into nested parts
                if ($part.parts) {
                    Process-Parts $part.parts $messageId $dateStr
                }
            }
        }

        if ($detail.payload.parts) {
            Process-Parts $detail.payload.parts $msg.id $date
        }

        # Build output
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
        $output += $body.Substring(0, [Math]::Min(2000, $body.Length))
        $output += ""

    } catch {
        Write-Host "Error on message $($msg.id): $_" -ForegroundColor Red
    }
}

# Save output
$outputFile = "C:\Users\Utilisateur\jerome\MARIE-CHRISTINE-PARISIEN-TOUS-EMAILS.txt"
$output | Out-File $outputFile -Encoding UTF8

# Save attachment list
$csvFile = "C:\Users\Utilisateur\jerome\MARIE-CHRISTINE-PARISIEN-LISTE-PJ.csv"
$attachmentList | Export-Csv $csvFile -NoTypeInformation -Encoding UTF8

Write-Host "`n========================================" -ForegroundColor Green
Write-Host "  EXTRACTION COMPLETE!" -ForegroundColor Green
Write-Host "  Emails: $($allMsgs.Count)" -ForegroundColor Green
Write-Host "  Pieces jointes: $attachmentCount" -ForegroundColor Green
Write-Host "  Output: $outputFile" -ForegroundColor Green
Write-Host "  Attachments: $attachmentFolder" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
