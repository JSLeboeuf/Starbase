# Get the specific evaluation email from Valerie
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

function Get-FullEmailWithLinks($query, $label) {
    Write-Host "`n========================================" -ForegroundColor Magenta
    Write-Host "  $label" -ForegroundColor Magenta
    Write-Host "========================================" -ForegroundColor Magenta

    $uri = "https://gmail.googleapis.com/gmail/v1/users/me/messages?q=$([uri]::EscapeDataString($query))&maxResults=20"
    $result = Invoke-RestMethod -Uri $uri -Headers $headers

    Write-Host "Trouves: $($result.resultSizeEstimate) emails" -ForegroundColor Cyan

    if ($result.messages) {
        foreach ($msg in $result.messages) {
            $detail = Invoke-RestMethod -Uri "https://gmail.googleapis.com/gmail/v1/users/me/messages/$($msg.id)?format=full" -Headers $headers

            $subject = ($detail.payload.headers | Where-Object { $_.name -eq "Subject" }).value
            $from = ($detail.payload.headers | Where-Object { $_.name -eq "From" }).value
            $to = ($detail.payload.headers | Where-Object { $_.name -eq "To" }).value
            $date = ($detail.payload.headers | Where-Object { $_.name -eq "Date" }).value

            # Get full body
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
                        $attachments += $part.filename
                    }
                    if ($part.parts) {
                        Get-Attachments $part.parts
                    }
                }
            }
            if ($detail.payload.parts) { Get-Attachments $detail.payload.parts }

            Write-Host "`n============================================================" -ForegroundColor Cyan
            Write-Host "DATE: $date" -ForegroundColor Yellow
            Write-Host "FROM: $from" -ForegroundColor Yellow
            Write-Host "TO: $to"
            Write-Host "SUBJECT: $subject" -ForegroundColor Green

            if ($attachments.Count -gt 0) {
                Write-Host "PIECES JOINTES:" -ForegroundColor Magenta
                $attachments | ForEach-Object { Write-Host "  - $_" -ForegroundColor Magenta }
            }

            Write-Host "------------------------------------------------------------"
            Write-Host $body
            Write-Host ""
        }
    }
}

# Search for specific emails
Get-FullEmailWithLinks "from:valerie 1115 principale evaluation" "VALERIE - 1115 PRINCIPALE EVALUATION"
Get-FullEmailWithLinks "from:valerie rapport evaluation batiment veta" "VALERIE - RAPPORT EVAL BATIMENT VETA"
Get-FullEmailWithLinks "from:valerie@rhsupport.ca 1115" "VALERIE RH - 1115"
Get-FullEmailWithLinks "1115 principale evaluation" "1115 PRINCIPALE EVALUATION"
Get-FullEmailWithLinks "rapport evaluation 1115" "RAPPORT EVAL 1115"
Get-FullEmailWithLinks "evaluation batiment veta" "EVALUATION BATIMENT VETA"
Get-FullEmailWithLinks "financement 6plex" "FINANCEMENT 6PLEX"
