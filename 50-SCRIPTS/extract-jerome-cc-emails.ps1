# Extract all emails where Jerome (jlevac@mkmg.ca) is in CC
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

# Update token file
$tokenFile.token = $accessToken
$tokenFile.expiry = (Get-Date).AddSeconds($response.expires_in).ToString("yyyy-MM-ddTHH:mm:ss.ffffffzzz")
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
        $decoded = $detail.payload.body.data.Replace('-','+').Replace('_','/')
        $body = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($decoded))
    } elseif ($detail.payload.parts) {
        foreach ($part in $detail.payload.parts) {
            if ($part.mimeType -eq "text/plain" -and $part.body.data) {
                $decoded = $part.body.data.Replace('-','+').Replace('_','/')
                $body = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($decoded))
                break
            } elseif ($part.parts) {
                foreach ($subpart in $part.parts) {
                    if ($subpart.mimeType -eq "text/plain" -and $subpart.body.data) {
                        $decoded = $subpart.body.data.Replace('-','+').Replace('_','/')
                        $body = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($decoded))
                        break
                    }
                }
            }
        }
    }

    Write-Host "============================================================" -ForegroundColor Cyan
    Write-Host "FROM: $from" -ForegroundColor Yellow
    Write-Host "TO: $to" -ForegroundColor Yellow
    Write-Host "CC: $cc" -ForegroundColor Magenta
    Write-Host "DATE: $date"
    Write-Host "SUBJECT: $subject" -ForegroundColor Green
    Write-Host "------------------------------------------------------------"
    if ($body) { Write-Host $body } else { Write-Host $detail.snippet }
    Write-Host ""

    return @{
        from = $from
        to = $to
        cc = $cc
        date = $date
        subject = $subject
        body = if ($body) { $body } else { $detail.snippet }
    }
}

Write-Host "========================================" -ForegroundColor Magenta
Write-Host "  EMAILS OU JEROME EST EN CC           " -ForegroundColor Magenta
Write-Host "  (jlevac@mkmg.ca)                     " -ForegroundColor Magenta
Write-Host "========================================" -ForegroundColor Magenta

# Search for emails where Jerome is CC'd
$allEmails = @()
$pageToken = $null
$totalFound = 0

do {
    $uri = "https://gmail.googleapis.com/gmail/v1/users/me/messages?q=cc:jlevac@mkmg.ca&maxResults=100"
    if ($pageToken) {
        $uri += "&pageToken=$pageToken"
    }

    $result = Invoke-RestMethod -Uri $uri -Headers $headers

    if ($result.messages) {
        $totalFound += $result.messages.Count
        Write-Host "Found batch of $($result.messages.Count) emails (total: $totalFound)" -ForegroundColor Cyan

        foreach ($msg in $result.messages) {
            $emailData = Get-FullEmail $msg.id
            $allEmails += $emailData
        }
    }

    $pageToken = $result.nextPageToken
} while ($pageToken)

Write-Host "`n========================================" -ForegroundColor Green
Write-Host "  TOTAL: $totalFound emails with Jerome in CC" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green

# Save to file
$outputFile = "C:\Users\Utilisateur\jerome\JEROME-CC-EMAILS.txt"
$output = @()
$output += "============================================"
$output += "EMAILS OU JEROME (jlevac@mkmg.ca) EST EN CC"
$output += "Extracted: $(Get-Date)"
$output += "Total: $totalFound emails"
$output += "============================================"
$output += ""

foreach ($email in $allEmails) {
    $output += "============================================================"
    $output += "FROM: $($email.from)"
    $output += "TO: $($email.to)"
    $output += "CC: $($email.cc)"
    $output += "DATE: $($email.date)"
    $output += "SUBJECT: $($email.subject)"
    $output += "------------------------------------------------------------"
    $output += $email.body
    $output += ""
}

$output | Out-File $outputFile -Encoding UTF8
Write-Host "`nSaved to: $outputFile" -ForegroundColor Green
