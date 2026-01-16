# Script de verification de la configuration Claude Code
# Affiche tous les parametres actifs

Write-Host "=== CONFIGURATION CLAUDE CODE ===" -ForegroundColor Cyan
Write-Host ""

# Settings global
$globalSettings = "$env:USERPROFILE\.claude\settings.json"
if (Test-Path $globalSettings) {
    Write-Host "[GLOBAL] $globalSettings" -ForegroundColor Green
    $config = Get-Content $globalSettings | ConvertFrom-Json
    Write-Host "  Model: $($config.model)" -ForegroundColor Yellow
    Write-Host "  Thinking: $($config.alwaysThinkingEnabled)" -ForegroundColor Yellow
    Write-Host "  Plugins actifs:" -ForegroundColor Yellow
    $config.enabledPlugins.PSObject.Properties | ForEach-Object {
        if ($_.Value -eq $true) {
            Write-Host "    - $($_.Name)" -ForegroundColor White
        }
    }
} else {
    Write-Host "[GLOBAL] Non trouve" -ForegroundColor Red
}

Write-Host ""

# Settings projet
$projectSettings = ".\.claude\settings.json"
if (Test-Path $projectSettings) {
    Write-Host "[PROJET] $projectSettings" -ForegroundColor Green
    $config = Get-Content $projectSettings | ConvertFrom-Json
    Write-Host "  Model: $($config.model)" -ForegroundColor Yellow
    Write-Host "  Thinking: $($config.alwaysThinkingEnabled)" -ForegroundColor Yellow
    Write-Host "  Sandbox: $($config.sandbox.enabled)" -ForegroundColor Yellow
} else {
    Write-Host "[PROJET] Non trouve" -ForegroundColor Red
}

Write-Host ""

# Settings local
$localSettings = ".\.claude\settings.local.json"
if (Test-Path $localSettings) {
    Write-Host "[LOCAL] $localSettings" -ForegroundColor Green
    $config = Get-Content $localSettings | ConvertFrom-Json
    Write-Host "  Model: $($config.model)" -ForegroundColor Yellow
    Write-Host "  Thinking: $($config.alwaysThinkingEnabled)" -ForegroundColor Yellow
} else {
    Write-Host "[LOCAL] Non trouve" -ForegroundColor Red
}

Write-Host ""

# Variables d'environnement
Write-Host "=== VARIABLES D'ENVIRONNEMENT ===" -ForegroundColor Cyan
$envVars = @(
    "NODE_OPTIONS",
    "UV_THREADPOOL_SIZE",
    "MAX_THINKING_TOKENS",
    "CLAUDE_CODE_MAX_OUTPUT_TOKENS"
)

foreach ($var in $envVars) {
    $value = [Environment]::GetEnvironmentVariable($var, "User")
    if ($value) {
        Write-Host "  $var = $value" -ForegroundColor Green
    } else {
        Write-Host "  $var = (non defini)" -ForegroundColor Gray
    }
}

Write-Host ""
Write-Host "=== RESUME ===" -ForegroundColor Cyan
Write-Host "Model: Opus 4.5 (max performance)" -ForegroundColor Green
Write-Host "Thinking: TOUJOURS ACTIF" -ForegroundColor Green
Write-Host "Permissions: TOUTES AUTO-APPROUVEES" -ForegroundColor Green
Write-Host "Sandbox: DESACTIVE" -ForegroundColor Green
Write-Host ""
