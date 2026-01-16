# ============================================================================
# SCRIPT DE VERIFICATION RAPIDE - PERFORMANCE SYSTEME
# ============================================================================
# Vérifie rapidement l'état de toutes les optimisations
# ============================================================================

$ErrorActionPreference = "SilentlyContinue"

Write-Host "`n"
Write-Host "=====================================================================" -ForegroundColor Cyan
Write-Host "  VERIFICATION RAPIDE - OPTIMISATIONS PERFORMANCE" -ForegroundColor Cyan
Write-Host "=====================================================================" -ForegroundColor Cyan
Write-Host ""

# 1. Plan alimentation
Write-Host "PLAN ALIMENTATION:" -ForegroundColor Yellow
$activePlan = powercfg /getactivescheme 2>&1
if ($activePlan -match "Ultimate Performance" -or $activePlan -match "e9a42b02") {
    Write-Host "   [OK] Ultimate Performance actif" -ForegroundColor Green
} else {
    Write-Host "   [INFO] $activePlan" -ForegroundColor Yellow
}

# 2. Variables d'environnement
Write-Host "`nVARIABLES D'ENVIRONNEMENT:" -ForegroundColor Yellow
$envVars = @(
    @{Name="NODE_OPTIONS"; Expected="--max-old-space-size=16384"},
    @{Name="npm_config_fund"; Expected="false"},
    @{Name="npm_config_audit"; Expected="false"},
    @{Name="UV_THREADPOOL_SIZE"; Expected="16"},
    @{Name="PYTHONDONTWRITEBYTECODE"; Expected="1"},
    @{Name="PYTHONUNBUFFERED"; Expected="1"}
)

$envOk = 0
foreach ($var in $envVars) {
    $value = [Environment]::GetEnvironmentVariable($var.Name, "User")
    if ($value -eq $var.Expected) {
        Write-Host "   [OK] $($var.Name)" -ForegroundColor Green
        $envOk++
    } else {
        Write-Host "   [MANQUANT] $($var.Name)" -ForegroundColor Red
    }
}
Write-Host "   $envOk/$($envVars.Count) variables configurees" -ForegroundColor $(if ($envOk -eq $envVars.Count) { "Green" } else { "Yellow" })

# 3. Exclusions Defender (si admin)
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if ($isAdmin) {
    Write-Host "`nEXCLUSIONS DEFENDER:" -ForegroundColor Yellow
    try {
        $exclusions = Get-MpPreference | Select-Object -ExpandProperty ExclusionPath
        $processes = Get-MpPreference | Select-Object -ExpandProperty ExclusionProcess
        Write-Host "   [OK] $($exclusions.Count) chemins exclus" -ForegroundColor Green
        Write-Host "   [OK] $($processes.Count) processus exclus" -ForegroundColor Green
    } catch {
        Write-Host "   [ERREUR] Impossible de verifier" -ForegroundColor Red
    }
} else {
    Write-Host "`nEXCLUSIONS DEFENDER:" -ForegroundColor Yellow
    Write-Host "   [SKIP] Verification necessite droits admin" -ForegroundColor Gray
}

# 4. Configuration Git
Write-Host "`nCONFIGURATION GIT:" -ForegroundColor Yellow
try {
    $gitPreload = git config --global --get core.preloadindex 2>&1
    $gitFscache = git config --global --get core.fscache 2>&1
    if ($gitPreload -eq "true" -and $gitFscache -eq "true") {
        Write-Host "   [OK] Git optimise" -ForegroundColor Green
    } else {
        Write-Host "   [INFO] Git non optimise" -ForegroundColor Yellow
    }
} catch {
    Write-Host "   [SKIP] Git non detecte" -ForegroundColor Gray
}

# 5. Configuration npm
Write-Host "`nCONFIGURATION NPM:" -ForegroundColor Yellow
try {
    $npmFund = npm config get fund 2>&1
    $npmAudit = npm config get audit 2>&1
    if ($npmFund -eq "false" -and $npmAudit -eq "false") {
        Write-Host "   [OK] npm optimise" -ForegroundColor Green
    } else {
        Write-Host "   [INFO] npm non optimise" -ForegroundColor Yellow
    }
} catch {
    Write-Host "   [SKIP] npm non detecte" -ForegroundColor Gray
}

# 6. Ressources système
Write-Host "`nRESSOURCES SYSTÈME:" -ForegroundColor Yellow
try {
    $ram = [math]::Round((Get-CimInstance Win32_ComputerSystem).TotalPhysicalMemory / 1GB, 1)
    $cpu = (Get-CimInstance Win32_Processor | Select-Object -First 1).Name
    $cores = (Get-CimInstance Win32_Processor | Select-Object -First 1).NumberOfLogicalProcessors
    Write-Host "   RAM: $ram GB" -ForegroundColor White
    Write-Host "   CPU: $cpu" -ForegroundColor White
    Write-Host "   Threads: $cores" -ForegroundColor White
} catch {
    Write-Host "   [ERREUR] Impossible de recuperer les infos" -ForegroundColor Red
}

Write-Host "`n=====================================================================" -ForegroundColor Cyan
Write-Host ""


