# Infisical API Script
$body = @{
    clientId = "9c0ecdc4-1e5e-4d19-bacc-28b9166739a6"
    clientSecret = "2424d678bd9055c39518cc7298952bc8c81183da1e3fd98d40b8b19a4cb64436"
} | ConvertTo-Json

Write-Host "Authenticating with Infisical..."
$authResponse = Invoke-RestMethod -Uri "https://app.infisical.com/api/v1/auth/universal-auth/login" -Method POST -Body $body -ContentType "application/json"
$token = $authResponse.accessToken
Write-Host "Token obtained!"

Write-Host "Fetching secrets..."
$secretsUrl = "https://app.infisical.com/api/v3/secrets/raw?workspaceId=5915781f-9d5a-459e-9cf7-c4663c1e4a1e&environment=dev"
$headers = @{ Authorization = "Bearer $token" }
$secretsResponse = Invoke-RestMethod -Uri $secretsUrl -Headers $headers

Write-Host "`n=== SECRETS FOUND ==="
foreach ($secret in $secretsResponse.secrets) {
    $key = $secret.secretKey
    $value = $secret.secretValue
    if ($value.Length -gt 100) {
        $displayValue = $value.Substring(0, 100) + "..."
    } else {
        $displayValue = $value
    }
    Write-Host "$key = $displayValue"
}

# Export to JSON file
$secretsResponse | ConvertTo-Json -Depth 10 | Out-File "C:\Users\Utilisateur\jerome\infisical-secrets.json"
Write-Host "`nSecrets exported to infisical-secrets.json"
