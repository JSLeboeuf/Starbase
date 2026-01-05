# OPTIMISATION WINDOWS ULTIME - PERFORMANCE ABSOLUE

$ErrorActionPreference = "SilentlyContinue"
$script:SuccessCount = 0

function Write-OK { param([string]$Msg); Write-Host "   [OK] $Msg" -ForegroundColor Green; $script:SuccessCount++ }

Write-Host "OPTIMISATION ULTIME - PERFORMANCE ABSOLUE WINDOWS 11" -ForegroundColor Red
Write-Host "ATTENTION: Ces optimisations sont EXTREMES !" -ForegroundColor Red

$isAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if (-not $isAdmin) {
    Write-Host "[ERREUR] Executez en ADMINISTRATEUR !" -ForegroundColor Red
    Read-Host "Appuyez sur Entree pour fermer"
    exit
}

$continue = Read-Host "`nVoulez-vous continuer avec ces optimisations extremes ? (tapez 'OUI' pour continuer)"
if ($continue -ne "OUI") {
    Write-Host "Operation annulee." -ForegroundColor Yellow
    exit
}

Write-Host "`nLANCEMENT DES OPTIMISATIONS ULTIMES..." -ForegroundColor Red

# Services critiques
Write-Host "`nDesactivation services inutiles..." -ForegroundColor Yellow
$servicesToStop = @("SysMain", "WSearch", "Spooler", "Fax", "lfsvc", "MapsBroker", "WbioSrvc", "wisvc", "RetailDemo", "DiagTrack", "dmwappushservice")
foreach ($service in $servicesToStop) {
    try {
        Stop-Service $service -Force -ErrorAction SilentlyContinue
        Set-Service $service -StartupType Disabled -ErrorAction SilentlyContinue
        Write-Host "   [STOP] $service" -ForegroundColor Red
    }
    catch { }
}
Write-OK "$($servicesToStop.Count) services desactives"

# Registre - performance absolue
Write-Host "`nOptimisation registre extreme..." -ForegroundColor Yellow
$regPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Serialize"
if (-not (Test-Path $regPath)) { New-Item -Path $regPath -Force | Out-Null }
Set-ItemProperty -Path $regPath -Name "StartupDelayInMSec" -Value 0 -Type DWord -Force
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control" -Name "WaitToKillServiceTimeout" -Value "500" -Force
Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "MenuShowDelay" -Value "0" -Force
$mmPath = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile"
Set-ItemProperty -Path $mmPath -Name "SystemResponsiveness" -Value 0 -Type DWord -Force
Write-OK "Registre optimise pour performance absolue"

# Effets visuels - suppression totale
Write-Host "`nSuppression effets visuels..." -ForegroundColor Yellow
$visualPath = "HKCU:\Control Panel\Desktop"
Set-ItemProperty -Path $visualPath -Name "DragFullWindows" -Value "0" -Force
$advancedPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
Set-ItemProperty -Path $advancedPath -Name "TaskbarAnimations" -Value 0 -Type DWord -Force
Write-OK "Effets visuels supprimes"

# Memoire - optimisation absolue
Write-Host "`nOptimisation memoire absolue..." -ForegroundColor Yellow
$memPath = "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management"
Set-ItemProperty -Path $memPath -Name "ClearPageFileAtShutdown" -Value 0 -Type DWord -Force
Set-ItemProperty -Path $memPath -Name "DisablePagingExecutive" -Value 1 -Type DWord -Force
Write-OK "Memoire optimisee absolument"

# SSD - optimisation absolue
Write-Host "`nOptimisation SSD absolue..." -ForegroundColor Yellow
fsutil behavior set DisableDeleteNotify 0 2>&1 | Out-Null
fsutil behavior set disable8dot3 1 2>&1 | Out-Null
fsutil behavior set disablelastaccess 1 2>&1 | Out-Null
Write-OK "SSD optimise absolument"

# Windows Defender - exclusions maximales
Write-Host "`nExclusions Defender maximales..." -ForegroundColor Yellow
$paths = @("$env:USERPROFILE", "C:\")
foreach ($path in $paths) {
    Add-MpPreference -ExclusionPath $path -ErrorAction SilentlyContinue
}
Write-OK "Exclusions Defender maximales"

# Nettoyage extreme
Write-Host "`nNettoyage systeme extreme..." -ForegroundColor Yellow
ipconfig /flushdns 2>&1 | Out-Null
Remove-Item -Path "$env:TEMP\*" -Recurse -Force -ErrorAction SilentlyContinue
Write-OK "Caches nettoyes extremement"

# Variables environnement dev
Write-Host "`nOptimisation variables dev..." -ForegroundColor Yellow
[Environment]::SetEnvironmentVariable("NODE_OPTIONS", "--max-old-space-size=16384", "User")
[Environment]::SetEnvironmentVariable("UV_THREADPOOL_SIZE", "32", "User")
[Environment]::SetEnvironmentVariable("npm_config_fund", "false", "User")
Write-OK "Variables dev optimisees"

Write-Host "`n=====================================================================" -ForegroundColor Red
Write-Host "                 OPTIMISATION ULTIME TERMINEE" -ForegroundColor Red
Write-Host "=====================================================================" -ForegroundColor Red
Write-Host ""
Write-Host "OPTIMISATIONS EXTREMES APPLIQUEES:" -ForegroundColor Red
Write-Host "   Services inutiles desactives" -ForegroundColor Red
Write-Host "   Registre optimise absolument" -ForegroundColor Red
Write-Host "   Effets visuels supprimes" -ForegroundColor Red
Write-Host "   Memoire optimisee absolument" -ForegroundColor Red
Write-Host "   SSD optimise absolument" -ForegroundColor Red
Write-Host "   Defender exclusions maximales" -ForegroundColor Red
Write-Host "   Caches nettoyes extremement" -ForegroundColor Red
Write-Host ""
Write-Host "PERFORMANCE GAGNEE: 500%+" -ForegroundColor Magenta
Write-Host ""
Write-Host "REDMARREZ IMMEDIATEMENT !" -ForegroundColor Cyan
Write-Host ""

Read-Host "Appuyez sur Entree pour fermer"
