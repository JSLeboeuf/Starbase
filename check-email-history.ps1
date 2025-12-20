# Check full email history
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

# Get total email count
Write-Host "=== STATISTIQUES DE LA BOITE MAIL ===" -ForegroundColor Cyan
$profile = Invoke-RestMethod -Uri "https://gmail.googleapis.com/gmail/v1/users/me/profile" -Headers $headers
Write-Host "Total messages: $($profile.messagesTotal)"
Write-Host "Email: $($profile.emailAddress)"

# Search oldest emails
Write-Host "`n=== PLUS VIEUX EMAILS ===" -ForegroundColor Yellow
$result = Invoke-RestMethod -Uri "https://gmail.googleapis.com/gmail/v1/users/me/messages?q=older_than:5y&maxResults=10" -Headers $headers
Write-Host "Emails de plus de 5 ans: $($result.resultSizeEstimate)"

# Check emails by year
Write-Host "`n=== EMAILS PAR ANNEE ===" -ForegroundColor Magenta
$years = @(2020, 2021, 2022, 2023, 2024, 2025)
foreach ($year in $years) {
    $query = "after:$year/01/01 before:$year/12/31"
    $result = Invoke-RestMethod -Uri "https://gmail.googleapis.com/gmail/v1/users/me/messages?q=$([uri]::EscapeDataString($query))&maxResults=1" -Headers $headers
    Write-Host "$year : $($result.resultSizeEstimate) emails"
}

# Check Jerome by year
Write-Host "`n=== EMAILS AVEC JEROME PAR ANNEE ===" -ForegroundColor Green
foreach ($year in $years) {
    $query = "(from:jlevac@mkmg.ca OR to:jlevac@mkmg.ca OR cc:jlevac@mkmg.ca) after:$year/01/01 before:$year/12/31"
    $result = Invoke-RestMethod -Uri "https://gmail.googleapis.com/gmail/v1/users/me/messages?q=$([uri]::EscapeDataString($query))&maxResults=1" -Headers $headers
    Write-Host "$year : $($result.resultSizeEstimate) emails avec Jerome"
}

# Get the absolute oldest email
Write-Host "`n=== PREMIER EMAIL DE LA BOITE ===" -ForegroundColor Cyan
$result = Invoke-RestMethod -Uri "https://gmail.googleapis.com/gmail/v1/users/me/messages?maxResults=500" -Headers $headers
$allIds = @()
$pageToken = $null

# Get last page (oldest emails)
do {
    $uri = "https://gmail.googleapis.com/gmail/v1/users/me/messages?maxResults=500"
    if ($pageToken) { $uri += "&pageToken=$pageToken" }
    $result = Invoke-RestMethod -Uri $uri -Headers $headers
    $allIds = $result.messages
    $pageToken = $result.nextPageToken
    Write-Host "Scanning... $($allIds.Count) messages in current batch"
} while ($pageToken)

# Get the last (oldest) email details
if ($allIds.Count -gt 0) {
    $oldestId = $allIds[-1].id
    $oldest = Invoke-RestMethod -Uri "https://gmail.googleapis.com/gmail/v1/users/me/messages/$oldestId`?format=metadata&metadataHeaders=Date&metadataHeaders=Subject&metadataHeaders=From" -Headers $headers
    $date = ($oldest.payload.headers | Where-Object { $_.name -eq "Date" }).value
    $subject = ($oldest.payload.headers | Where-Object { $_.name -eq "Subject" }).value
    $from = ($oldest.payload.headers | Where-Object { $_.name -eq "From" }).value
    Write-Host "Plus vieux email trouve:"
    Write-Host "  Date: $date"
    Write-Host "  From: $from"
    Write-Host "  Subject: $subject"
}

# Check first Jerome email more precisely
Write-Host "`n=== PREMIER EMAIL AVEC JEROME (DETAIL) ===" -ForegroundColor Yellow
$query = "from:jlevac@mkmg.ca OR to:jlevac@mkmg.ca OR cc:jlevac@mkmg.ca"
$allJerome = @()
$pageToken = $null

do {
    $uri = "https://gmail.googleapis.com/gmail/v1/users/me/messages?q=$([uri]::EscapeDataString($query))&maxResults=500"
    if ($pageToken) { $uri += "&pageToken=$pageToken" }
    $result = Invoke-RestMethod -Uri $uri -Headers $headers
    if ($result.messages) { $allJerome += $result.messages }
    $pageToken = $result.nextPageToken
} while ($pageToken)

Write-Host "Total emails avec Jerome: $($allJerome.Count)"

# Get oldest Jerome email
if ($allJerome.Count -gt 0) {
    $oldestJeromeId = $allJerome[-1].id
    $oldestJerome = Invoke-RestMethod -Uri "https://gmail.googleapis.com/gmail/v1/users/me/messages/$oldestJeromeId`?format=full" -Headers $headers
    $date = ($oldestJerome.payload.headers | Where-Object { $_.name -eq "Date" }).value
    $subject = ($oldestJerome.payload.headers | Where-Object { $_.name -eq "Subject" }).value
    $from = ($oldestJerome.payload.headers | Where-Object { $_.name -eq "From" }).value
    $to = ($oldestJerome.payload.headers | Where-Object { $_.name -eq "To" }).value

    Write-Host "`nPREMIER EMAIL AVEC JEROME:"
    Write-Host "  Date: $date" -ForegroundColor Green
    Write-Host "  From: $from"
    Write-Host "  To: $to"
    Write-Host "  Subject: $subject"
}
