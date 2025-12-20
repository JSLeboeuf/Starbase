# ============================================================================
# ROLLBACK OPTIMISATIONS - RETOUR À L'ÉTAT STABLE
# ============================================================================
# Script de restauration des optimisations dangereuses
# Remet Windows dans un état stable et sécurisé
# ============================================================================

Write-Host "`n"
Write-Host "=====================================================================" -ForegroundColor Green
Write-Host "  ROLLBACK OPTIMISATIONS - RETOUR À L'ÉTAT STABLE" -ForegroundColor Green
Write-Host "=====================================================================" -ForegroundColor Green
Write-Host ""

$confirmation = Read-Host "Voulez-vous restaurer les paramètres Windows par défaut ? (OUI/NON)"
if ($confirmation -ne "OUI") {
    Write-Host "Operation annulee." -ForegroundColor Yellow
    exit
}

Write-Host "`n🔄 RESTAURATION EN COURS..." -ForegroundColor Cyan

# ============================================
# 1. RÉACTIVATION SERVICES CRITIQUES
# ============================================
Write-Host "`n[1/6] REACTIVATION SERVICES CRITIQUES" -ForegroundColor Yellow

$criticalServices = @(
    @{Name = "SysMain"; StartupType = "Auto" },
    @{Name = "WSearch"; StartupType = "Auto" },
    @{Name = "Spooler"; StartupType = "Auto" },
    @{Name = "Fax"; StartupType = "Manual" },
    @{Name = "WinDefend"; StartupType = "Auto" },
    @{Name = "wuauserv"; StartupType = "Auto" },
    @{Name = "MpsSvc"; StartupType = "Auto" },
    @{Name = "EventLog"; StartupType = "Auto" },
    @{Name = "gpsvc"; StartupType = "Auto" },
    @{Name = "PlugPlay"; StartupType = "Auto" },
    @{Name = "RpcSs"; StartupType = "Auto" },
    @{Name = "RpcEptMapper"; StartupType = "Auto" }
)

foreach ($service in $criticalServices) {
    try {
        Set-Service -Name $service.Name -StartupType $service.StartupType -ErrorAction SilentlyContinue
        Write-Host "   [RESTORED] $($service.Name) -> $($service.StartupType)" -ForegroundColor Green
    }
    catch {
        Write-Host "   [FAILED] $($service.Name)" -ForegroundColor Red
    }
}

Write-Host "Services critiques reactives" -ForegroundColor Green

# ============================================
# 2. RESTAURATION REGISTRE
# ============================================
Write-Host "`n[2/6] RESTAURATION REGISTRE" -ForegroundColor Yellow

# Réactiver télémétrie (paramètres Microsoft recommandés)
$telemetryPaths = @(
    "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection",
    "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection"
)
foreach ($path in $telemetryPaths) {
    try {
        Set-ItemProperty -Path $path -Name "AllowTelemetry" -Value 1 -Type DWord -Force
        Write-Host "   [RESTORED] Telemetrie -> 1" -ForegroundColor Green
    }
    catch {
        Write-Host "   [SKIP] Telemetrie path not found" -ForegroundColor Gray
    }
}

# Réactiver rapports d'erreurs
try {
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\Windows Error Reporting" -Name "Disabled" -Value 0 -Type DWord -Force
    Write-Host "   [RESTORED] Rapports d'erreurs actives" -ForegroundColor Green
}
catch {
    Write-Host "   [SKIP] Error reporting path not found" -ForegroundColor Gray
}

# Restaurer paramètres réseau par défaut
netsh int tcp set global autotuninglevel=normal 2>&1 | Out-Null
Write-Host "   [RESTORED] TCP autotuning -> normal" -ForegroundColor Green

Write-Host "Registre restaure" -ForegroundColor Green

# ============================================
# 3. RESTAURATION MÉMOIRE
# ============================================
Write-Host "`n[3/6] RESTAURATION MEMOIRE" -ForegroundColor Yellow

$memPath = "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management"

# Réactiver pagination
Set-ItemProperty -Path $memPath -Name "DisablePagingExecutive" -Value 0 -Type DWord -Force
Set-ItemProperty -Path $memPath -Name "LargeSystemCache" -Value 0 -Type DWord -Force
Set-ItemProperty -Path $memPath -Name "ClearPageFileAtShutdown" -Value 0 -Type DWord -Force

# Réactiver prefetch/superfetch
Set-ItemProperty -Path "$memPath\PrefetchParameters" -Name "EnablePrefetcher" -Value 3 -Type DWord -Force
Set-ItemProperty -Path "$memPath\PrefetchParameters" -Name "EnableSuperfetch" -Value 3 -Type DWord -Force

Write-Host "Memoire restauree aux parametres par defaut" -ForegroundColor Green

# ============================================
# 4. RESTAURATION CPU/ALIMENTATION
# ============================================
Write-Host "`n[4/6] RESTAURATION CPU/ALIMENTATION" -ForegroundColor Yellow

# Restaurer profil d'alimentation équilibré
powercfg -setactive 381b4222-f694-41f0-9685-ff5bb260df2e 2>&1 | Out-Null

# Réactiver C-states
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Power" -Name "CsEnabled" -Value 1 -Type DWord -Force

Write-Host "CPU et alimentation restaures" -ForegroundColor Green

# ============================================
# 5. RESTAURATION SÉCURITÉ
# ============================================
Write-Host "`n[5/6] RESTAURATION SECURITE" -ForegroundColor Yellow

# Réactiver Windows Defender
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows Defender" -Name "DisableAntiSpyware" -Value 0 -Type DWord -Force

# Réactiver mises à jour Windows
$auPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU"
Set-ItemProperty -Path $auPath -Name "NoAutoUpdate" -Value 0 -Type DWord -Force
Set-ItemProperty -Path $auPath -Name "AUOptions" -Value 4 -Type DWord -Force

# Réactiver logs système
wevtutil sl System /e:true 2>&1 | Out-Null
wevtutil sl Application /e:true 2>&1 | Out-Null
wevtutil sl Security /e:true 2>&1 | Out-Null

Write-Host "Securite restauree" -ForegroundColor Green

# ============================================
# 6. NETTOYAGE ET FINALISATION
# ============================================
Write-Host "`n[6/6] NETTOYAGE ET FINALISATION" -ForegroundColor Yellow

# Vider caches DNS
ipconfig /flushdns 2>&1 | Out-Null
Write-Host "   [CLEANED] Cache DNS vide" -ForegroundColor Green

# Redémarrage recommandé
Write-Host "`n=====================================================================" -ForegroundColor Green
Write-Host "              ROLLBACK TERMINÉ" -ForegroundColor Green
Write-Host "=====================================================================" -ForegroundColor Green
Write-Host ""

Write-Host "✅ RESTAURATION EFFECTUÉE:" -ForegroundColor Green
Write-Host "   • Services critiques réactivés" -ForegroundColor White
Write-Host "   • Télémétrie réactivée" -ForegroundColor White
Write-Host "   • Windows Defender réactivé" -ForegroundColor White
Write-Host "   • Mises à jour Windows réactivées" -ForegroundColor White
Write-Host "   • Mémoire/pagination réactivées" -ForegroundColor White
Write-Host "   • Logs système réactivés" -ForegroundColor White
Write-Host ""

Write-Host "🔄 REDÉMARRAGE FORTEMENT RECOMMANDÉ" -ForegroundColor Cyan
Write-Host "   pour appliquer toutes les modifications de rollback." -ForegroundColor White
Write-Host ""

Write-Host "📊 ÉTAT SYSTÈME:" -ForegroundColor Yellow
Write-Host "   • Sécurité: Restaurée" -ForegroundColor White
Write-Host "   • Stabilité: Améliorée" -ForegroundColor White
Write-Host "   • Performance: Paramètres par défaut" -ForegroundColor White
Write-Host ""

$restart = Read-Host "Voulez-vous redemarrer maintenant ? (OUI/NON)"
if ($restart -eq "OUI") {
    Write-Host "Redemarrage dans 10 secondes..." -ForegroundColor Yellow
    Start-Sleep 10
    Restart-Computer -Force
}
else {
    Write-Host "Redemarrez manuellement pour finaliser le rollback." -ForegroundColor Cyan
}

Read-Host "`nAppuyez sur Entree pour fermer"
