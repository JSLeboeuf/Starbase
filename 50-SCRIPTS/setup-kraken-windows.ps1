# ============================================================
# 🐙 KRAKEN v14.0 - Windows Setup Script
# ============================================================
# Run as Administrator for full optimization
# Usage: .\setup-kraken-windows.ps1

$ErrorActionPreference = "Continue"

Write-Host @"

    ▄█▀▀▀█▄█   KRAKEN v14.0   ▀████▀▄█▀▀▀█▄█   
   ▄██    ▀█   WINDOWS SETUP    ██ ▄██    ▀█   
   ▀███▄       ===============  ██ ▀███▄       

"@ -ForegroundColor Magenta

Write-Host "=== KRAKEN v14.0 WINDOWS SETUP ===" -ForegroundColor Cyan
Write-Host ""

# ============================================
# 1. ENVIRONMENT VARIABLES (USER)
# ============================================
Write-Host "[1/5] Setting environment variables..." -ForegroundColor Yellow

$envVars = @{
    "NODE_OPTIONS" = "--max-old-space-size=16384"
    "UV_THREADPOOL_SIZE" = "16"
    "npm_config_fund" = "false"
    "npm_config_audit" = "false"
    "PYTHONDONTWRITEBYTECODE" = "1"
    "PYTHONUNBUFFERED" = "1"
    "CLAUDE_CODE_MAX_THINKING_TOKENS" = "32768"
    "CLAUDE_CODE_MAX_OUTPUT_TOKENS" = "16384"
    "CLAUDE_CODE_USE_STREAMING" = "1"
    "CLAUDE_CODE_PARALLEL_TOOLS" = "1"
}

foreach ($key in $envVars.Keys) {
    [Environment]::SetEnvironmentVariable($key, $envVars[$key], "User")
    Write-Host "  [OK] $key" -ForegroundColor Green
}

# ============================================
# 2. GIT OPTIMIZATION
# ============================================
Write-Host ""
Write-Host "[2/5] Optimizing Git..." -ForegroundColor Yellow

$gitConfigs = @(
    "core.preloadindex true",
    "core.fscache true",
    "core.untrackedCache true",
    "gc.auto 256",
    "feature.manyFiles true",
    "index.threads true",
    "pack.threads 0"
)

foreach ($config in $gitConfigs) {
    git config --global $config.Split(" ")[0] $config.Split(" ")[1] 2>$null
}
Write-Host "  [OK] Git optimized" -ForegroundColor Green

# ============================================
# 3. NPM OPTIMIZATION
# ============================================
Write-Host ""
Write-Host "[3/5] Optimizing npm..." -ForegroundColor Yellow

npm config set fund false 2>$null
npm config set audit false 2>$null
npm config set progress false 2>$null
npm config set loglevel warn 2>$null

Write-Host "  [OK] npm optimized" -ForegroundColor Green

# ============================================
# 4. INSTALL TOOLS
# ============================================
Write-Host ""
Write-Host "[4/5] Installing tools..." -ForegroundColor Yellow

# Check for pnpm
$pnpmInstalled = Get-Command pnpm -ErrorAction SilentlyContinue
if (-not $pnpmInstalled) {
    Write-Host "  Installing pnpm..." -ForegroundColor Gray
    npm install -g pnpm 2>$null
}
Write-Host "  [OK] pnpm ready" -ForegroundColor Green

# Check for ccusage
$ccusageInstalled = pip show ccusage 2>$null
if (-not $ccusageInstalled) {
    Write-Host "  Installing ccusage (token monitoring)..." -ForegroundColor Gray
    pip install ccusage 2>$null
}
Write-Host "  [OK] ccusage ready" -ForegroundColor Green

# ============================================
# 5. CREATE ALIASES
# ============================================
Write-Host ""
Write-Host "[5/5] Creating PowerShell aliases..." -ForegroundColor Yellow

$profilePath = $PROFILE
$profileDir = Split-Path $profilePath -Parent

if (-not (Test-Path $profileDir)) {
    New-Item -ItemType Directory -Path $profileDir -Force | Out-Null
}

$aliasContent = @"

# ============================================
# 🐙 KRAKEN v14.0 ALIASES
# ============================================
function kraken { & "$PSScriptRoot\kraken.ps1" @args }
function kraken-fast { & "$PSScriptRoot\kraken.ps1" -Fast @args }
function kraken-deep { & "$PSScriptRoot\kraken.ps1" -Deep @args }
Set-Alias -Name k -Value kraken

# Quick commands
function ccstatus { ccusage status --format=short }

Write-Host "🐙 KRAKEN v14.0 loaded" -ForegroundColor Magenta
"@

# Add to profile if not already there
if (Test-Path $profilePath) {
    $currentProfile = Get-Content $profilePath -Raw
    if ($currentProfile -notmatch "KRAKEN") {
        Add-Content -Path $profilePath -Value $aliasContent
        Write-Host "  [OK] Aliases added to profile" -ForegroundColor Green
    } else {
        Write-Host "  [SKIP] Aliases already in profile" -ForegroundColor Gray
    }
} else {
    Set-Content -Path $profilePath -Value $aliasContent
    Write-Host "  [OK] Profile created with aliases" -ForegroundColor Green
}

# ============================================
# SUMMARY
# ============================================
Write-Host ""
Write-Host "========================================" -ForegroundColor Green
Write-Host "  KRAKEN v14.0 SETUP COMPLETE" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""
Write-Host "Files created:" -ForegroundColor Cyan
Write-Host "  - CLAUDE.md" -ForegroundColor White
Write-Host "  - .cursorrules" -ForegroundColor White
Write-Host "  - kraken.ps1" -ForegroundColor White
Write-Host "  - docs/ai-context/project-structure.md" -ForegroundColor White
Write-Host "  - docs/ai-context/docs-overview.md" -ForegroundColor White
Write-Host ""
Write-Host "Environment optimized:" -ForegroundColor Cyan
Write-Host "  - NODE_OPTIONS: 16GB heap" -ForegroundColor White
Write-Host "  - UV_THREADPOOL: 16 threads" -ForegroundColor White
Write-Host "  - Git: Performance mode" -ForegroundColor White
Write-Host "  - npm: Silent mode" -ForegroundColor White
Write-Host ""
Write-Host "Commands available (after restart):" -ForegroundColor Cyan
Write-Host "  kraken        - Launch Claude Code" -ForegroundColor White
Write-Host "  kraken-fast   - Fast mode" -ForegroundColor White
Write-Host "  kraken-deep   - 32k thinking tokens" -ForegroundColor White
Write-Host "  ccstatus      - Token usage" -ForegroundColor White
Write-Host ""
Write-Host "NEXT: Run ADMIN-OPTIMISATIONS.ps1 as Administrator" -ForegroundColor Yellow
Write-Host "      for Defender exclusions + Ultimate Performance" -ForegroundColor Yellow
Write-Host ""




