# Search for Jerome emails, 6plex, and Terrasse du Pont
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

    return @{
        from = $from
        to = $to
        cc = $cc
        date = $date
        subject = $subject
        body = $body
    }
}

function Search-Emails($query, $label) {
    Write-Host "`n========================================" -ForegroundColor Magenta
    Write-Host "  $label" -ForegroundColor Magenta
    Write-Host "  Query: $query" -ForegroundColor Gray
    Write-Host "========================================" -ForegroundColor Magenta

    $allMessages = @()
    $pageToken = $null

    do {
        $uri = "https://gmail.googleapis.com/gmail/v1/users/me/messages?q=$([uri]::EscapeDataString($query))&maxResults=500"
        if ($pageToken) { $uri += "&pageToken=$pageToken" }

        $result = Invoke-RestMethod -Uri $uri -Headers $headers
        if ($result.messages) {
            $allMessages += $result.messages
            Write-Host "Found $($allMessages.Count) emails..." -ForegroundColor Cyan
        }
        $pageToken = $result.nextPageToken
    } while ($pageToken)

    Write-Host "Total: $($allMessages.Count) emails" -ForegroundColor Green

    $emails = @()
    foreach ($msg in $allMessages) {
        try {
            $emailData = Get-FullEmail $msg.id
            $emails += $emailData

            Write-Host "---" -ForegroundColor Gray
            Write-Host "DATE: $($emailData.date)" -ForegroundColor Yellow
            Write-Host "FROM: $($emailData.from)"
            Write-Host "SUBJECT: $($emailData.subject)" -ForegroundColor Cyan
        } catch {
            Write-Host "Error: $_" -ForegroundColor Red
        }
    }

    return $emails
}

# 1. ALL EMAILS WITH JEROME
$jeromeEmails = Search-Emails "from:jlevac@mkmg.ca OR to:jlevac@mkmg.ca OR cc:jlevac@mkmg.ca" "TOUS LES EMAILS AVEC JEROME"

# Save Jerome emails
$jeromeOutput = @()
$jeromeOutput += "============================================"
$jeromeOutput += "TOUS LES EMAILS AVEC JEROME (jlevac@mkmg.ca)"
$jeromeOutput += "Total: $($jeromeEmails.Count) emails"
$jeromeOutput += "============================================"

# Sort by date
$sortedJerome = $jeromeEmails | Sort-Object { try { [DateTime]::Parse($_.date) } catch { [DateTime]::MaxValue } }

if ($sortedJerome.Count -gt 0) {
    $jeromeOutput += ""
    $jeromeOutput += "PREMIER EMAIL AVEC JEROME: $($sortedJerome[0].date)"
    $jeromeOutput += "SUJET: $($sortedJerome[0].subject)"
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
$jeromeOutput | Out-File "C:\Users\Utilisateur\jerome\JEROME-ALL-EMAILS.txt" -Encoding UTF8

# 2. 6PLEX EMAILS
$sixplexEmails = Search-Emails "6plex OR 6-plex OR sixplex OR `"6 plex`" OR `"6 logements`" OR `"6 unites`"" "EMAILS SUR LE 6PLEX"

$sixplexOutput = @()
$sixplexOutput += "============================================"
$sixplexOutput += "EMAILS SUR LE 6PLEX"
$sixplexOutput += "Total: $($sixplexEmails.Count) emails"
$sixplexOutput += "============================================"

foreach ($email in $sixplexEmails) {
    $sixplexOutput += "============================================================"
    $sixplexOutput += "DATE: $($email.date)"
    $sixplexOutput += "FROM: $($email.from)"
    $sixplexOutput += "TO: $($email.to)"
    $sixplexOutput += "CC: $($email.cc)"
    $sixplexOutput += "SUBJECT: $($email.subject)"
    $sixplexOutput += "------------------------------------------------------------"
    $sixplexOutput += $email.body
    $sixplexOutput += ""
}
$sixplexOutput | Out-File "C:\Users\Utilisateur\jerome\6PLEX-EMAILS.txt" -Encoding UTF8

# 3. TERRASSE DU PONT EMAILS
$terrasseEmails = Search-Emails "terrasse du pont OR `"terrasse pont`" OR terrassedupont" "EMAILS SUR TERRASSE DU PONT"

$terrasseOutput = @()
$terrasseOutput += "============================================"
$terrasseOutput += "EMAILS SUR TERRASSE DU PONT"
$terrasseOutput += "Total: $($terrasseEmails.Count) emails"
$terrasseOutput += "============================================"

foreach ($email in $terrasseEmails) {
    $terrasseOutput += "============================================================"
    $terrasseOutput += "DATE: $($email.date)"
    $terrasseOutput += "FROM: $($email.from)"
    $terrasseOutput += "TO: $($email.to)"
    $terrasseOutput += "CC: $($email.cc)"
    $terrasseOutput += "SUBJECT: $($email.subject)"
    $terrasseOutput += "------------------------------------------------------------"
    $terrasseOutput += $email.body
    $terrasseOutput += ""
}
$terrasseOutput | Out-File "C:\Users\Utilisateur\jerome\TERRASSE-DU-PONT-EMAILS.txt" -Encoding UTF8

# SUMMARY
Write-Host "`n========================================" -ForegroundColor Green
Write-Host "  RESUME" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host "Emails avec Jerome: $($jeromeEmails.Count)" -ForegroundColor Cyan
if ($sortedJerome.Count -gt 0) {
    Write-Host "  Premier email: $($sortedJerome[0].date)" -ForegroundColor Yellow
}
Write-Host "Emails 6plex: $($sixplexEmails.Count)" -ForegroundColor Cyan
Write-Host "Emails Terrasse du Pont: $($terrasseEmails.Count)" -ForegroundColor Cyan
Write-Host ""
Write-Host "Fichiers crees:"
Write-Host "  - JEROME-ALL-EMAILS.txt"
Write-Host "  - 6PLEX-EMAILS.txt"
Write-Host "  - TERRASSE-DU-PONT-EMAILS.txt"
