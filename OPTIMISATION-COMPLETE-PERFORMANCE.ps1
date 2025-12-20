# ============================================================================
# SCRIPT D'OPTIMISATION COMPLÈTE - PERFORMANCE MAXIMALE
# ============================================================================
# Ce script optimise Windows 11 pour le développement agentic avec Claude
# Exécutez en ADMINISTRATEUR pour toutes les optimisations
# ============================================================================

$ErrorActionPreference = "Continue"
$script:SuccessCount = 0
$script:ErrorCount = 0
$script:SkipCount = 0

function Write-Step {
    param([string]$Message, [string]$Color = "Yellow")
    Write-Host "`n[$($script:SuccessCount + $script:ErrorCount + $script:SkipCount + 1)] $Message" -ForegroundColor $Color
}

function Write-Success {
    param([string]$Message)
    Write-Host "  [OK] $Message" -ForegroundColor Green
    $script:SuccessCount++
}

function Write-Error {
    param([string]$Message)
    Write-Host "  [ERREUR] $Message" -ForegroundColor Red
    $script:ErrorCount++
}

function Write-Skip {
    param([string]$Message)
    Write-Host "  [SKIP] $Message" -ForegroundColor Gray
    $script:SkipCount++
}

function Test-Admin {
    $currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
    return $currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

# ============================================================================
# DÉBUT DU SCRIPT
# ============================================================================

Write-Host "`n" -NoNewline
Write-Host "=====================================================================" -ForegroundColor Cyan
Write-Host "  OPTIMISATION COMPLETE - PERFORMANCE MAXIMALE WINDOWS 11" -ForegroundColor Cyan
Write-Host "=====================================================================" -ForegroundColor Cyan
Write-Host ""

$isAdmin = Test-Admin
if ($isAdmin) {
    Write-Host "[ADMIN] Mode ADMINISTRATEUR detecte - Toutes les optimisations seront appliquees" -ForegroundColor Green
}
else {
    Write-Host "[USER] Mode UTILISATEUR - Certaines optimisations necessitent les droits admin" -ForegroundColor Yellow
}

Start-Sleep -Seconds 1

# ============================================================================
# 1. OPTIMISATIONS SYSTÈME (ADMIN REQUIS)
# ============================================================================

if ($isAdmin) {
    Write-Step "OPTIMISATIONS SYSTÈME (Admin)" "Cyan"
    
    # 1.1 Plan Ultimate Performance
    Write-Step "Activation Plan Ultimate Performance..."
    try {
        $result = powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61 2>&1
        if ($LASTEXITCODE -eq 0) {
            powercfg -setactive e9a42b02-d5df-448d-aa00-03f14749eb61
            Write-Success "Plan Ultimate Performance activé"
        }
        else {
            Write-Skip "Plan Ultimate Performance existe déjà"
        }
    }
    catch {
        Write-Error "Erreur lors de l'activation du plan: $_"
    }
    
    # 1.2 Exclusions Windows Defender
    Write-Step "Configuration exclusions Windows Defender..."
    $exclusions = @(
        @{Type = "Path"; Value = "$env:USERPROFILE" },
        @{Type = "Path"; Value = "$env:USERPROFILE\node_modules" },
        @{Type = "Path"; Value = "$env:APPDATA\Claude" },
        @{Type = "Path"; Value = "$env:LOCALAPPDATA\Programs\cursor" },
        @{Type = "Path"; Value = "$env:LOCALAPPDATA\Programs\Microsoft VS Code" },
        @{Type = "Process"; Value = "node.exe" },
        @{Type = "Process"; Value = "python.exe" },
        @{Type = "Process"; Value = "claude.exe" },
        @{Type = "Process"; Value = "cursor.exe" },
        @{Type = "Process"; Value = "code.exe" },
        @{Type = "Process"; Value = "git.exe" },
        @{Type = "Process"; Value = "npm.cmd" },
        @{Type = "Process"; Value = "pnpm.exe" },
        @{Type = "Process"; Value = "yarn.exe" }
    )
    
    foreach ($exclusion in $exclusions) {
        try {
            if ($exclusion.Type -eq "Path") {
                Add-MpPreference -ExclusionPath $exclusion.Value -ErrorAction SilentlyContinue
            }
            else {
                Add-MpPreference -ExclusionProcess $exclusion.Value -ErrorAction SilentlyContinue
            }
        }
        catch {
            # Ignorer si déjà existant
        }
    }
    Write-Success "$($exclusions.Count) exclusions Defender configurées"
    
}
else {
    Write-Step "OPTIMISATIONS SYSTÈME (Admin requis)" "Gray"
    Write-Skip "Ces optimisations nécessitent les droits administrateur"
    Write-Host "  Exécutez ce script en tant qu'administrateur pour:" -ForegroundColor Yellow
    Write-Host "    - Activer le plan Ultimate Performance" -ForegroundColor White
    Write-Host "    - Configurer les exclusions Windows Defender" -ForegroundColor White
}

# ============================================================================
# 2. VARIABLES D'ENVIRONNEMENT (USER)
# ============================================================================

Write-Step "CONFIGURATION VARIABLES D'ENVIRONNEMENT" "Cyan"

# 2.1 Node.js - 16GB heap
Write-Step "Configuration Node.js (16GB heap)..."
try {
    [Environment]::SetEnvironmentVariable("NODE_OPTIONS", "--max-old-space-size=16384", "User")
    Write-Success "NODE_OPTIONS = --max-old-space-size=16384 (16GB)"
}
catch {
    Write-Error "Erreur configuration NODE_OPTIONS: $_"
}

# 2.2 npm - Désactiver ralentissements
Write-Step "Optimisation npm (désactivation fund/audit)..."
try {
    [Environment]::SetEnvironmentVariable("npm_config_fund", "false", "User")
    [Environment]::SetEnvironmentVariable("npm_config_audit", "false", "User")
    Write-Success "npm fund et audit désactivés"
}
catch {
    Write-Error "Erreur configuration npm: $_"
}

# 2.3 UV threadpool - Parallélisation I/O
Write-Step "Configuration UV threadpool (parallélisation I/O)..."
try {
    [Environment]::SetEnvironmentVariable("UV_THREADPOOL_SIZE", "16", "User")
    Write-Success "UV_THREADPOOL_SIZE = 16"
}
catch {
    Write-Error "Erreur configuration UV_THREADPOOL: $_"
}

# 2.4 Python - Optimisations
Write-Step "Optimisation Python..."
try {
    [Environment]::SetEnvironmentVariable("PYTHONDONTWRITEBYTECODE", "1", "User")
    [Environment]::SetEnvironmentVariable("PYTHONUNBUFFERED", "1", "User")
    Write-Success "Python optimisé (pas de .pyc, unbuffered)"
}
catch {
    Write-Error "Erreur configuration Python: $_"
}

# ============================================================================
# 3. CONFIGURATION GIT OPTIMISÉE
# ============================================================================

Write-Step "CONFIGURATION GIT OPTIMISÉE" "Cyan"

$gitConfigs = @{
    "core.preloadindex"   = "true"
    "core.fscache"        = "true"
    "core.untrackedCache" = "true"
    "gc.auto"             = "256"
    "feature.manyFiles"   = "true"
    "index.threads"       = "true"
    "pack.threads"        = "0"
}

Write-Step "Application des configurations Git..."
$gitSuccess = 0
foreach ($key in $gitConfigs.Keys) {
    try {
        git config --global $key $gitConfigs[$key] 2>&1 | Out-Null
        if ($LASTEXITCODE -eq 0) {
            $gitSuccess++
        }
    }
    catch {
        # Git peut ne pas être installé
    }
}

if ($gitSuccess -gt 0) {
    Write-Success "$gitSuccess configurations Git appliquées"
}
else {
    Write-Skip "Git non détecté ou erreur de configuration"
}

# ============================================================================
# 4. CONFIGURATION NPM/PNPM
# ============================================================================

Write-Step "CONFIGURATION NPM/PNPM" "Cyan"

# 4.1 Vérifier si npm est disponible
try {
    $npmVersion = npm --version 2>&1
    if ($LASTEXITCODE -eq 0) {
        Write-Step "Configuration npm..."
        npm config set fund false 2>&1 | Out-Null
        npm config set audit false 2>&1 | Out-Null
        npm config set progress false 2>&1 | Out-Null
        npm config set loglevel warn 2>&1 | Out-Null
        Write-Success "npm configuré (fund/audit/progress désactivés)"
        
        # 4.2 Installer pnpm si disponible
        Write-Step "Vérification pnpm..."
        try {
            $pnpmVersion = pnpm --version 2>&1
            if ($LASTEXITCODE -eq 0) {
                Write-Success "pnpm déjà installé (version $pnpmVersion)"
            }
            else {
                Write-Step "Installation de pnpm..."
                npm install -g pnpm 2>&1 | Out-Null
                if ($LASTEXITCODE -eq 0) {
                    Write-Success "pnpm installé globalement"
                }
                else {
                    Write-Skip "Échec installation pnpm (peut nécessiter admin)"
                }
            }
        }
        catch {
            Write-Skip "pnpm non disponible"
        }
    }
    else {
        Write-Skip "npm non détecté"
    }
}
catch {
    Write-Skip "npm non disponible sur ce système"
}

# ============================================================================
# 5. RAPPORT FINAL
# ============================================================================

Write-Host "`n"
Write-Host "=====================================================================" -ForegroundColor Cyan
Write-Host "                    RAPPORT FINAL" -ForegroundColor Cyan
Write-Host "=====================================================================" -ForegroundColor Cyan
Write-Host ""

# 5.1 Plan alimentation actif
Write-Host "PLAN ALIMENTATION:" -ForegroundColor Yellow
try {
    $activePlan = powercfg /getactivescheme 2>&1
    if ($activePlan -match "Ultimate Performance" -or $activePlan -match "e9a42b02") {
        Write-Host "   [OK] Ultimate Performance actif" -ForegroundColor Green
    }
    else {
        Write-Host "   [INFO] $activePlan" -ForegroundColor Yellow
        if (-not $isAdmin) {
            Write-Host "      (Executez en admin pour activer Ultimate Performance)" -ForegroundColor Gray
        }
    }
}
catch {
    Write-Host "   [ERREUR] Impossible de verifier" -ForegroundColor Red
}

# 5.2 Variables d'environnement
Write-Host "`nVARIABLES D'ENVIRONNEMENT:" -ForegroundColor Yellow
$envVars = @(
    @{Name = "NODE_OPTIONS"; Expected = "--max-old-space-size=16384" },
    @{Name = "npm_config_fund"; Expected = "false" },
    @{Name = "npm_config_audit"; Expected = "false" },
    @{Name = "UV_THREADPOOL_SIZE"; Expected = "16" },
    @{Name = "PYTHONDONTWRITEBYTECODE"; Expected = "1" },
    @{Name = "PYTHONUNBUFFERED"; Expected = "1" }
)

foreach ($var in $envVars) {
    $value = [Environment]::GetEnvironmentVariable($var.Name, "User")
    if ($value -eq $var.Expected) {
        Write-Host "   [OK] $($var.Name) = $value" -ForegroundColor Green
    }
    else {
        Write-Host "   [INFO] $($var.Name) = $value (attendu: $($var.Expected))" -ForegroundColor Yellow
    }
}

# 5.3 Exclusions Defender (si admin)
if ($isAdmin) {
    Write-Host "`nEXCLUSIONS DEFENDER:" -ForegroundColor Yellow
    try {
        $exclusions = Get-MpPreference | Select-Object -ExpandProperty ExclusionPath
        $processes = Get-MpPreference | Select-Object -ExpandProperty ExclusionProcess
        Write-Host "   [OK] $($exclusions.Count) chemins exclus" -ForegroundColor Green
        Write-Host "   [OK] $($processes.Count) processus exclus" -ForegroundColor Green
    }
    catch {
        Write-Host "   [INFO] Impossible de verifier les exclusions" -ForegroundColor Yellow
    }
}

# 5.4 RAM/CPU disponibles
Write-Host "`nRESSOURCES SYSTÈME:" -ForegroundColor Yellow
try {
    $ram = [math]::Round((Get-CimInstance Win32_ComputerSystem).TotalPhysicalMemory / 1GB, 1)
    $cpu = (Get-CimInstance Win32_Processor | Select-Object -First 1).Name
    $cores = (Get-CimInstance Win32_Processor | Select-Object -First 1).NumberOfLogicalProcessors
    Write-Host "   RAM: $ram GB" -ForegroundColor White
    Write-Host "   CPU: $cpu" -ForegroundColor White
    Write-Host "   Threads: $cores" -ForegroundColor White
}
catch {
    Write-Host "   [ERREUR] Impossible de recuperer les infos systeme" -ForegroundColor Red
}

# 5.5 Résumé des optimisations
Write-Host "`nRESUME DES OPTIMISATIONS:" -ForegroundColor Yellow
Write-Host "   [OK] Succes: $script:SuccessCount" -ForegroundColor Green
Write-Host "   [SKIP] Ignores: $script:SkipCount" -ForegroundColor Gray
Write-Host "   [ERREUR] Erreurs: $script:ErrorCount" -ForegroundColor Red

# 5.6 Recommandations supplémentaires
Write-Host "`nRECOMMANDATIONS SUPPLEMENTAIRES:" -ForegroundColor Yellow
Write-Host "   1. Redemarrez votre terminal pour appliquer les variables d'environnement" -ForegroundColor White
if (-not $isAdmin) {
    Write-Host "   2. Executez ce script en ADMINISTRATEUR pour:" -ForegroundColor White
    Write-Host "      - Activer le plan Ultimate Performance" -ForegroundColor Gray
    Write-Host "      - Configurer les exclusions Windows Defender" -ForegroundColor Gray
}
Write-Host "   3. Redemarrez votre PC pour un effet complet" -ForegroundColor White
Write-Host "   4. Verifiez que Windows Defender n'analyse pas vos dossiers de developpement" -ForegroundColor White

Write-Host "`n"
Write-Host "=====================================================================" -ForegroundColor Green
Write-Host "              OPTIMISATION TERMINEE" -ForegroundColor Green
Write-Host "=====================================================================" -ForegroundColor Green
Write-Host ""

if (-not $isAdmin) {
    Write-Host "[ATTENTION] Pour une optimisation complete, executez ce script en ADMINISTRATEUR" -ForegroundColor Yellow
    Write-Host ""
}

Read-Host "Appuyez sur Entree pour fermer"


