# Extract RCLONE_GDRIVE_TOKEN from Infisical
$body = @{
    clientId = "9c0ecdc4-1e5e-4d19-bacc-28b9166739a6"
    clientSecret = "2424d678bd9055c39518cc7298952bc8c81183da1e3fd98d40b8b19a4cb64436"
} | ConvertTo-Json

$authResponse = Invoke-RestMethod -Uri "https://app.infisical.com/api/v1/auth/universal-auth/login" -Method POST -Body $body -ContentType "application/json"
$token = $authResponse.accessToken

$secretsUrl = "https://app.infisical.com/api/v3/secrets/raw?workspaceId=5915781f-9d5a-459e-9cf7-c4663c1e4a1e&environment=dev"
$headers = @{ Authorization = "Bearer $token" }
$secretsResponse = Invoke-RestMethod -Uri $secretsUrl -Headers $headers

# Find RCLONE_GDRIVE_TOKEN
$rcloneToken = $secretsResponse.secrets | Where-Object { $_.secretKey -eq "RCLONE_GDRIVE_TOKEN" }
if ($rcloneToken) {
    Write-Host "Found RCLONE_GDRIVE_TOKEN"
    $tokenJson = $rcloneToken.secretValue
    Write-Host $tokenJson

    # Parse the token
    $tokenData = $tokenJson | ConvertFrom-Json

    # Create credentials file for Google Workspace MCP
    $credentialsPath = "C:\Users\Utilisateur\.google_workspace_mcp\credentials"

    # Create the token file in the format expected by the MCP
    $googleCreds = @{
        token = $tokenData.access_token
        refresh_token = $tokenData.refresh_token
        token_uri = "https://oauth2.googleapis.com/token"
        client_id = "154462178720-uenso1nn6rvd21tfo6dtcm07hspb81hl.apps.googleusercontent.com"
        client_secret = "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"
        scopes = @(
            "https://www.googleapis.com/auth/gmail.readonly"
            "https://www.googleapis.com/auth/gmail.send"
            "https://www.googleapis.com/auth/drive.readonly"
            "https://www.googleapis.com/auth/drive.file"
        )
        expiry = $tokenData.expiry
    }

    $googleCreds | ConvertTo-Json -Depth 10 | Out-File "$credentialsPath\token.json" -Encoding UTF8
    Write-Host "Token saved to $credentialsPath\token.json"
}
