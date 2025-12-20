# List ALL Infisical secrets
$body = @{
    clientId = "9c0ecdc4-1e5e-4d19-bacc-28b9166739a6"
    clientSecret = "2424d678bd9055c39518cc7298952bc8c81183da1e3fd98d40b8b19a4cb64436"
} | ConvertTo-Json

$auth = Invoke-RestMethod -Uri "https://app.infisical.com/api/v1/auth/universal-auth/login" -Method POST -Body $body -ContentType "application/json"
$token = $auth.accessToken

# Get all secrets
$secrets = Invoke-RestMethod -Uri "https://app.infisical.com/api/v3/secrets/raw?workspaceId=5915781f-9d5a-459e-9cf7-c4663c1e4a1e&environment=dev" -Headers @{Authorization="Bearer $token"}

Write-Host "=== ALL SECRETS (searching for credentials JSON) ===" -ForegroundColor Cyan
Write-Host "Total: $($secrets.secrets.Count) secrets" -ForegroundColor Yellow
Write-Host ""

foreach ($secret in $secrets.secrets) {
    $key = $secret.secretKey
    $value = $secret.secretValue

    # Check if value looks like JSON credentials
    if ($value -like "*client_id*" -or $value -like "*client_secret*" -or $value -like "*installed*" -or $value -like "*web*" -or $key -like "*CRED*" -or $key -like "*JSON*" -or $key -like "*OAUTH*" -or $key -like "*KEY_FILE*") {
        Write-Host ">>> $key <<<" -ForegroundColor Green
        if ($value.Length -gt 200) {
            Write-Host $value.Substring(0, 200) -ForegroundColor Gray
            Write-Host "..."
        } else {
            Write-Host $value -ForegroundColor Gray
        }
        Write-Host ""
    }
}

Write-Host ""
Write-Host "=== ALL SECRET NAMES ===" -ForegroundColor Cyan
$secrets.secrets | ForEach-Object { Write-Host $_.secretKey }
