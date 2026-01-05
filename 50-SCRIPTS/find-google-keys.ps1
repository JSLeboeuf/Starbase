# Find all Google-related secrets in Infisical
$body = @{
    clientId = "9c0ecdc4-1e5e-4d19-bacc-28b9166739a6"
    clientSecret = "2424d678bd9055c39518cc7298952bc8c81183da1e3fd98d40b8b19a4cb64436"
} | ConvertTo-Json

$authResponse = Invoke-RestMethod -Uri "https://app.infisical.com/api/v1/auth/universal-auth/login" -Method POST -Body $body -ContentType "application/json"
$token = $authResponse.accessToken

$secretsUrl = "https://app.infisical.com/api/v3/secrets/raw?workspaceId=5915781f-9d5a-459e-9cf7-c4663c1e4a1e&environment=dev"
$headers = @{ Authorization = "Bearer $token" }
$secretsResponse = Invoke-RestMethod -Uri $secretsUrl -Headers $headers

Write-Host "=== ALL GOOGLE-RELATED SECRETS ===" -ForegroundColor Cyan
Write-Host ""

$googleSecrets = $secretsResponse.secrets | Where-Object { $_.secretKey -like "*GOOGLE*" -or $_.secretKey -like "*OAUTH*" -or $_.secretKey -like "*GMAIL*" -or $_.secretKey -like "*GDRIVE*" -or $_.secretKey -like "*CREDENTIAL*" }

foreach ($secret in $googleSecrets) {
    Write-Host "$($secret.secretKey):" -ForegroundColor Yellow
    $value = $secret.secretValue
    if ($value.Length -gt 80) {
        Write-Host "  $($value.Substring(0, 80))..." -ForegroundColor Gray
    } else {
        Write-Host "  $value" -ForegroundColor Gray
    }
    Write-Host ""
}

# Also look for JSON-like secrets that might contain credentials
Write-Host "=== SECRETS CONTAINING JSON (potential credential files) ===" -ForegroundColor Cyan
$jsonSecrets = $secretsResponse.secrets | Where-Object { $_.secretValue -like "*{*" -and $_.secretValue -like "*}*" }
foreach ($secret in $jsonSecrets) {
    Write-Host "$($secret.secretKey)" -ForegroundColor Yellow
}
