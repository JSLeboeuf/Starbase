# ============================================================================
# OPTIMISATION AVANCEE - CURSOR + CLAUDE CODE + AGENTIC DEV
# ============================================================================
# Script d'optimisation maximale pour le developpement agentic
# Executez en ADMINISTRATEUR pour toutes les optimisations
# ============================================================================

$ErrorActionPreference = "Continue"
$script:SuccessCount = 0
$script:SkipCount = 0

function Write-Step {
    param([string]$Message)
    Write-Host "`n>> $Message" -ForegroundColor Cyan
}

function Write-OK {
    param([string]$Message)
    Write-Host "   [OK] $Message" -ForegroundColor Green
    $script:SuccessCount++
}

function Write-Skip {
    param([string]$Message)
    Write-Host "   [SKIP] $Message" -ForegroundColor Gray
    $script:SkipCount++
}

function Test-Admin {
    $currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
    return $currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

# ============================================================================
Write-Host ""
Write-Host "=====================================================================" -ForegroundColor Magenta
Write-Host "  OPTIMISATION AVANCEE - CURSOR + CLAUDE CODE + AGENTIC DEV" -ForegroundColor Magenta
Write-Host "=====================================================================" -ForegroundColor Magenta

$isAdmin = Test-Admin
if (-not $isAdmin) {
    Write-Host "`n[ERREUR] Ce script doit etre execute en ADMINISTRATEUR" -ForegroundColor Red
    Write-Host "Clic droit > Executer en tant qu'administrateur" -ForegroundColor Yellow
    Read-Host "Appuyez sur Entree pour fermer"
    exit
}

Write-Host "`n[ADMIN] Mode administrateur detecte" -ForegroundColor Green

# ============================================================================
# 1. OPTIMISATIONS REGISTRE WINDOWS
# ============================================================================

Write-Step "OPTIMISATIONS REGISTRE WINDOWS"

# 1.1 Desactiver le delai de demarrage des applications
Write-Host "   Configuration delai demarrage..." -ForegroundColor Yellow
$regPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Serialize"
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}
Set-ItemProperty -Path $regPath -Name "StartupDelayInMSec" -Value 0 -Type DWord -Force
Write-OK "Delai demarrage applications = 0ms"

# 1.2 Accelerer le temps d'arret
Write-Host "   Configuration temps d'arret..." -ForegroundColor Yellow
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control" -Name "WaitToKillServiceTimeout" -Value "2000" -Force
Write-OK "Temps d'arret services = 2000ms (au lieu de 5000ms)"

# 1.3 Optimiser la reactivite systeme
Write-Host "   Configuration reactivite systeme..." -ForegroundColor Yellow
$mmPath = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile"
Set-ItemProperty -Path $mmPath -Name "SystemResponsiveness" -Value 10 -Type DWord -Force
Write-OK "SystemResponsiveness = 10 (priorite apps actives)"

# 1.4 Accelerer les menus
Write-Host "   Configuration delai menus..." -ForegroundColor Yellow
Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "MenuShowDelay" -Value "50" -Force
Write-OK "Delai menus = 50ms (au lieu de 400ms)"

# 1.5 Desactiver Game DVR / Xbox Game Bar
Write-Host "   Desactivation Game DVR/Xbox..." -ForegroundColor Yellow
$gameConfigPath = "HKCU:\System\GameConfigStore"
if (Test-Path $gameConfigPath) {
    Set-ItemProperty -Path $gameConfigPath -Name "GameDVR_Enabled" -Value 0 -Type DWord -Force
}
$gameDVRPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\GameDVR"
if (-not (Test-Path $gameDVRPath)) {
    New-Item -Path $gameDVRPath -Force | Out-Null
}
Set-ItemProperty -Path $gameDVRPath -Name "AllowGameDVR" -Value 0 -Type DWord -Force
Write-OK "Game DVR et Xbox Game Bar desactives"

# 1.6 Optimiser la priorite des threads pour les jeux/apps
Write-Host "   Configuration priorite GPU..." -ForegroundColor Yellow
$gpuPath = "$mmPath\Tasks\Games"
if (-not (Test-Path $gpuPath)) {
    New-Item -Path $gpuPath -Force | Out-Null
}
Set-ItemProperty -Path $gpuPath -Name "GPU Priority" -Value 8 -Type DWord -Force
Set-ItemProperty -Path $gpuPath -Name "Priority" -Value 6 -Type DWord -Force
Set-ItemProperty -Path $gpuPath -Name "Scheduling Category" -Value "High" -Force
Write-OK "Priorite GPU et scheduling optimises"

# ============================================================================
# 2. DESACTIVER EFFETS VISUELS INUTILES
# ============================================================================

Write-Step "OPTIMISATION EFFETS VISUELS"

Write-Host "   Desactivation animations Windows..." -ForegroundColor Yellow
$visualPath = "HKCU:\Control Panel\Desktop"
Set-ItemProperty -Path $visualPath -Name "DragFullWindows" -Value "0" -Force
Set-ItemProperty -Path $visualPath -Name "FontSmoothing" -Value "2" -Force

$visualPath2 = "HKCU:\Control Panel\Desktop\WindowMetrics"
Set-ItemProperty -Path $visualPath2 -Name "MinAnimate" -Value "0" -Force

# Desactiver les animations de la taskbar
$advancedPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
Set-ItemProperty -Path $advancedPath -Name "TaskbarAnimations" -Value 0 -Type DWord -Force
Set-ItemProperty -Path $advancedPath -Name "ListviewAlphaSelect" -Value 0 -Type DWord -Force
Set-ItemProperty -Path $advancedPath -Name "ListviewShadow" -Value 0 -Type DWord -Force

Write-OK "Animations Windows desactivees"

# ============================================================================
# 3. OPTIMISATIONS RESEAU
# ============================================================================

Write-Step "OPTIMISATIONS RESEAU"

# 3.1 Optimiser TCP/IP
Write-Host "   Configuration TCP/IP..." -ForegroundColor Yellow
netsh int tcp set global autotuninglevel=normal 2>&1 | Out-Null
netsh int tcp set global congestionprovider=ctcp 2>&1 | Out-Null
netsh int tcp set global ecncapability=enabled 2>&1 | Out-Null
Write-OK "TCP/IP optimise (autotuninglevel, ctcp, ecn)"

# 3.2 Desactiver Nagle's Algorithm pour latence reduite
Write-Host "   Configuration Nagle's Algorithm..." -ForegroundColor Yellow
$tcpPath = "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces"
Get-ChildItem $tcpPath | ForEach-Object {
    Set-ItemProperty -Path $_.PSPath -Name "TcpAckFrequency" -Value 1 -Type DWord -Force -ErrorAction SilentlyContinue
    Set-ItemProperty -Path $_.PSPath -Name "TCPNoDelay" -Value 1 -Type DWord -Force -ErrorAction SilentlyContinue
}
Write-OK "Nagle's Algorithm desactive (latence reduite)"

# 3.3 Optimiser DNS
Write-Host "   Configuration DNS cache..." -ForegroundColor Yellow
$dnsPath = "HKLM:\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters"
Set-ItemProperty -Path $dnsPath -Name "MaxCacheTtl" -Value 86400 -Type DWord -Force
Set-ItemProperty -Path $dnsPath -Name "MaxNegativeCacheTtl" -Value 5 -Type DWord -Force
Write-OK "DNS cache optimise"

# ============================================================================
# 4. OPTIMISATIONS SSD/STOCKAGE
# ============================================================================

Write-Step "OPTIMISATIONS SSD/STOCKAGE"

# 4.1 Activer TRIM
Write-Host "   Verification TRIM..." -ForegroundColor Yellow
fsutil behavior set DisableDeleteNotify 0 2>&1 | Out-Null
Write-OK "TRIM active pour SSD"

# 4.2 Desactiver la defragmentation automatique sur SSD
Write-Host "   Configuration defragmentation..." -ForegroundColor Yellow
$defragPath = "HKLM:\SOFTWARE\Microsoft\Dfrg\BootOptimizeFunction"
if (-not (Test-Path $defragPath)) {
    New-Item -Path $defragPath -Force | Out-Null
}
Set-ItemProperty -Path $defragPath -Name "Enable" -Value "N" -Force -ErrorAction SilentlyContinue
Write-OK "Defragmentation auto desactivee (SSD)"

# 4.3 Optimiser NTFS
Write-Host "   Configuration NTFS..." -ForegroundColor Yellow
fsutil behavior set disable8dot3 1 2>&1 | Out-Null
fsutil behavior set disablelastaccess 1 2>&1 | Out-Null
Write-OK "NTFS optimise (8dot3 et lastaccess desactives)"

# ============================================================================
# 5. DESACTIVER SERVICES INUTILES
# ============================================================================

Write-Step "OPTIMISATION SERVICES WINDOWS"

$servicesToDisable = @(
    @{Name = "DiagTrack"; Desc = "Telemetrie Windows" },
    @{Name = "dmwappushservice"; Desc = "Push WAP" },
    @{Name = "WSearch"; Desc = "Windows Search (si SSD rapide)" },
    @{Name = "SysMain"; Desc = "Superfetch (inutile sur SSD)" },
    @{Name = "TabletInputService"; Desc = "Service tablette" },
    @{Name = "WbioSrvc"; Desc = "Biometrie (si non utilise)" },
    @{Name = "lfsvc"; Desc = "Geolocalisation" },
    @{Name = "MapsBroker"; Desc = "Cartes telechargeables" }
)

foreach ($svc in $servicesToDisable) {
    try {
        $service = Get-Service -Name $svc.Name -ErrorAction SilentlyContinue
        if ($service) {
            Stop-Service -Name $svc.Name -Force -ErrorAction SilentlyContinue
            Set-Service -Name $svc.Name -StartupType Disabled -ErrorAction SilentlyContinue
            Write-Host "   [OK] $($svc.Name) desactive ($($svc.Desc))" -ForegroundColor Green
            $script:SuccessCount++
        }
    }
    catch {
        Write-Skip "$($svc.Name)"
    }
}

# ============================================================================
# 6. OPTIMISATIONS MEMOIRE
# ============================================================================

Write-Step "OPTIMISATIONS MEMOIRE"

# 6.1 Optimiser la gestion de la memoire
Write-Host "   Configuration gestion memoire..." -ForegroundColor Yellow
$memPath = "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management"
Set-ItemProperty -Path $memPath -Name "ClearPageFileAtShutdown" -Value 0 -Type DWord -Force
Set-ItemProperty -Path $memPath -Name "LargeSystemCache" -Value 0 -Type DWord -Force
Set-ItemProperty -Path $memPath -Name "DisablePagingExecutive" -Value 1 -Type DWord -Force
Write-OK "Gestion memoire optimisee"

# 6.2 Priorite processus premier plan
Write-Host "   Configuration priorite premier plan..." -ForegroundColor Yellow
$priorityPath = "HKLM:\SYSTEM\CurrentControlSet\Control\PriorityControl"
Set-ItemProperty -Path $priorityPath -Name "Win32PrioritySeparation" -Value 38 -Type DWord -Force
Write-OK "Priorite premier plan = 38 (max)"

# ============================================================================
# 7. OPTIMISATIONS SPECIFIQUES CURSOR
# ============================================================================

Write-Step "OPTIMISATIONS SPECIFIQUES CURSOR IDE"

# 7.1 Variables d'environnement pour Cursor/Electron
Write-Host "   Configuration Electron/Cursor..." -ForegroundColor Yellow
[Environment]::SetEnvironmentVariable("ELECTRON_ENABLE_LOGGING", "0", "User")
[Environment]::SetEnvironmentVariable("ELECTRON_NO_ASAR", "1", "User")
[Environment]::SetEnvironmentVariable("CURSOR_DISABLE_UPDATE_CHECK", "1", "User")
Write-OK "Variables Electron/Cursor configurees"

# 7.2 Augmenter la memoire pour Cursor (basé sur Electron)
Write-Host "   Configuration memoire Cursor..." -ForegroundColor Yellow
[Environment]::SetEnvironmentVariable("CURSOR_MAX_OLD_SPACE_SIZE", "8192", "User")
Write-OK "CURSOR_MAX_OLD_SPACE_SIZE = 8GB"

# 7.3 Desactiver la telemetrie VS Code/Cursor
Write-Host "   Desactivation telemetrie..." -ForegroundColor Yellow
$cursorSettingsPath = "$env:APPDATA\Cursor\User\settings.json"
if (Test-Path $cursorSettingsPath) {
    try {
        $settings = Get-Content $cursorSettingsPath -Raw | ConvertFrom-Json
        $settings | Add-Member -NotePropertyName "telemetry.telemetryLevel" -NotePropertyValue "off" -Force
        $settings | Add-Member -NotePropertyName "telemetry.enableTelemetry" -NotePropertyValue $false -Force
        $settings | Add-Member -NotePropertyName "telemetry.enableCrashReporter" -NotePropertyValue $false -Force
        $settings | ConvertTo-Json -Depth 10 | Set-Content $cursorSettingsPath
        Write-OK "Telemetrie Cursor desactivee"
    }
    catch {
        Write-Skip "Impossible de modifier settings.json Cursor"
    }
}
else {
    Write-Skip "Fichier settings.json Cursor non trouve"
}

# ============================================================================
# 8. OPTIMISATIONS SPECIFIQUES CLAUDE CODE
# ============================================================================

Write-Step "OPTIMISATIONS SPECIFIQUES CLAUDE CODE"

# 8.1 Variables d'environnement Claude
Write-Host "   Configuration variables Claude..." -ForegroundColor Yellow
[Environment]::SetEnvironmentVariable("CLAUDE_CODE_MAX_CONTEXT", "200000", "User")
[Environment]::SetEnvironmentVariable("ANTHROPIC_TIMEOUT", "300000", "User")
Write-OK "Variables Claude Code configurees"

# 8.2 Exclusions Defender supplementaires pour Claude
Write-Host "   Exclusions Defender Claude..." -ForegroundColor Yellow
$claudePaths = @(
    "$env:APPDATA\Claude",
    "$env:LOCALAPPDATA\Claude",
    "$env:USERPROFILE\.claude"
)
foreach ($path in $claudePaths) {
    Add-MpPreference -ExclusionPath $path -ErrorAction SilentlyContinue
}
Add-MpPreference -ExclusionProcess "claude.exe" -ErrorAction SilentlyContinue
Write-OK "Exclusions Defender Claude ajoutees"

# ============================================================================
# 9. OPTIMISATIONS DEVELOPPEMENT AGENTIC
# ============================================================================

Write-Step "OPTIMISATIONS DEVELOPPEMENT AGENTIC"

# 9.1 Configuration Git supplementaire
Write-Host "   Configuration Git avancee..." -ForegroundColor Yellow
git config --global core.compression 0 2>&1 | Out-Null
git config --global http.postBuffer 524288000 2>&1 | Out-Null
git config --global core.bigFileThreshold 50m 2>&1 | Out-Null
git config --global core.autocrlf false 2>&1 | Out-Null
git config --global fetch.parallel 0 2>&1 | Out-Null
git config --global submodule.fetchJobs 0 2>&1 | Out-Null
Write-OK "Git configure pour gros repos et parallélisation"

# 9.2 Configuration npm avancee
Write-Host "   Configuration npm avancee..." -ForegroundColor Yellow
npm config set prefer-offline true 2>&1 | Out-Null
npm config set fetch-retries 3 2>&1 | Out-Null
npm config set fetch-retry-mintimeout 5000 2>&1 | Out-Null
npm config set fetch-retry-maxtimeout 60000 2>&1 | Out-Null
Write-OK "npm configure pour mode offline et retries"

# 9.3 Variables d'environnement supplementaires
Write-Host "   Variables d'environnement avancees..." -ForegroundColor Yellow
[Environment]::SetEnvironmentVariable("FORCE_COLOR", "1", "User")
[Environment]::SetEnvironmentVariable("TERM", "xterm-256color", "User")
[Environment]::SetEnvironmentVariable("EDITOR", "cursor --wait", "User")
Write-OK "Variables dev configurees (FORCE_COLOR, TERM, EDITOR)"

# ============================================================================
# 10. NETTOYER ET VIDER LES CACHES
# ============================================================================

Write-Step "NETTOYAGE CACHES SYSTEME"

Write-Host "   Vidage cache DNS..." -ForegroundColor Yellow
ipconfig /flushdns 2>&1 | Out-Null
Write-OK "Cache DNS vide"

Write-Host "   Vidage cache npm..." -ForegroundColor Yellow
npm cache clean --force 2>&1 | Out-Null
Write-OK "Cache npm vide"

Write-Host "   Vidage fichiers temporaires..." -ForegroundColor Yellow
Remove-Item -Path "$env:TEMP\*" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item -Path "C:\Windows\Temp\*" -Recurse -Force -ErrorAction SilentlyContinue
Write-OK "Fichiers temporaires supprimes"

# ============================================================================
# RAPPORT FINAL
# ============================================================================

Write-Host "`n"
Write-Host "=====================================================================" -ForegroundColor Green
Write-Host "              OPTIMISATION AVANCEE TERMINEE" -ForegroundColor Green
Write-Host "=====================================================================" -ForegroundColor Green
Write-Host ""
Write-Host "RESUME:" -ForegroundColor Yellow
Write-Host "   [OK] Optimisations appliquees: $script:SuccessCount" -ForegroundColor Green
Write-Host "   [SKIP] Ignores: $script:SkipCount" -ForegroundColor Gray
Write-Host ""
Write-Host "OPTIMISATIONS APPLIQUEES:" -ForegroundColor Yellow
Write-Host "   - Registre Windows (demarrage, arret, reactivite, menus)" -ForegroundColor White
Write-Host "   - Effets visuels desactives" -ForegroundColor White
Write-Host "   - Reseau TCP/IP optimise (latence reduite)" -ForegroundColor White
Write-Host "   - SSD/Stockage optimise (TRIM, NTFS)" -ForegroundColor White
Write-Host "   - Services inutiles desactives" -ForegroundColor White
Write-Host "   - Gestion memoire optimisee" -ForegroundColor White
Write-Host "   - Cursor IDE optimise" -ForegroundColor White
Write-Host "   - Claude Code optimise" -ForegroundColor White
Write-Host "   - Git/npm configuration avancee" -ForegroundColor White
Write-Host "   - Caches systeme nettoyes" -ForegroundColor White
Write-Host ""
Write-Host "PROCHAINES ETAPES:" -ForegroundColor Yellow
Write-Host "   1. REDEMARREZ VOTRE PC pour appliquer toutes les modifications" -ForegroundColor Cyan
Write-Host "   2. Creez un fichier CLAUDE.md dans vos projets" -ForegroundColor White
Write-Host "   3. Creez un fichier .cursorrules pour guider l'IA" -ForegroundColor White
Write-Host ""

Read-Host "Appuyez sur Entree pour fermer"


