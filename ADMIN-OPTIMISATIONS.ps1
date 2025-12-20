# OPTIMISATIONS ADMIN - Executer en tant qu'administrateur
# Clic droit > Executer en tant qu'administrateur

Write-Host "=== OPTIMISATIONS ADMIN ===" -ForegroundColor Cyan
Write-Host ""

# 1. Plan Ultimate Performance
Write-Host "[1/2] Activation Plan Ultimate Performance..." -ForegroundColor Yellow
try {
    powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61
    Write-Host "  [OK] Plan Ultimate Performance cree" -ForegroundColor Green
} catch {
    Write-Host "  [SKIP] Deja existe ou erreur" -ForegroundColor Gray
}

# 2. Exclusions Defender
Write-Host "[2/2] Ajout exclusions Windows Defender..." -ForegroundColor Yellow
try {
    Add-MpPreference -ExclusionPath "$env:USERPROFILE"
    Add-MpPreference -ExclusionPath "$env:USERPROFILE\node_modules"
    Add-MpPreference -ExclusionPath "$env:APPDATA\Claude"
    Add-MpPreference -ExclusionProcess "node.exe"
    Add-MpPreference -ExclusionProcess "python.exe"
    Add-MpPreference -ExclusionProcess "claude.exe"
    Add-MpPreference -ExclusionProcess "cursor.exe"
    Add-MpPreference -ExclusionProcess "code.exe"
    Add-MpPreference -ExclusionProcess "git.exe"
    Add-MpPreference -ExclusionProcess "npm.cmd"
    Add-MpPreference -ExclusionProcess "pnpm.exe"
    Write-Host "  [OK] Exclusions Defender ajoutees" -ForegroundColor Green
} catch {
    Write-Host "  [ERREUR] Verifiez que vous etes admin" -ForegroundColor Red
}

Write-Host ""
Write-Host "=== TERMINE ===" -ForegroundColor Green
Write-Host "Redemarrez votre PC pour effet complet." -ForegroundColor Magenta
Read-Host "Appuyez sur Entree pour fermer"




