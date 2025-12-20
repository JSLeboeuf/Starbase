# Extract ALL emails from Jerome with attachments
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
$attachmentFolder = "C:\Users\Utilisateur\jerome\JEROME-PIECES-JOINTES"
if (-not (Test-Path $attachmentFolder)) {
    New-Item -ItemType Directory -Path $attachmentFolder | Out-Null
}

Write-Host "========================================" -ForegroundColor Magenta
Write-Host "  EXTRACTION EMAILS JEROME + PIECES JOINTES" -ForegroundColor Magenta
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

Write-Host "`nTotal: $($allMsgs.Count) emails" -ForegroundColor Green
Write-Host "Extracting with attachments..." -ForegroundColor Yellow

$output = @()
$output += "============================================"
$output += "EMAILS JEROME AVEC PIECES JOINTES"
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

                    # Download attachment
                    try {
                        $attUri = "https://gmail.googleapis.com/gmail/v1/users/me/messages/$messageId/attachments/$($part.body.attachmentId)"
                        $attData = Invoke-RestMethod -Uri $attUri -Headers $headers

                        # Decode and save
                        $decoded = $attData.data.Replace('-','+').Replace('_','/')
                        $bytes = [System.Convert]::FromBase64String($decoded)

                        # Clean filename and add date prefix
                        $cleanDate = $dateStr -replace '[^\d]', '' | Select-Object -First 1
                        $safeFilename = $part.filename -replace '[\\/:*?"<>|]', '_'
                        $savePath = Join-Path $attachmentFolder "${cleanDate}_${safeFilename}"

                        # Handle duplicates
                        $i = 1
                        while (Test-Path $savePath) {
                            $ext = [System.IO.Path]::GetExtension($safeFilename)
                            $name = [System.IO.Path]::GetFileNameWithoutExtension($safeFilename)
                            $savePath = Join-Path $attachmentFolder "${cleanDate}_${name}_$i$ext"
                            $i++
                        }

                        [System.IO.File]::WriteAllBytes($savePath, $bytes)
                        $script:attachmentCount++

                        $script:attachmentList += [PSCustomObject]@{
                            Date = $dateStr
                            From = $from
                            Subject = $subject
                            Filename = $part.filename
                            SavedAs = $savePath
                        }

                        Write-Host "  Saved: $($part.filename)" -ForegroundColor Green
                    } catch {
                        Write-Host "  Error downloading $($part.filename): $_" -ForegroundColor Red
                    }
                }

                if ($part.parts) {
                    Process-Parts $part.parts $messageId $dateStr
                }
            }
        }

        if ($detail.payload.parts) {
            Process-Parts $detail.payload.parts $msg.id $date
        }

        # Add to output
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

        # Console output for emails with attachments
        if ($attachments.Count -gt 0) {
            Write-Host "---" -ForegroundColor Cyan
            Write-Host "DATE: $date" -ForegroundColor Yellow
            Write-Host "FROM: $from"
            Write-Host "SUBJECT: $subject" -ForegroundColor Cyan
            Write-Host "PJ: $($attachments -join ', ')" -ForegroundColor Green
        }

    } catch {
        Write-Host "Error: $_" -ForegroundColor Red
    }
}

# Save emails
$outputFile = "C:\Users\Utilisateur\jerome\JEROME-EMAILS-AVEC-PJ.txt"
$output | Out-File $outputFile -Encoding UTF8

# Save attachment list
$attachmentListFile = "C:\Users\Utilisateur\jerome\JEROME-LISTE-PIECES-JOINTES.csv"
$attachmentList | Export-Csv $attachmentListFile -NoTypeInformation -Encoding UTF8

Write-Host "`n========================================" -ForegroundColor Green
Write-Host "EXTRACTION COMPLETE!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host "Emails: $($allMsgs.Count)" -ForegroundColor Cyan
Write-Host "Pieces jointes telechargees: $attachmentCount" -ForegroundColor Cyan
Write-Host ""
Write-Host "Fichiers crees:" -ForegroundColor Yellow
Write-Host "  - $outputFile"
Write-Host "  - $attachmentListFile"
Write-Host "  - $attachmentFolder (dossier avec PJ)"
