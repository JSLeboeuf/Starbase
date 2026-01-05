# Search for evaluations - 6plex and Go Dentiste Monseigneur Langlois
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

    # Check for attachments
    $attachments = @()
    if ($detail.payload.parts) {
        foreach ($part in $detail.payload.parts) {
            if ($part.filename -and $part.filename -ne "") {
                $attachments += $part.filename
            }
            if ($part.parts) {
                foreach ($subpart in $part.parts) {
                    if ($subpart.filename -and $subpart.filename -ne "") {
                        $attachments += $subpart.filename
                    }
                }
            }
        }
    }

    return @{
        from = $from
        to = $to
        cc = $cc
        date = $date
        subject = $subject
        body = $body
        attachments = $attachments
    }
}

function Search-AndDisplay($query, $label) {
    Write-Host "`n========================================" -ForegroundColor Magenta
    Write-Host "  $label" -ForegroundColor Magenta
    Write-Host "  Query: $query" -ForegroundColor Gray
    Write-Host "========================================" -ForegroundColor Magenta

    $allMessages = @()
    $pageToken = $null

    do {
        $uri = "https://gmail.googleapis.com/gmail/v1/users/me/messages?q=$([uri]::EscapeDataString($query))&maxResults=100"
        if ($pageToken) { $uri += "&pageToken=$pageToken" }
        $result = Invoke-RestMethod -Uri $uri -Headers $headers
        if ($result.messages) { $allMessages += $result.messages }
        $pageToken = $result.nextPageToken
    } while ($pageToken)

    Write-Host "Total: $($allMessages.Count) emails trouves" -ForegroundColor Green

    foreach ($msg in $allMessages) {
        try {
            $email = Get-FullEmail $msg.id
            Write-Host "`n------------------------------------------------------------" -ForegroundColor Gray
            Write-Host "DATE: $($email.date)" -ForegroundColor Yellow
            Write-Host "FROM: $($email.from)"
            Write-Host "TO: $($email.to)"
            Write-Host "SUBJECT: $($email.subject)" -ForegroundColor Cyan
            if ($email.attachments.Count -gt 0) {
                Write-Host "PIECES JOINTES: $($email.attachments -join ', ')" -ForegroundColor Green
            }
            Write-Host "---"
            Write-Host $email.body.Substring(0, [Math]::Min(1000, $email.body.Length))
        } catch {
            Write-Host "Erreur: $_" -ForegroundColor Red
        }
    }

    return $allMessages.Count
}

# 1. EVALUATION 6PLEX
Write-Host "============================================" -ForegroundColor Cyan
Write-Host "  RECHERCHE EVALUATIONS" -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan

Search-AndDisplay "6plex evaluation OR 6plex évaluation OR 6-plex evaluation" "EVALUATION 6PLEX"
Search-AndDisplay "6plex rapport OR 6plex estimé OR 6plex valeur" "VALEUR 6PLEX"
Search-AndDisplay "terrasse du pont evaluation OR terrasse pont évaluation" "EVALUATION TERRASSE DU PONT"

# 2. GO DENTISTE / MONSEIGNEUR LANGLOIS
Search-AndDisplay "go dentiste evaluation OR go dentiste évaluation" "EVALUATION GO DENTISTE"
Search-AndDisplay "monseigneur langlois evaluation OR mgr langlois évaluation OR 785 langlois" "785 MGR LANGLOIS"
Search-AndDisplay "785 bd mgr langlois OR 785 boulevard monseigneur" "785 BD MGR LANGLOIS - TOUS"
Search-AndDisplay "dentiste langlois OR clinique dentaire langlois OR clinique dentaire valleyfield" "CLINIQUE DENTAIRE VALLEYFIELD"

# 3. General evaluation searches
Search-AndDisplay "rapport évaluation immobilière OR rapport evaluation immobiliere" "RAPPORTS EVALUATION IMMOBILIERE"
Search-AndDisplay "évaluateur agréé OR evaluateur agree" "EVALUATEUR AGREE"
Search-AndDisplay "valeur marchande immeuble" "VALEUR MARCHANDE"
