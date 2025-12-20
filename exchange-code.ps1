# Exchange authorization code for token - AUTOSCALE_MASTER
param([string]$code)

$clientId = "767920457238-eu3b18esg22fhrrv3djbargbgfvp22jg.apps.googleusercontent.com"
$clientSecret = "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"
$redirectUri = "http://localhost"

Write-Host "Exchanging code for token..." -ForegroundColor Cyan

$tokenBody = @{
    code = $code
    client_id = $clientId
    client_secret = $clientSecret
    redirect_uri = $redirectUri
    grant_type = "authorization_code"
}

try {
    $response = Invoke-RestMethod -Uri "https://oauth2.googleapis.com/token" -Method POST -Body $tokenBody

    Write-Host "SUCCESS!" -ForegroundColor Green

    $tokenData = @{
        token = $response.access_token
        refresh_token = $response.refresh_token
        token_uri = "https://oauth2.googleapis.com/token"
        client_id = $clientId
        client_secret = $clientSecret
        scopes = @(
            "https://www.googleapis.com/auth/gmail.readonly"
            "https://www.googleapis.com/auth/drive.readonly"
            "https://www.googleapis.com/auth/calendar.readonly"
        )
        expiry = (Get-Date).AddSeconds($response.expires_in).ToString("yyyy-MM-ddTHH:mm:ss.ffffffzzz")
    }

    $tokenPath = "C:\Users\Utilisateur\.google_workspace_mcp\credentials\token.json"
    $tokenData | ConvertTo-Json -Depth 10 | Out-File $tokenPath -Encoding UTF8

    Write-Host "Token saved to: $tokenPath" -ForegroundColor Green
    Write-Host ""
    Write-Host "Access Token: $($response.access_token.Substring(0,50))..." -ForegroundColor Gray
    Write-Host "Refresh Token: $($response.refresh_token.Substring(0,30))..." -ForegroundColor Gray

} catch {
    Write-Host "Error: $_" -ForegroundColor Red
}
