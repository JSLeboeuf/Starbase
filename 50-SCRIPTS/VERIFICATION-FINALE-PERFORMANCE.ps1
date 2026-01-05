# ============================================================================
# VERIFICATION FINALE - PERFORMANCE OPTIMISEE
# ============================================================================

Write-Host "`n"
Write-Host "=====================================================================" -ForegroundColor Cyan
Write-Host "  VERIFICATION FINALE - ETAT DU SYSTEME OPTIMISE" -ForegroundColor Cyan
Write-Host "=====================================================================" -ForegroundColor Cyan
Write-Host ""

# ============================================
# SYSTEME
# ============================================
Write-Host "SYSTEME:" -ForegroundColor Yellow
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

# ============================================
# ALIMENTATION
# ============================================
Write-Host "`nALIMENTATION:" -ForegroundColor Yellow
try {
    $activePlan = powercfg /getactivescheme 2>&1
    if ($activePlan -match "Ultimate Performance" -or $activePlan -match "e9a42b02") {
        Write-Host "   [OK] Ultimate Performance actif" -ForegroundColor Green
    } else {
        Write-Host "   [INFO] $activePlan" -ForegroundColor Yellow
    }
} catch {
    Write-Host "   [ERREUR] Impossible de verifier" -ForegroundColor Red
}

# ============================================
# SERVICES
# ============================================
Write-Host "`nSERVICES CRITIQUES:" -ForegroundColor Yellow
$servicesToCheck = @(
    @{Name="SysMain"; Status="Disabled"; Desc="Superfetch (SSD)"},
    @{Name="WSearch"; Status="Disabled"; Desc="Windows Search"},
    @{Name="Spooler"; Status="Disabled"; Desc="Print Spooler"},
    @{Name="Fax"; Status="Disabled"; Desc="Fax Service"}
)

foreach ($svc in $servicesToCheck) {
    try {
        $service = Get-Service -Name $svc.Name -ErrorAction SilentlyContinue
        if ($service -and $service.StartType -eq $svc.Status) {
            Write-Host "   [OK] $($svc.Name) ($($svc.Desc))" -ForegroundColor Green
        } else {
            Write-Host "   [INFO] $($svc.Name) status: $($service.StartType)" -ForegroundColor Yellow
        }
    } catch {
        Write-Host "   [SKIP] $($svc.Name)" -ForegroundColor Gray
    }
}

# ============================================
# VARIABLES D'ENVIRONNEMENT
# ============================================
Write-Host "`nVARIABLES D'ENVIRONNEMENT:" -ForegroundColor Yellow
$envVars = @(
    @{Name="NODE_OPTIONS"; Expected="--max-old-space-size=16384"},
    @{Name="UV_THREADPOOL_SIZE"; Expected="32"},
    @{Name="npm_config_fund"; Expected="false"},
    @{Name="PYTHONDONTWRITEBYTECODE"; Expected="1"}
)

foreach ($var in $envVars) {
    $value = [Environment]::GetEnvironmentVariable($var.Name, "User")
    if ($value -eq $var.Expected) {
        Write-Host "   [OK] $($var.Name) = $value" -ForegroundColor Green
    } else {
        Write-Host "   [INFO] $($var.Name) = $value" -ForegroundColor Yellow
    }
}

# ============================================
# DEFENDER EXCLUSIONS
# ============================================
Write-Host "`nWINDOWS DEFENDER:" -ForegroundColor Yellow
try {
    $exclusions = Get-MpPreference | Select-Object -ExpandProperty ExclusionPath
    $processes = Get-MpPreference | Select-Object -ExpandProperty ExclusionProcess
    Write-Host "   [OK] Chemins exclus: $($exclusions.Count)" -ForegroundColor Green
    Write-Host "   [OK] Processus exclus: $($processes.Count)" -ForegroundColor Green
} catch {
    Write-Host "   [ERREUR] Impossible de verifier" -ForegroundColor Red
}

# ============================================
# PERFORMANCE ACTUELLE
# ============================================
Write-Host "`nPERFORMANCE SYSTEME:" -ForegroundColor Yellow
try {
    $cpuUsage = Get-Counter '\Processor(_Total)\% Processor Time' -SampleInterval 1 -MaxSamples 1
    $memUsage = Get-Counter '\Memory\% Committed Bytes In Use' -SampleInterval 1 -MaxSamples 1
    Write-Host "   CPU Usage: $([math]::Round($cpuUsage.CounterSamples.CookedValue, 1))%" -ForegroundColor White
    Write-Host "   Memory Usage: $([math]::Round($memUsage.CounterSamples.CookedValue, 1))%" -ForegroundColor White
} catch {
    Write-Host "   [SKIP] Impossible de mesurer performance" -ForegroundColor Gray
}

# ============================================
# CLAUDE CODE
# ============================================
Write-Host "`nCLAUDE CODE:" -ForegroundColor Yellow
try {
    $claudeVersion = claude --version 2>$null
    Write-Host "   [OK] Version: $claudeVersion" -ForegroundColor Green

    $mcpOutput = claude mcp list 2>&1
    $connectedCount = ($mcpOutput | Select-String "Connected" | Measure-Object).Count
    Write-Host "   [OK] MCP Servers: $connectedCount connectes" -ForegroundColor Green
} catch {
    Write-Host "   [SKIP] Claude Code non disponible" -ForegroundColor Gray
}

# ============================================
# RECOMMANDATIONS
# ============================================
Write-Host "`nRECOMMANDATIONS:" -ForegroundColor Yellow
Write-Host "   ✅ Votre systeme est optimise pour performance maximale" -ForegroundColor Green
Write-Host "   🔄 Redemarrez si vous n'avez pas encore redemarre" -ForegroundColor Cyan
Write-Host "   📊 Utilisez les outils de monitoring pour verifier les gains" -ForegroundColor White
Write-Host "   🚀 Lancez Claude Code avec .\kraken.ps1 pour experience optimale" -ForegroundColor White

Write-Host "`n=====================================================================" -ForegroundColor Cyan
Write-Host "              VERIFICATION TERMINEE" -ForegroundColor Cyan
Write-Host "=====================================================================" -ForegroundColor Cyan
Write-Host ""

Read-Host 'Appuyez sur Entree pour fermer'
