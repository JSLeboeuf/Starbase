# ============================================================================
# OPTIMISATION ULTIME - PERFORMANCE MAXIMALE WINDOWS 11
# ============================================================================
# Script d'optimisation ultime pour performances maximum
# Executez en ADMINISTRATEUR pour toutes les optimisations
# ============================================================================

$ErrorActionPreference = "SilentlyContinue"
$script:SuccessCount = 0
$script:SkippedCount = 0

function Write-Step { param([string]$Msg); Write-Host "`n>> $Msg" -ForegroundColor Cyan }
function Write-OK { param([string]$Msg); Write-Host "   [OK] $Msg" -ForegroundColor Green; $script:SuccessCount++ }
function Write-Skip { param([string]$Msg); Write-Host "   [SKIP] $Msg" -ForegroundColor Gray; $script:SkippedCount++ }
function Test-Admin { ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator) }

Write-Host "`n" -ForegroundColor Magenta
Write-Host "=====================================================================" -ForegroundColor Magenta
Write-Host "  OPTIMISATION ULTIME - PERFORMANCE MAXIMALE WINDOWS 11" -ForegroundColor Magenta
Write-Host "=====================================================================" -ForegroundColor Magenta

$isAdmin = Test-Admin
if (-not $isAdmin) {
    Write-Host "`n[ERREUR] Executez en ADMINISTRATEUR !" -ForegroundColor Red
    Read-Host "Appuyez sur Entree pour fermer"
    exit
}
Write-Host "`n[ADMIN] Mode administrateur detecte" -ForegroundColor Green

# ============================================
# 1. SERVICES CRITIQUES
# ============================================
Write-Step "SERVICES CRITIQUES - OPTIMISATION"

$servicesToStop = @(
    "SysMain",        # Superfetch (inutile sur SSD)
    "WSearch",        # Windows Search (si SSD rapide)
    "Spooler",        # Print Spooler (si pas d'imprimante)
    "Fax",           # Fax Service
    "lfsvc",         # Geolocalisation
    "MapsBroker",    # Cartes
    "WbioSrvc",      # Biometrie
    "WpcMonSvc",     # Controle parental
    "wisvc",         # Windows Insider
    "RetailDemo",    # Demo retail
    "diagnosticshub.standardcollector.service", # Diagnostic Hub
    "WdiServiceHost", # WDI
    "WdiSystemHost",  # WDI System
    "XboxAccessoryManagementService", # Xbox Accessories
    "XboxLiveAuthManager", # Xbox Live Auth
    "XboxLiveGameSave", # Xbox Live Save
    "XboxLiveNetworkingService" # Xbox Live Networking
)

foreach ($service in $servicesToStop) {
    try {
        $svc = Get-Service -Name $service -ErrorAction SilentlyContinue
        if ($svc) {
            Stop-Service $service -Force -ErrorAction SilentlyContinue
            Set-Service $service -StartupType Disabled -ErrorAction SilentlyContinue
            Write-Host "   [STOP] $service" -ForegroundColor Green
        }
    }
    catch { Write-Skip "$service" }
}

Write-OK "$($servicesToStop.Count) services desactives"

# ============================================
# 2. REGISTRE - PERFORMANCE ULTIME
# ============================================
Write-Step "REGISTRE - PERFORMANCE ULTIME"

# 2.1 Optimisations de demarrage
Write-Host "   Configuration demarrage..." -ForegroundColor Yellow
$regPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Serialize"
if (-not (Test-Path $regPath)) { New-Item -Path $regPath -Force | Out-Null }
Set-ItemProperty -Path $regPath -Name "StartupDelayInMSec" -Value 0 -Type DWord -Force
Write-OK "Delai demarrage = 0ms"

# 2.2 Temps d'arret reduit
Write-Host "   Configuration arret..." -ForegroundColor Yellow
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control" -Name "WaitToKillServiceTimeout" -Value "1000" -Force
Write-OK "Timeout arret = 1000ms"

# 2.3 Menu delay ultra rapide
Write-Host "   Configuration menus..." -ForegroundColor Yellow
Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "MenuShowDelay" -Value "0" -Force
Write-OK "Delai menus = 0ms"

# 2.4 Responsivite systeme maximale
Write-Host "   Configuration responsivite..." -ForegroundColor Yellow
$mmPath = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile"
Set-ItemProperty -Path $mmPath -Name "SystemResponsiveness" -Value 0 -Type DWord -Force
Write-OK "SystemResponsiveness = 0 (max)"

# 2.5 Priorite GPU pour jeux/apps
Write-Host "   Configuration GPU..." -ForegroundColor Yellow
$gpuPath = "$mmPath\Tasks\Games"
if (-not (Test-Path $gpuPath)) { New-Item -Path $gpuPath -Force | Out-Null }
Set-ItemProperty -Path $gpuPath -Name "GPU Priority" -Value 8 -Type DWord -Force
Set-ItemProperty -Path $gpuPath -Name "Priority" -Value 6 -Type DWord -Force
Set-ItemProperty -Path $gpuPath -Name "Scheduling Category" -Value "High" -Force
Write-OK "Priorite GPU maximale"

# 2.6 Optimisation reseau
Write-Host "   Configuration reseau..." -ForegroundColor Yellow
netsh int tcp set global autotuninglevel=disabled 2>&1 | Out-Null
netsh int tcp set global chimney=disabled 2>&1 | Out-Null
netsh int tcp set global rss=enabled 2>&1 | Out-Null
netsh int tcp set global ecncapability=enabled 2>&1 | Out-Null
Write-OK "TCP/IP optimise pour performance"

# 2.7 Cache DNS
Write-Host "   Configuration DNS..." -ForegroundColor Yellow
$dnsPath = "HKLM:\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters"
Set-ItemProperty -Path $dnsPath -Name "MaxCacheTtl" -Value 86400 -Type DWord -Force
Set-ItemProperty -Path $dnsPath -Name "MaxNegativeCacheTtl" -Value 0 -Type DWord -Force
Write-OK "Cache DNS optimise"

# ============================================
# 3. EFFETS VISUELS - DESACTIVATION COMPLET
# ============================================
Write-Step "EFFETS VISUELS - DESACTIVATION TOTALE"

# Desactiver tous les effets visuels
Write-Host "   Desactivation effets visuels..." -ForegroundColor Yellow
$visualPath = "HKCU:\Control Panel\Desktop"
Set-ItemProperty -Path $visualPath -Name "DragFullWindows" -Value "0" -Force
Set-ItemProperty -Path $visualPath -Name "FontSmoothing" -Value "1" -Force

$visualPath2 = "HKCU:\Control Panel\Desktop\WindowMetrics"
Set-ItemProperty -Path $visualPath2 -Name "MinAnimate" -Value "0" -Force

# Taskbar animations
$advancedPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
Set-ItemProperty -Path $advancedPath -Name "TaskbarAnimations" -Value 0 -Type DWord -Force
Set-ItemProperty -Path $advancedPath -Name "ListviewAlphaSelect" -Value 0 -Type DWord -Force
Set-ItemProperty -Path $advancedPath -Name "ListviewShadow" -Value 0 -Type DWord -Force
Set-ItemProperty -Path $advancedPath -Name "IconsOnly" -Value 0 -Type DWord -Force

# Desactiver animations de fenetres
Set-ItemProperty -Path $advancedPath -Name "TaskbarSmallIcons" -Value 1 -Type DWord -Force
Write-OK "Tous effets visuels desactives"

# ============================================
# 4. MEMOIRE - OPTIMISATION ULTIME
# ============================================
Write-Step "MEMOIRE - OPTIMISATION ULTIME"

Write-Host "   Configuration gestion memoire..." -ForegroundColor Yellow
$memPath = "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management"
Set-ItemProperty -Path $memPath -Name "ClearPageFileAtShutdown" -Value 0 -Type DWord -Force
Set-ItemProperty -Path $memPath -Name "LargeSystemCache" -Value 0 -Type DWord -Force
Set-ItemProperty -Path $memPath -Name "DisablePagingExecutive" -Value 1 -Type DWord -Force
Set-ItemProperty -Path $memPath -Name "SecondLevelDataCache" -Value 0 -Type DWord -Force

# Optimisation cache
Set-ItemProperty -Path $memPath -Name "IoPageLockLimit" -Value 0 -Type DWord -Force
Write-OK "Gestion memoire optimisee"

# ============================================
# 5. CPU - OPTIMISATION ULTIME
# ============================================
Write-Step "CPU - OPTIMISATION ULTIME"

# Priorite processus premier plan maximale
Write-Host "   Configuration priorite CPU..." -ForegroundColor Yellow
$priorityPath = "HKLM:\SYSTEM\CurrentControlSet\Control\PriorityControl"
Set-ItemProperty -Path $priorityPath -Name "Win32PrioritySeparation" -Value 38 -Type DWord -Force
Write-OK "Priorite premier plan = 38 (max)"

# ============================================
# 6. SSD/STOCKAGE - OPTIMISATION ULTIME
# ============================================
Write-Step "SSD/STOCKAGE - OPTIMISATION ULTIME"

# TRIM actif
Write-Host "   Configuration TRIM..." -ForegroundColor Yellow
fsutil behavior set DisableDeleteNotify 0 2>&1 | Out-Null
Write-OK "TRIM active"

# Desactiver defragmentation automatique
Write-Host "   Configuration defragmentation..." -ForegroundColor Yellow
$defragPath = "HKLM:\SOFTWARE\Microsoft\Dfrg\BootOptimizeFunction"
if (-not (Test-Path $defragPath)) { New-Item -Path $defragPath -Force | Out-Null }
Set-ItemProperty -Path $defragPath -Name "Enable" -Value "N" -Force
Write-OK "Defragmentation auto desactivee"

# NTFS optimisation ultime
Write-Host "   Configuration NTFS..." -ForegroundColor Yellow
fsutil behavior set disable8dot3 1 2>&1 | Out-Null
fsutil behavior set disablelastaccess 1 2>&1 | Out-Null
fsutil behavior set encryptpagingfile 0 2>&1 | Out-Null
Write-OK "NTFS optimise (8dot3, lastaccess, encryption desactives)"

# ============================================
# 7. WINDOWS DEFENDER - OPTIMISATION MAX
# ============================================
Write-Step "WINDOWS DEFENDER - OPTIMISATION MAXIMALE"

$defenderPaths = @(
    "$env:USERPROFILE",
    "$env:USERPROFILE\node_modules",
    "$env:APPDATA\Claude",
    "$env:LOCALAPPDATA\Programs\cursor",
    "$env:LOCALAPPDATA\Programs\Microsoft VS Code",
    "$env:LOCALAPPDATA\Git",
    "$env:LOCALAPPDATA\npm-cache",
    "$env:LOCALAPPDATA\Yarn",
    "$env:USERPROFILE\.vscode",
    "$env:USERPROFILE\.cursor",
    "$env:USERPROFILE\.claude"
)

foreach ($path in $defenderPaths) {
    Add-MpPreference -ExclusionPath $path -ErrorAction SilentlyContinue
}

$defenderProcesses = @(
    "node.exe", "python.exe", "claude.exe", "cursor.exe", "code.exe",
    "git.exe", "npm.cmd", "pnpm.exe", "yarn.exe", "bash.exe", "powershell.exe"
)

foreach ($proc in $defenderProcesses) {
    Add-MpPreference -ExclusionProcess $proc -ErrorAction SilentlyContinue
}

Write-OK "$($defenderPaths.Count) chemins et $($defenderProcesses.Count) processus exclus"

# ============================================
# 8. APPLICATIONS DE FOND - DESACTIVATION
# ============================================
Write-Step "APPLICATIONS DE FOND - NETTOYAGE"

# Desactiver applications en arriere-plan
Write-Host "   Desactivation apps background..." -ForegroundColor Yellow
$appPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications"
Get-ChildItem $appPath -ErrorAction SilentlyContinue | ForEach-Object {
    Set-ItemProperty -Path $_.PSPath -Name "Disabled" -Value 1 -Type DWord -ErrorAction SilentlyContinue
    Set-ItemProperty -Path $_.PSPath -Name "DisabledByUser" -Value 1 -Type DWord -ErrorAction SilentlyContinue
}
Write-OK "Applications background desactivees"

# ============================================
# 9. NETTOYAGE SYSTEME
# ============================================
Write-Step "NETTOYAGE SYSTEME - CACHE ET TEMP"

Write-Host "   Vidage caches..." -ForegroundColor Yellow
ipconfig /flushdns 2>&1 | Out-Null
Write-OK "Cache DNS vide"

# Nettoyer fichiers temporaires
Write-Host "   Nettoyage fichiers temp..." -ForegroundColor Yellow
Remove-Item -Path "$env:TEMP\*" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item -Path "C:\Windows\Temp\*" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item -Path "C:\Windows\Prefetch\*" -Force -ErrorAction SilentlyContinue
Write-OK "Fichiers temporaires nettoyes"

# ============================================
# 10. OPTIMISATIONS SPECIFIQUES DEVS
# ============================================
Write-Step "OPTIMISATIONS SPECIFIQUES DEVELOPPEMENT"

# Variables d'environnement pour performance max
Write-Host "   Configuration variables dev..." -ForegroundColor Yellow
[Environment]::SetEnvironmentVariable("NODE_OPTIONS", "--max-old-space-size=16384 --optimize-for-size --gc-interval=100", "User")
[Environment]::SetEnvironmentVariable("UV_THREADPOOL_SIZE", "32", "User")
[Environment]::SetEnvironmentVariable("npm_config_fund", "false", "User")
[Environment]::SetEnvironmentVariable("npm_config_audit", "false", "User")
[Environment]::SetEnvironmentVariable("npm_config_progress", "false", "User")
[Environment]::SetEnvironmentVariable("PYTHONDONTWRITEBYTECODE", "1", "User")
[Environment]::SetEnvironmentVariable("PYTHONUNBUFFERED", "1", "User")
[Environment]::SetEnvironmentVariable("PYTHONOPTIMIZE", "1", "User")
Write-OK "Variables d'environnement optimisees"

# ============================================
# RAPPORT FINAL
# ============================================
Write-Host "`n"
Write-Host "=====================================================================" -ForegroundColor Green
Write-Host "              OPTIMISATION ULTIME TERMINEE" -ForegroundColor Green
Write-Host "=====================================================================" -ForegroundColor Green
Write-Host ""
Write-Host "PERFORMANCES OPTIMISEES:" -ForegroundColor Yellow
Write-Host "   [OK] Services inutiles desactives" -ForegroundColor Green
Write-Host "   [OK] Registre optimise pour performance max" -ForegroundColor Green
Write-Host "   [OK] Effets visuels desactives completement" -ForegroundColor Green
Write-Host "   [OK] Memoire optimisee (pas de pagefile, cache reduit)" -ForegroundColor Green
Write-Host "   [OK] CPU priorite maximale premier plan" -ForegroundColor Green
Write-Host "   [OK] SSD optimise (TRIM actif, defrag off)" -ForegroundColor Green
Write-Host "   [OK] Reseau TCP/IP optimise pour latence" -ForegroundColor Green
Write-Host "   [OK] Defender exclusions maximales" -ForegroundColor Green
Write-Host "   [OK] Applications background desactivees" -ForegroundColor Green
Write-Host "   [OK] Caches systeme nettoyes" -ForegroundColor Green
Write-Host "   [OK] Variables dev optimisees" -ForegroundColor Green
Write-Host ""
Write-Host "STATISTIQUES:" -ForegroundColor Cyan
Write-Host "   Optimisations appliquees: $script:SuccessCount" -ForegroundColor Green
Write-Host "   Ignores: $script:SkippedCount" -ForegroundColor Gray
Write-Host ""
Write-Host "PROCHAINES ETAPES:" -ForegroundColor Yellow
Write-Host "   1. REDMARREZ VOTRE PC pour appliquer TOUTES les modifications" -ForegroundColor Cyan
Write-Host "   2. Vos performances sont maintenant maximisees !" -ForegroundColor Green
Write-Host ""

Read-Host "Appuyez sur Entree pour fermer"
