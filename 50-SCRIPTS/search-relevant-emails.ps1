# Search for relevant emails about Cédric, Jérôme, VETA, immobilier
$tokenFile = Get-Content "C:\Users\Utilisateur\.google_workspace_mcp\credentials\token.json" | ConvertFrom-Json
$accessToken = $tokenFile.token
$headers = @{ Authorization = "Bearer $accessToken" }

$searches = @(
    "Cédric",
    "Cedric",
    "Jérôme",
    "Jerome",
    "VETA",
    "Valleyfield",
    "immobilier",
    "48 portes",
    "actionnaire",
    "equity",
    "parts",
    "Félix",
    "Felix"
)

$allEmails = @()

foreach ($query in $searches) {
    Write-Host "Searching for: $query" -ForegroundColor Yellow
    try {
        $encoded = [uri]::EscapeDataString($query)
        $result = Invoke-RestMethod -Uri "https://gmail.googleapis.com/gmail/v1/users/me/messages?q=$encoded&maxResults=10" -Headers $headers

        if ($result.messages) {
            Write-Host "  Found $($result.messages.Count) emails" -ForegroundColor Green
            $allEmails += $result.messages
        } else {
            Write-Host "  No emails found" -ForegroundColor Gray
        }
    } catch {
        Write-Host "  Error: $_" -ForegroundColor Red
    }
}

# Remove duplicates
$uniqueEmails = $allEmails | Sort-Object -Property id -Unique

Write-Host ""
Write-Host "=== RELEVANT EMAILS FOUND: $($uniqueEmails.Count) ===" -ForegroundColor Cyan
Write-Host ""

# Get details
foreach ($msg in $uniqueEmails | Select-Object -First 30) {
    try {
        $detail = Invoke-RestMethod -Uri "https://gmail.googleapis.com/gmail/v1/users/me/messages/$($msg.id)?format=full" -Headers $headers

        $subject = ($detail.payload.headers | Where-Object { $_.name -eq "Subject" }).value
        $from = ($detail.payload.headers | Where-Object { $_.name -eq "From" }).value
        $to = ($detail.payload.headers | Where-Object { $_.name -eq "To" }).value
        $date = ($detail.payload.headers | Where-Object { $_.name -eq "Date" }).value

        # Get body snippet
        $snippet = $detail.snippet

        Write-Host "========================================" -ForegroundColor Gray
        Write-Host "From: $from" -ForegroundColor Yellow
        Write-Host "To: $to" -ForegroundColor Yellow
        Write-Host "Subject: $subject" -ForegroundColor Cyan
        Write-Host "Date: $date"
        Write-Host "Preview: $snippet"
        Write-Host ""
    } catch {
        Write-Host "Error getting email $($msg.id): $_" -ForegroundColor Red
    }
}
