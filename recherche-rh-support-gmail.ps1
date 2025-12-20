# Script pour rechercher tous les emails Gmail liés à RH Support
# Utilise l'API Gmail avec les tokens OAuth existants

$tokenPath = "$env:USERPROFILE\.google_workspace_mcp\credentials\token.json"
$tokenData = Get-Content $tokenPath | ConvertFrom-Json

# Fonction pour rafraîchir le token si nécessaire
function Get-AccessToken {
    $expiry = [DateTime]::Parse($tokenData.expiry_date)
    $now = Get-Date
    
    if ($now -ge $expiry) {
        Write-Host "Token expiré, rafraîchissement..." -ForegroundColor Yellow
        
        $body = @{
            client_id = $tokenData.client_id
            client_secret = $tokenData.client_secret
            refresh_token = $tokenData.refresh_token
            grant_type = "refresh_token"
        }
        
        $response = Invoke-RestMethod -Uri "https://oauth2.googleapis.com/token" -Method Post -Body $body -ContentType "application/x-www-form-urlencoded"
        
        $tokenData.access_token = $response.access_token
        $tokenData.expiry_date = (Get-Date).AddSeconds($response.expires_in).ToString("o")
        
        $tokenData | ConvertTo-Json -Depth 10 | Set-Content $tokenPath
    }
    
    return $tokenData.access_token
}

$accessToken = Get-AccessToken
$headers = @{
    "Authorization" = "Bearer $accessToken"
    "Content-Type" = "application/json"
}

Write-Host "========================================" -ForegroundColor Magenta
Write-Host "  RECHERCHE EMAILS RH SUPPORT GMAIL    " -ForegroundColor Magenta
Write-Host "========================================" -ForegroundColor Magenta

# Recherches multiples pour RH Support
$queries = @(
    "RH Support",
    "rhsupport",
    "rh support",
    "RHSUPPORT",
    "RH Support Inc",
    "subject:RH Support",
    "from:rhsupport",
    "to:rhsupport"
)

$allEmails = @()
$totalFound = 0

foreach ($query in $queries) {
    Write-Host "`nRecherche: '$query'..." -ForegroundColor Cyan
    
    $pageToken = $null
    $batchCount = 0
    
    do {
        $uri = "https://gmail.googleapis.com/gmail/v1/users/me/messages?q=" + [System.Web.HttpUtility]::UrlEncode($query) + "&maxResults=500"
        if ($pageToken) {
            $uri += "&pageToken=$pageToken"
        }
        
        try {
            $result = Invoke-RestMethod -Uri $uri -Headers $headers -Method Get
            
            if ($result.messages) {
                $batchCount += $result.messages.Count
                $totalFound += $result.messages.Count
                Write-Host "  Trouvé: $($result.messages.Count) emails (total: $totalFound)" -ForegroundColor Green
                
                foreach ($msg in $result.messages) {
                    if ($allEmails.id -notcontains $msg.id) {
                        $allEmails += $msg
                    }
                }
            }
            
            $pageToken = $result.nextPageToken
        } catch {
            Write-Host "  Erreur: $_" -ForegroundColor Red
            break
        }
    } while ($pageToken)
    
    Write-Host "  Total pour '$query': $batchCount emails" -ForegroundColor Yellow
}

Write-Host "`n========================================" -ForegroundColor Green
Write-Host "Total emails uniques trouvés: $($allEmails.Count)" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green

# Trier par date (plus récent en premier)
$allEmails = $allEmails | Sort-Object -Property id -Descending

# Fonction pour obtenir les détails complets d'un email
function Get-EmailDetails {
    param($messageId)
    
    try {
        $uri = "https://gmail.googleapis.com/gmail/v1/users/me/messages/$messageId?format=full"
        $msg = Invoke-RestMethod -Uri $uri -Headers $headers -Method Get
        
        $headers = @{}
        foreach ($h in $msg.payload.headers) {
            $headers[$h.name] = $h.value
        }
        
        # Extraire le corps
        $body = ""
        if ($msg.payload.body.data) {
            $body = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($msg.payload.body.data))
        } elseif ($msg.payload.parts) {
            foreach ($part in $msg.payload.parts) {
                if ($part.mimeType -eq "text/plain" -and $part.body.data) {
                    $body = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($part.body.data))
                    break
                } elseif ($part.mimeType -eq "text/html" -and $part.body.data) {
                    $htmlBody = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($part.body.data))
                    # Extraire le texte du HTML
                    $body = $htmlBody -replace '<[^>]+>', ''
                    break
                }
            }
        }
        
        return @{
            id = $messageId
            from = $headers["From"]
            to = $headers["To"]
            cc = $headers["Cc"]
            subject = $headers["Subject"]
            date = $headers["Date"]
            body = $body
            snippet = $msg.snippet
        }
    } catch {
        Write-Host "Erreur pour email $messageId : $_" -ForegroundColor Red
        return $null
    }
}

# Extraire les détails de tous les emails
Write-Host "`nExtraction des détails des emails..." -ForegroundColor Yellow
$emailDetails = @()
$counter = 0

foreach ($email in $allEmails) {
    $counter++
    if ($counter % 10 -eq 0) {
        Write-Host "  Traitement: $counter / $($allEmails.Count)..." -ForegroundColor Gray
    }
    
    $details = Get-EmailDetails $email.id
    if ($details) {
        $emailDetails += $details
    }
    
    # Pause pour éviter de dépasser les limites de l'API
    Start-Sleep -Milliseconds 100
}

# Trier par date
$emailDetails = $emailDetails | Sort-Object -Property date -Descending

# Sauvegarder dans un fichier
$outputFile = "RH-SUPPORT-TOUS-EMAILS-GMAIL.txt"
$output = @"
============================================
EMAILS RH SUPPORT - GMAIL
Extracted: $(Get-Date -Format "MM/dd/yyyy HH:mm:ss")
Total: $($emailDetails.Count) emails
============================================

"@

foreach ($email in $emailDetails) {
    $output += @"

============================================================
FROM: $($email.from)
TO: $($email.to)
$(if ($email.cc) { "CC: $($email.cc)`n" })
DATE: $($email.date)
SUBJECT: $($email.subject)
------------------------------------------------------------
$($email.body)
"@
}

$output | Out-File -FilePath $outputFile -Encoding UTF8

Write-Host "`n========================================" -ForegroundColor Green
Write-Host "Fichier sauvegardé: $outputFile" -ForegroundColor Green
Write-Host "Total emails: $($emailDetails.Count)" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green

# Afficher un résumé par date
Write-Host "`nRÉSUMÉ PAR DATE:" -ForegroundColor Cyan
$emailDetails | Group-Object -Property { ($_.date -split ',')[0] } | Sort-Object Name -Descending | ForEach-Object {
    Write-Host "  $($_.Name): $($_.Count) emails" -ForegroundColor White
}





