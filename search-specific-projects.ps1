# Search for specific projects - 6plex, Terrasse du Pont, 1115 Principale
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

function Search-Project($query, $label) {
    Write-Host "`n========================================" -ForegroundColor Magenta
    Write-Host "  $label" -ForegroundColor Magenta
    Write-Host "========================================" -ForegroundColor Magenta

    $uri = "https://gmail.googleapis.com/gmail/v1/users/me/messages?q=$([uri]::EscapeDataString($query))&maxResults=30"
    $result = Invoke-RestMethod -Uri $uri -Headers $headers

    Write-Host "Trouves: $($result.resultSizeEstimate) emails" -ForegroundColor Cyan

    if ($result.messages) {
        foreach ($msg in $result.messages) {
            $detail = Invoke-RestMethod -Uri "https://gmail.googleapis.com/gmail/v1/users/me/messages/$($msg.id)?format=full" -Headers $headers

            $subject = ($detail.payload.headers | Where-Object { $_.name -eq "Subject" }).value
            $from = ($detail.payload.headers | Where-Object { $_.name -eq "From" }).value
            $date = ($detail.payload.headers | Where-Object { $_.name -eq "Date" }).value

            # Get attachments
            $attachments = @()
            function Get-Attachments($parts) {
                foreach ($part in $parts) {
                    if ($part.filename -and $part.filename -ne "") {
                        $attachments += $part.filename
                    }
                    if ($part.parts) {
                        Get-Attachments $part.parts
                    }
                }
            }
            if ($detail.payload.parts) { Get-Attachments $detail.payload.parts }

            Write-Host "`n---" -ForegroundColor Gray
            Write-Host "DATE: $date" -ForegroundColor Yellow
            Write-Host "FROM: $from"
            Write-Host "SUBJECT: $subject" -ForegroundColor Cyan
            if ($attachments.Count -gt 0) {
                Write-Host "PIECES JOINTES:" -ForegroundColor Green
                $attachments | ForEach-Object { Write-Host "  - $_" -ForegroundColor Green }
            }
            Write-Host "SNIPPET: $($detail.snippet)"
        }
    }
}

# 6PLEX searches
Search-Project "6plex" "6PLEX - TOUS"
Search-Project "6 plex" "6 PLEX (ESPACE)"
Search-Project "sixplex" "SIXPLEX"

# Terrasse du Pont
Search-Project "terrasse du pont" "TERRASSE DU PONT"
Search-Project "terrasse pont" "TERRASSE PONT"

# 1115 Principale (seems related to Terrasse du Pont based on earlier results)
Search-Project "1115 principale" "1115 PRINCIPALE"
Search-Project "saint-zotique" "SAINT-ZOTIQUE"

# Check for evaluation reports
Search-Project "rapport evaluation batiment" "RAPPORT EVAL BATIMENT"
Search-Project "eval veta" "EVAL VETA"
Search-Project "immovex" "IMMOVEX (EVALUATEUR)"
