# EXECUTION DE TOUTES LES OPTIMISATIONS

Write-Host "EXECUTION COMPLETE DE TOUTES LES OPTIMISATIONS" -ForegroundColor Cyan
Write-Host ""

$confirmation = Read-Host "ATTENTION: Cette operation va appliquer TOUTES les optimisations. Continuer ? (OUI/NON)"
if ($confirmation -ne "OUI") {
    Write-Host "Operation annulee." -ForegroundColor Yellow
    exit
}

Write-Host "DEBUT DE L'EXECUTION..." -ForegroundColor Green

# 1. Verification actuelle
Write-Host "`n1. VERIFICATION ACTUELLE..." -ForegroundColor Yellow
$verifPath = "$PSScriptRoot\VERIFICATION-SIMPLE.ps1"
if (Test-Path $verifPath) {
    & $verifPath
}

# 2. Optimisations de base
Write-Host "`n2. OPTIMISATIONS DE BASE..." -ForegroundColor Yellow
$basePath = "$PSScriptRoot\OPTIMISATION-COMPLETE-PERFORMANCE.ps1"
if (Test-Path $basePath) {
    & $basePath
    Write-Host "Optimisations de base terminees" -ForegroundColor Green
}

# 3. Optimisations avancees
Write-Host "`n3. OPTIMISATIONS AVANCEES CURSOR/CLAUDE..." -ForegroundColor Yellow
$advancedPath = "$PSScriptRoot\OPTIMISATION-AVANCEE-CURSOR-CLAUDE.ps1"
if (Test-Path $advancedPath) {
    & $advancedPath
    Write-Host "Optimisations avancees terminees" -ForegroundColor Green
}

# 4. Configuration Claude
Write-Host "`n4. CONFIGURATION CLAUDE AUTONOMIE..." -ForegroundColor Yellow
$claudePath = "$PSScriptRoot\CLAUDE-AUTONOMIE-MAXIMALE.ps1"
if (Test-Path $claudePath) {
    & $claudePath -Mode architect -Deep
    Write-Host "Configuration Claude terminee" -ForegroundColor Green
}

# 5. Verification finale
Write-Host "`n5. VERIFICATION FINALE..." -ForegroundColor Yellow
$finalPath = "$PSScriptRoot\VERIFICATION-SIMPLE.ps1"
if (Test-Path $finalPath) {
    & $finalPath
}

Write-Host "`nTOUTES LES OPTIMISATIONS ONT ETE APPLIQUEES !" -ForegroundColor Green
Write-Host "Redemarrez votre PC pour appliquer tous les changements." -ForegroundColor Cyan

Read-Host "Appuyez sur Entree pour fermer"
