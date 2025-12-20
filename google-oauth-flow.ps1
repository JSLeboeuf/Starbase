# Google OAuth Flow - Manual Authentication
$clientId = "154462178720-uenso1nn6rvd21tfo6dtcm07hspb81hl.apps.googleusercontent.com"
$clientSecret = "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"
$redirectUri = "http://localhost:8080"
$scope = "https://www.googleapis.com/auth/gmail.readonly https://www.googleapis.com/auth/drive.readonly"

# Build authorization URL
$authUrl = "https://accounts.google.com/o/oauth2/v2/auth?" + `
    "client_id=$clientId&" + `
    "redirect_uri=$redirectUri&" + `
    "response_type=code&" + `
    "scope=$([uri]::EscapeDataString($scope))&" + `
    "access_type=offline&" + `
    "prompt=consent"

Write-Host "=== GOOGLE OAUTH AUTHENTICATION ===" -ForegroundColor Cyan
Write-Host ""
Write-Host "1. Opening browser for Google authentication..."
Start-Process $authUrl

Write-Host ""
Write-Host "2. After you authorize, you'll be redirected to a localhost URL that won't load."
Write-Host "   Copy the FULL URL from the browser address bar."
Write-Host ""
$redirectedUrl = Read-Host "3. Paste the full redirected URL here"

# Extract authorization code
if ($redirectedUrl -match "code=([^&]+)") {
    $authCode = $matches[1]
    Write-Host ""
    Write-Host "Authorization code extracted!" -ForegroundColor Green

    # Exchange code for token
    Write-Host "Exchanging code for access token..."

    $tokenBody = @{
        code = $authCode
        client_id = $clientId
        client_secret = $clientSecret
        redirect_uri = $redirectUri
        grant_type = "authorization_code"
    }

    try {
        $response = Invoke-RestMethod -Uri "https://oauth2.googleapis.com/token" -Method POST -Body $tokenBody

        Write-Host "SUCCESS! Token obtained!" -ForegroundColor Green

        # Save token
        $tokenData = @{
            token = $response.access_token
            refresh_token = $response.refresh_token
            token_uri = "https://oauth2.googleapis.com/token"
            client_id = $clientId
            client_secret = $clientSecret
            scopes = $scope.Split(" ")
            expiry = (Get-Date).AddSeconds($response.expires_in).ToString("yyyy-MM-ddTHH:mm:ss.ffffffzzz")
        }

        $tokenPath = "C:\Users\Utilisateur\.google_workspace_mcp\credentials\token.json"
        $tokenData | ConvertTo-Json -Depth 10 | Out-File $tokenPath -Encoding UTF8

        Write-Host ""
        Write-Host "Token saved to: $tokenPath" -ForegroundColor Green
        Write-Host "You can now restart Claude Code to use Gmail and Drive!"

    } catch {
        Write-Host "Error exchanging code: $_" -ForegroundColor Red
    }
} else {
    Write-Host "Could not extract authorization code from URL" -ForegroundColor Red
}
