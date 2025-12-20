# Search for evaluation reports more specifically
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

function Search-WithAttachments($query, $label) {
    Write-Host "`n========================================" -ForegroundColor Magenta
    Write-Host "  $label" -ForegroundColor Magenta
    Write-Host "========================================" -ForegroundColor Magenta

    $uri = "https://gmail.googleapis.com/gmail/v1/users/me/messages?q=$([uri]::EscapeDataString($query))&maxResults=50"
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

# Specific searches for evaluations
Search-WithAttachments "avalisation rapport" "AVALISATION RAPPORT"
Search-WithAttachments "rapport evaluation has:attachment" "RAPPORT EVALUATION AVEC PJ"
Search-WithAttachments "evaluation immobiliere has:attachment" "EVALUATION IMMOBILIERE AVEC PJ"
Search-WithAttachments "evaluateur agree" "EVALUATEUR AGREE"
Search-WithAttachments "valeur marchande" "VALEUR MARCHANDE"
Search-WithAttachments "appraisal" "APPRAISAL"
Search-WithAttachments "go dentiste" "GO DENTISTE"
Search-WithAttachments "clinique dentaire valleyfield" "CLINIQUE DENTAIRE VALLEYFIELD"
Search-WithAttachments "dentiste langlois OR dentiste monseigneur" "DENTISTE LANGLOIS"
Search-WithAttachments "6plex has:attachment" "6PLEX AVEC PIECES JOINTES"
Search-WithAttachments "terrasse du pont has:attachment" "TERRASSE DU PONT AVEC PJ"
Search-WithAttachments "1115 principale" "1115 PRINCIPALE (TERRASSE DU PONT?)"
