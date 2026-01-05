# Extract all emails since May 2024 and find when Jerome first appeared
$tokenFile = Get-Content "C:\Users\Utilisateur\.google_workspace_mcp\credentials\token.json" | ConvertFrom-Json

# Refresh the token first
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

$tokenFile.token = $accessToken
$tokenFile.expiry = (Get-Date).AddSeconds($response.expires_in).ToString("yyyy-MM-ddTHH:mm:ss.ffffffzzz")
$tokenFile | ConvertTo-Json -Depth 10 | Out-File "C:\Users\Utilisateur\.google_workspace_mcp\credentials\token.json" -Encoding UTF8

$headers = @{ Authorization = "Bearer $accessToken" }

# Track Jerome's first appearance
$jeromeFirstAppearance = $null
$jeromeEmails = @()

function Get-FullEmail($msgId) {
    $detail = Invoke-RestMethod -Uri "https://gmail.googleapis.com/gmail/v1/users/me/messages/$msgId`?format=full" -Headers $headers

    $subject = ($detail.payload.headers | Where-Object { $_.name -eq "Subject" }).value
    $from = ($detail.payload.headers | Where-Object { $_.name -eq "From" }).value
    $to = ($detail.payload.headers | Where-Object { $_.name -eq "To" }).value
    $cc = ($detail.payload.headers | Where-Object { $_.name -eq "Cc" }).value
    $date = ($detail.payload.headers | Where-Object { $_.name -eq "Date" }).value

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
                } catch { $body = $detail.snippet }
            } elseif ($part.parts) {
                foreach ($subpart in $part.parts) {
                    if ($subpart.mimeType -eq "text/plain" -and $subpart.body.data) {
                        try {
                            $decoded = $subpart.body.data.Replace('-','+').Replace('_','/')
                            $body = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($decoded))
                            break
                        } catch { $body = $detail.snippet }
                    }
                }
            }
        }
    }
    if (-not $body) { $body = $detail.snippet }

    return @{
        id = $msgId
        from = $from
        to = $to
        cc = $cc
        date = $date
        subject = $subject
        body = $body
        hasJerome = (($from -match "jlevac|jerome.levac") -or ($to -match "jlevac|jerome.levac") -or ($cc -match "jlevac|jerome.levac"))
    }
}

Write-Host "========================================" -ForegroundColor Magenta
Write-Host "  EXTRACTION EMAILS DEPUIS MAI 2024    " -ForegroundColor Magenta
Write-Host "========================================" -ForegroundColor Magenta

# Search for all emails since May 1, 2024
$allEmails = @()
$pageToken = $null
$totalFound = 0

do {
    $uri = "https://gmail.googleapis.com/gmail/v1/users/me/messages?q=after:2024/05/01&maxResults=500"
    if ($pageToken) {
        $uri += "&pageToken=$pageToken"
    }

    $result = Invoke-RestMethod -Uri $uri -Headers $headers

    if ($result.messages) {
        $totalFound += $result.messages.Count
        Write-Host "Found batch of $($result.messages.Count) emails (total: $totalFound)" -ForegroundColor Cyan
    }

    $pageToken = $result.nextPageToken

    if ($result.messages) {
        $allEmails += $result.messages
    }
} while ($pageToken)

Write-Host "`nTotal emails since May 2024: $totalFound" -ForegroundColor Green
Write-Host "Processing emails to find Jerome's involvement..." -ForegroundColor Yellow

# Process emails and track Jerome
$processedEmails = @()
$jeromeTimeline = @()
$counter = 0

foreach ($msg in $allEmails) {
    $counter++
    if ($counter % 50 -eq 0) {
        Write-Host "Processing $counter / $totalFound..." -ForegroundColor Gray
    }

    try {
        $emailData = Get-FullEmail $msg.id
        $processedEmails += $emailData

        if ($emailData.hasJerome) {
            $jeromeTimeline += $emailData
        }
    } catch {
        Write-Host "Error processing email $($msg.id): $_" -ForegroundColor Red
    }
}

# Sort Jerome emails by date to find first appearance
Write-Host "`n========================================" -ForegroundColor Green
Write-Host "  JEROME TIMELINE ANALYSIS             " -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green

Write-Host "`nTotal emails with Jerome: $($jeromeTimeline.Count)" -ForegroundColor Cyan

# Sort by date (oldest first)
$sortedJerome = $jeromeTimeline | Sort-Object {
    try { [DateTime]::Parse($_.date) } catch { [DateTime]::MinValue }
}

if ($sortedJerome.Count -gt 0) {
    Write-Host "`n=== PREMIERE APPARITION DE JEROME ===" -ForegroundColor Yellow
    $first = $sortedJerome[0]
    Write-Host "DATE: $($first.date)" -ForegroundColor Green
    Write-Host "FROM: $($first.from)"
    Write-Host "TO: $($first.to)"
    Write-Host "CC: $($first.cc)"
    Write-Host "SUBJECT: $($first.subject)"
    Write-Host "---"
    Write-Host $first.body.Substring(0, [Math]::Min(500, $first.body.Length))

    Write-Host "`n=== 10 PREMIERS EMAILS AVEC JEROME ===" -ForegroundColor Yellow
    $sortedJerome | Select-Object -First 10 | ForEach-Object {
        Write-Host "---"
        Write-Host "DATE: $($_.date)" -ForegroundColor Cyan
        Write-Host "SUBJECT: $($_.subject)"
        Write-Host "FROM: $($_.from)"
    }
}

# Save all to file
$outputFile = "C:\Users\Utilisateur\jerome\ALL-EMAILS-SINCE-MAY2024.txt"
$output = @()
$output += "============================================"
$output += "TOUS LES EMAILS DEPUIS MAI 2024"
$output += "Extracted: $(Get-Date)"
$output += "Total: $($processedEmails.Count) emails"
$output += "Emails avec Jerome: $($jeromeTimeline.Count)"
$output += "============================================"
$output += ""

foreach ($email in $processedEmails) {
    $output += "============================================================"
    $output += "FROM: $($email.from)"
    $output += "TO: $($email.to)"
    $output += "CC: $($email.cc)"
    $output += "DATE: $($email.date)"
    $output += "SUBJECT: $($email.subject)"
    $output += "JEROME PRESENT: $($email.hasJerome)"
    $output += "------------------------------------------------------------"
    $output += $email.body
    $output += ""
}

$output | Out-File $outputFile -Encoding UTF8
Write-Host "`nSaved to: $outputFile" -ForegroundColor Green

# Save Jerome timeline separately
$jeromeFile = "C:\Users\Utilisateur\jerome\JEROME-TIMELINE.txt"
$jeromeOutput = @()
$jeromeOutput += "============================================"
$jeromeOutput += "TIMELINE DE JEROME (jlevac@mkmg.ca)"
$jeromeOutput += "Premiere apparition a aujourd'hui"
$jeromeOutput += "Total: $($jeromeTimeline.Count) emails"
$jeromeOutput += "============================================"
$jeromeOutput += ""

if ($sortedJerome.Count -gt 0) {
    $jeromeOutput += "PREMIERE APPARITION: $($sortedJerome[0].date)"
    $jeromeOutput += ""
}

foreach ($email in $sortedJerome) {
    $jeromeOutput += "============================================================"
    $jeromeOutput += "DATE: $($email.date)"
    $jeromeOutput += "FROM: $($email.from)"
    $jeromeOutput += "TO: $($email.to)"
    $jeromeOutput += "CC: $($email.cc)"
    $jeromeOutput += "SUBJECT: $($email.subject)"
    $jeromeOutput += "------------------------------------------------------------"
    $jeromeOutput += $email.body
    $jeromeOutput += ""
}

$jeromeOutput | Out-File $jeromeFile -Encoding UTF8
Write-Host "Jerome timeline saved to: $jeromeFile" -ForegroundColor Green
