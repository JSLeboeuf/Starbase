# Refresh Google OAuth Token
$tokenFile = "C:\Users\Utilisateur\.google_workspace_mcp\credentials\token.json"
$currentToken = Get-Content $tokenFile | ConvertFrom-Json

$refreshBody = @{
    client_id = $currentToken.client_id
    client_secret = $currentToken.client_secret
    refresh_token = $currentToken.refresh_token
    grant_type = "refresh_token"
}

Write-Host "Refreshing Google OAuth token..."
try {
    $response = Invoke-RestMethod -Uri "https://oauth2.googleapis.com/token" -Method POST -Body $refreshBody -ContentType "application/x-www-form-urlencoded"

    Write-Host "New access token obtained!"

    # Update token file
    $currentToken.token = $response.access_token
    $currentToken.expiry = (Get-Date).AddSeconds($response.expires_in).ToString("yyyy-MM-ddTHH:mm:ss.ffffffzzz")

    $currentToken | ConvertTo-Json -Depth 10 | Out-File $tokenFile -Encoding UTF8
    Write-Host "Token file updated with new expiry: $($currentToken.expiry)"
    Write-Host "SUCCESS!"
} catch {
    Write-Host "Error refreshing token: $_"
}
