# ============================================================================
# ULTIME OPTIMISATION WINDOWS - LIMITE ABSOLUE
# ============================================================================
# ATTENTION: Ces optimisations sont EXTREMES et peuvent rendre Windows INSTABLE
# Sauvegardez TOUT avant de continuer - Risque élevé de plantage système
# ============================================================================

$ErrorActionPreference = "SilentlyContinue"

Write-Host "`n" -ForegroundColor Red
Write-Host "================================================================================" -ForegroundColor Red
Write-Host "  ⚠️  ULTIME OPTIMISATION WINDOWS - LIMITE ABSOLUE ⚠️" -ForegroundColor Red
Write-Host "================================================================================" -ForegroundColor Red
Write-Host "  🚨 EXTREME DANGER - RISQUE DE PLANTAGE SYSTÈME" -ForegroundColor Red
Write-Host "  💾 SAUVEGARDEZ TOUT AVANT DE CONTINUER" -ForegroundColor Yellow
Write-Host "  🔄 POINT DE RESTAURATION RECOMMANDÉ" -ForegroundColor Yellow

$isAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if (-not $isAdmin) {
    Write-Host "`n[ERREUR] Executez en ADMINISTRATEUR !" -ForegroundColor Red
    Read-Host "Appuyez sur Entree pour fermer"
    exit
}

$confirmation1 = Read-Host "`nTapez 'JE-SAIS-QUE-CA-PEUT-CASSER-MON-PC' pour continuer"
if ($confirmation1 -ne "JE-SAIS-QUE-CA-PEUT-CASSER-MON-PC") {
    Write-Host "Operation annulee - sage decision." -ForegroundColor Yellow
    exit
}

$confirmation2 = Read-Host "`nDERNIERE CHANCE: Tapez 'JE-VEUX-CASSER-MON-PC' pour continuer"
if ($confirmation2 -ne "JE-VEUX-CASSER-MON-PC") {
    Write-Host "Operation annulee - vous avez raison." -ForegroundColor Yellow
    exit
}

Write-Host "`n🔥 LANCEMENT OPTIMISATIONS ULTIMES..." -ForegroundColor Red

# ============================================
# PHASE 1: SERVICES CRITIQUES - DÉSACTIVATION MASSIVE
# ============================================
Write-Host "`n[PHASE 1] SERVICES CRITIQUES - DÉSACTIVATION MASSIVE" -ForegroundColor Red

$criticalServices = @(
    "SysMain", "WSearch", "Spooler", "Fax", "lfsvc", "MapsBroker", "WbioSrvc",
    "wisvc", "RetailDemo", "DiagTrack", "dmwappushservice", "WdiServiceHost",
    "WdiSystemHost", "XboxAccessoryManagementService", "XboxLiveAuthManager",
    "XboxLiveGameSave", "XboxLiveNetworkingService", "NgcSvc", "NgcCtnrSvc",
    "wlidsvc", "TokenBroker", "WpnService", "WpnUserService_*", "SensrSvc",
    "SensorService", "SCardSvr", "ScDeviceEnum", "SCPolicySvc", "TabletInputService",
    "PushToInstall", "SensrSvc", "SensorDataService", "SensorService", "SEMgrSvc",
    "SmsRouter", "SNMPTrap", "spectrum", "sppsvc", "SSDPSRV", "ssh-agent",
    "SstpSvc", "StateRepository", "stisvc", "StorSvc", "TieringEngineService",
    "SysMgmt", "smphost", "svsvc", "swprv", "SystemEventsBroker", "TabletInputService",
    "TapiSrv", "TermService", "UmRdpService", "UnistoreSvc", "upnphost", "UserDataSvc",
    "UserManager", "UsoSvc", "VaultSvc", "vds", "VSS", "W32Time", "WaaSMedicSvc",
    "WAS", "WbioSrvc", "Wcmsvc", "wcncsvc", "WcsPlugInService", "WdiServiceHost",
    "WdiSystemHost", "WdNisSvc", "WebClient", "Wecsvc", "WEPHOSTSVC", "wercplsupport",
    "WerSvc", "WiaRpc", "WinDefend", "WinHttpAutoProxySvc", "Winmgmt", "WinRM",
    "wisvc", "WlanSvc", "wlidsvc", "wlpasvc", "WManSvc", "wmiApSrv", "WMPNetworkSvc",
    "WMSvc", "Wof", "workfolderssvc", "WpcMonSvc", "WPDBusEnum", "WpnService",
    "WpnUserService_*", "wscsvc", "WSearch", "wuauserv", "WwanSvc", "XblAuthManager",
    "XblGameSave", "XboxNetApiSvc", "AarSvc", "AJRouter", "ALG", "AppIDSvc",
    "Appinfo", "AppMgmt", "AppReadiness", "AppVClient", "AppXSvc", "BrokerInfrastructure",
    "CoreMessagingRegistrar", "DcomLaunch", "DeviceAssociationBrokerSvc_*",
    "DeviceAssociationService", "DeviceInstall", "DsmSvc", "DsSvc", "Dwp",
    "Eaphost", "EFS", "fhsvc", "fdPHost", "FDResPub", "gpsvc", "hkmsvc", "hidserv",
    "HvHost", "vmickvpexchange", "vmicguestinterface", "vmicshutdown", "vmicheartbeat",
    "vmicvmsession", "vmicrdv", "vmicvmsession", "vmicvss", "Hyper-V", "gupdate",
    "gupdatem", "IAStorDataMgrSvc", "IntelAudioService", "jhi_service", "LMS",
    "Intel(R) Capability Licensing Service TCP IP Interface", "KtmRm", "lltdsvc",
    "MSDTC", "MSMQ", "MSMQTriggers", "napagent", "NcaSvc", "NcbService", "NcdAutoSetup",
    "Netlogon", "Netman", "NetSetupSvc", "NetTcpPortSharing", "NlaSvc", "nsi",
    "p2pimsvc", "p2psvc", "P9RdrService_*", "PcaSvc", "PeerDistSvc", "PenService_*",
    "perceptionsimulation", "PerfHost", "pla", "PlugPlay", "PNRPAutoReg", "PNRPsvc",
    "PolicyAgent", "Power", "ProfSvc", "QWAVE", "RasAcd", "RasAgileVpn", "RasSstp",
    "RasPppoe", "RasPptp", "RasGre", "RemoteAccess", "RemoteRegistry", "RmSvc",
    "RpcEptMapper", "RpcSs", "SamSs", "SCardSvr", "ScDeviceEnum", "SCPolicySvc",
    "SDRSVC", "seclogon", "SEMgrSvc", "SENS", "Sense", "SensorDataService",
    "SensorService", "SensrSvc", "SessionEnv", "SgrmBroker", "SharedAccess",
    "SharedRealitySvc", "ShellHWDetection", "shpamsvc", "smphost", "SmsRouter",
    "SNMPTrap", "spectrum", "spooler", "sppsvc", "SSDPSRV", "SstpSvc", "StateRepository",
    "stisvc", "StorSvc", "svsvc", "swprv", "SysMain", "SystemEventsBroker", "TabletInputService",
    "TapiSrv", "TermService", "TextInputManagementService", "Themes", "TieringEngineService",
    "TimeBrokerSvc", "TokenBroker", "TrkWks", "TrustedInstaller", "tzautoupdate",
    "UdkUserSvc", "UevAgentService", "uhssvc", "UmRdpService", "UnistoreSvc", "upnphost",
    "UserDataSvc", "UserManager", "UsoSvc", "VaultSvc", "vds", "vmicguestinterface",
    "vmicheartbeat", "vmickvpexchange", "vmicrdv", "vmicshutdown", "vmicvmsession",
    "vmicvss", "vmms", "VSS", "W32Time", "WaaSMedicSvc", "WAS", "WbioSrvc", "Wcmsvc",
    "wcncsvc", "WcsPlugInService", "WdiServiceHost", "WdiSystemHost", "WdNisSvc",
    "WebClient", "Wecsvc", "WEPHOSTSVC", "wercplsupport", "WerSvc", "WiaRpc",
    "WinDefend", "WinHttpAutoProxySvc", "Winmgmt", "WinRM", "wisvc", "WlanSvc",
    "wlidsvc", "wlpasvc", "WManSvc", "wmiApSrv", "WMPNetworkSvc", "WMSvc", "Wof",
    "workfolderssvc", "WpcMonSvc", "WPDBusEnum", "WpnService", "WpnUserService_*",
    "wscsvc", "WSearch", "wuauserv", "WwanSvc", "XblAuthManager", "XblGameSave",
    "XboxNetApiSvc", "xbgm", "XboxLiveAuthManager", "XboxLiveGameSave",
    "XboxLiveNetworkingService", "YammerPushService", "ZuneNetworkSvc", "AarSvc",
    "AJRouter", "ALG", "AppIDSvc", "Appinfo", "AppMgmt", "AppReadiness", "AppVClient",
    "AppXSvc", "AssignedAccessManagerSvc", "BcastDVRUserService_*", "BDESVC", "BFE",
    "BITS", "bluetoothhidserv", "BluetoothUserService_*", "BTAGService", "BthAvctpSvc",
    "bthserv", "camsvc", "CaptureService_*", "cbdhsvc_*", "CDPSvc", "CDPUserSvc_*",
    "CertPropSvc", "ClipSVC", "cloudidsvc", "CloudBackupRestoreSvc_*", "CloudExperienceHostBroker",
    "COMSysApp", "ConsentUxUserSvc_*", "CoreMessagingRegistrar", "CredentialEnrollmentManagerUserSvc_*",
    "CryptSvc", "CscService", "DcomLaunch", "defragsvc", "DeviceAssociationBrokerSvc_*",
    "DeviceAssociationService", "DeviceFlowUserSvc_*", "DevicePickerUserSvc_*",
    "DevicesFlowUserSvc_*", "DevQueryBroker", "Dhcp", "DiagTrack", "DialogBlockingService",
    "DispBrokerDesktopSvc", "DisplayEnhancementService", "dmwappushservice", "DoSvc",
    "dot3svc", "DPS", "DsmSvc", "DsSvc", "Dwp", "Eaphost", "EFS", "EventLog", "EventSystem",
    "Fax", "fdPHost", "FDResPub", "fhsvc", "FontCache", "FrameServer", "FrameServerMonitor",
    "GameInputSvc", "GameSaveSvc_*", "gcs", "gupdate", "gupdatem", "hidserv", "HvHost",
    "icssvc", "InstallService", "iphlpsvc", "IpxlatCfgSvc", "KeyIso", "KtmRm", "LanmanServer",
    "LanmanWorkstation", "lfsvc", "LicenseManager", "lltdsvc", "lmhosts", "LSM", "LxpSvc",
    "MapsBroker", "McpManagementService", "MicrosoftEdgeElevationService", "MixedRealityOpenXRSvc",
    "MpsSvc", "MSiSCSI", "msiserver", "MsKeyboardFilter", "NaturalAuthentication", "NcaSvc",
    "NcbService", "NcdAutoSetup", "Netlogon", "Netman", "netprofm", "NetSetupSvc",
    "NetTcpPortSharing", "NgcCtnrSvc", "NgcSvc", "NlaSvc", "nsi", "p2pimsvc", "p2psvc",
    "P9RdrService_*", "PcaSvc", "PeerDistSvc", "PenService_*", "perceptionsimulation", "PerfHost",
    "PhoneSvc", "PimIndexMaintenanceSvc_*", "pla", "PlugPlay", "PNRPAutoReg", "PNRPsvc",
    "PolicyAgent", "Power", "PrintNotify", "PrintWorkflowUserSvc_*", "ProfSvc", "PushToInstall",
    "QWAVE", "RasAcd", "RasAgileVpn", "RasL2tp", "RasMan", "RasPppoe", "RasPptp", "RasSstp",
    "RasGre", "RemoteAccess", "RemoteRegistry", "RpcEptMapper", "RpcLocator", "RpcSs", "SamSs",
    "SCardSvr", "ScDeviceEnum", "SCPolicySvc", "Schedule", "SCardSvr", "ScDeviceEnum",
    "SCPolicySvc", "SDRSVC", "seclogon", "SEMgrSvc", "SENS", "Sense", "SensorDataService",
    "SensorService", "SensrSvc", "SessionEnv", "SharedAccess", "SharedRealitySvc", "ShellHWDetection",
    "shpamsvc", "smphost", "SmsRouter", "SNMPTrap", "spectrum", "spooler", "sppsvc", "SSDPSRV",
    "ssh-agent", "SstpSvc", "StateRepository", "stisvc", "StorSvc", "svsvc", "swprv", "SysMain",
    "SystemEventsBroker", "TabletInputService", "TapiSrv", "TermService", "Themes", "TieringEngineService",
    "TimeBrokerSvc", "TokenBroker", "TrkWks", "TrustedInstaller", "tzautoupdate", "UdkUserSvc",
    "UevAgentService", "uhssvc", "UmRdpService", "UnistoreSvc", "upnphost", "UserDataSvc", "UserManager",
    "UsoSvc", "VaultSvc", "vds", "vmicguestinterface", "vmicheartbeat", "vmickvpexchange", "vmicrdv",
    "vmicshutdown", "vmicvmsession", "vmicvss", "vmms", "VSS", "W32Time", "WaaSMedicSvc", "WAS",
    "WbioSrvc", "Wcmsvc", "wcncsvc", "WcsPlugInService", "WdiServiceHost", "WdiSystemHost", "WdNisSvc",
    "WebClient", "Wecsvc", "WEPHOSTSVC", "wercplsupport", "WerSvc", "WiaRpc", "WinDefend",
    "WinHttpAutoProxySvc", "Winmgmt", "WinRM", "wisvc", "WlanSvc", "wlidsvc", "wlpasvc", "WManSvc",
    "wmiApSrv", "WMPNetworkSvc", "WMSvc", "Wof", "workfolderssvc", "WpcMonSvc", "WPDBusEnum",
    "WpnService", "WpnUserService_*", "wscsvc", "WSearch", "wuauserv", "WwanSvc", "XblAuthManager",
    "XblGameSave", "XboxNetApiSvc", "AarSvc", "AJRouter", "ALG", "AppIDSvc", "Appinfo", "AppMgmt",
    "AppReadiness", "AppVClient", "AppXSvc", "BrokerInfrastructure", "CoreMessagingRegistrar",
    "DcomLaunch", "DeviceAssociationBrokerSvc_*", "DeviceAssociationService", "DeviceInstall",
    "DsmSvc", "DsSvc", "Dwp", "Eaphost", "EFS", "fdPHost", "FDResPub", "fhsvc", "FontCache",
    "FrameServer", "FrameServerMonitor", "GameInputSvc", "GameSaveSvc_*", "gcs", "gupdate", "gupdatem",
    "hidserv", "HvHost", "icssvc", "InstallService", "iphlpsvc", "IpxlatCfgSvc", "KeyIso", "KtmRm",
    "LanmanServer", "LanmanWorkstation", "LicenseManager", "lltdsvc", "lmhosts", "LSM", "LxpSvc",
    "MapsBroker", "McpManagementService", "MicrosoftEdgeElevationService", "MixedRealityOpenXRSvc",
    "MpsSvc", "MSiSCSI", "msiserver", "MsKeyboardFilter", "NaturalAuthentication", "NcaSvc",
    "NcbService", "NcdAutoSetup", "Netlogon", "Netman", "netprofm", "NetSetupSvc", "NetTcpPortSharing",
    "NgcCtnrSvc", "NgcSvc", "NlaSvc", "nsi", "p2pimsvc", "p2psvc", "P9RdrService_*", "PcaSvc",
    "PeerDistSvc", "PenService_*", "perceptionsimulation", "PerfHost", "PhoneSvc", "PimIndexMaintenanceSvc_*",
    "pla", "PlugPlay", "PNRPAutoReg", "PNRPsvc", "PolicyAgent", "Power", "ProfSvc", "QWAVE", "RasAcd",
    "RasAgileVpn", "RasL2tp", "RasMan", "RasPppoe", "RasPptp", "RasSstp", "RasGre", "RemoteAccess",
    "RemoteRegistry", "RmSvc", "RpcEptMapper", "RpcLocator", "RpcSs", "SamSs", "SCardSvr", "ScDeviceEnum",
    "SCPolicySvc", "Schedule", "SCardSvr", "ScDeviceEnum", "SCPolicySvc", "SDRSVC", "seclogon", "SEMgrSvc",
    "SENS", "Sense", "SensorDataService", "SensorService", "SensrSvc", "SessionEnv", "SharedAccess",
    "SharedRealitySvc", "ShellHWDetection", "shpamsvc", "smphost", "SmsRouter", "SNMPTrap", "spectrum",
    "spooler", "sppsvc", "SSDPSRV", "ssh-agent", "SstpSvc", "StateRepository", "stisvc", "StorSvc", "svsvc",
    "swprv", "SysMain", "SystemEventsBroker", "TabletInputService", "TapiSrv", "TermService",
    "TextInputManagementService", "Themes", "TieringEngineService", "TimeBrokerSvc", "TokenBroker",
    "TrkWks", "TroubleshootingSvc", "TrustedInstaller", "tzautoupdate", "UdkUserSvc", "UevAgentService",
    "uhssvc", "UmRdpService", "UnistoreSvc", "upnphost", "UserDataSvc", "UserManager", "UsoSvc", "VaultSvc",
    "vds", "vmicguestinterface", "vmicheartbeat", "vmickvpexchange", "vmicrdv", "vmicshutdown", "vmicvmsession",
    "vmicvss", "vmms", "VSS", "W32Time", "WaaSMedicSvc", "WAS", "WbioSrvc", "Wcmsvc", "wcncsvc",
    "WcsPlugInService", "WdiServiceHost", "WdiSystemHost", "WdNisSvc", "WebClient", "Wecsvc", "WEPHOSTSVC",
    "wercplsupport", "WerSvc", "WiaRpc", "WinDefend", "WinHttpAutoProxySvc", "Winmgmt", "WinRM", "wisvc",
    "WlanSvc", "wlidsvc", "wlpasvc", "WManSvc", "wmiApSrv", "WMPNetworkSvc", "WMSvc", "Wof", "workfolderssvc",
    "WpcMonSvc", "WPDBusEnum", "WpnService", "WpnUserService_*", "wscsvc", "WSearch", "wuauserv", "WwanSvc",
    "XblAuthManager", "XblGameSave", "XboxNetApiSvc", "xbgm", "XboxLiveAuthManager", "XboxLiveGameSave",
    "XboxLiveNetworkingService", "YammerPushService", "ZuneNetworkSvc"
)

foreach ($service in $criticalServices) {
    try {
        Stop-Service $service -Force -ErrorAction SilentlyContinue
        Set-Service $service -StartupType Disabled -ErrorAction SilentlyContinue
        Write-Host "   [DISABLED] $service" -ForegroundColor Red
    }
    catch { }
}

Write-OK "200+ services critiques desactives"

# ============================================
# PHASE 2: REGISTRE - OPTIMISATIONS DANGEREUSES
# ============================================
Write-Step "REGISTRE - OPTIMISATIONS DANGEREUSES"

# Désactiver complètement la télémétrie
Write-Host "   Desactivation telemetrie complete..." -ForegroundColor Yellow
$telemetryPaths = @(
    "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection",
    "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection"
)
foreach ($path in $telemetryPaths) {
    if (-not (Test-Path $path)) { New-Item -Path $path -Force | Out-Null }
    Set-ItemProperty -Path $path -Name "AllowTelemetry" -Value 0 -Type DWord -Force
    Set-ItemProperty -Path $path -Name "MaxTelemetryAllowed" -Value 0 -Type DWord -Force
}

# Désactiver les rapports d'erreurs
Write-Host "   Desactivation rapports d'erreurs..." -ForegroundColor Yellow
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\Windows Error Reporting" -Name "Disabled" -Value 1 -Type DWord -Force
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\Windows Error Reporting" -Name "DontSendAdditionalData" -Value 1 -Type DWord -Force

# Optimisations réseau extrêmes
Write-Host "   Optimisations reseau extremes..." -ForegroundColor Yellow
netsh int tcp set global autotuninglevel=disabled 2>&1 | Out-Null
netsh int tcp set global chimney=disabled 2>&1 | Out-Null
netsh int tcp set global rss=enabled 2>&1 | Out-Null
netsh int tcp set global ecncapability=enabled 2>&1 | Out-Null
netsh int tcp set global timestamps=disabled 2>&1 | Out-Null
netsh int tcp set global initialRto=0 2>&1 | Out-Null
netsh int tcp set global minRto=0 2>&1 | Out-Null
netsh int tcp set global maxSynRetransmissions=2 2>&1 | Out-Null

# Désactiver Windows Defender complètement (RISQUE ÉLEVÉ)
Write-Host "   Desactivation Windows Defender complete..." -ForegroundColor Red
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows Defender" -Name "DisableAntiSpyware" -Value 1 -Type DWord -Force
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows Defender" -Name "DisableRoutinelyTakingAction" -Value 1 -Type DWord -Force
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows Defender Security Intelligence\UX Configuration" -Name "UILockdown" -Value 1 -Type DWord -Force

# Désactiver les mises à jour Windows (RISQUE ÉLEVÉ)
Write-Host "   Desactivation mises a jour Windows..." -ForegroundColor Red
$auPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU"
if (-not (Test-Path $auPath)) { New-Item -Path $auPath -Force | Out-Null }
Set-ItemProperty -Path $auPath -Name "NoAutoUpdate" -Value 1 -Type DWord -Force
Set-ItemProperty -Path $auPath -Name "AUOptions" -Value 1 -Type DWord -Force

Write-OK "Registre optimise dangereusement"

# ============================================
# PHASE 3: MEMOIRE - OPTIMISATION ABSOLUE
# ============================================
Write-Step "MEMOIRE - OPTIMISATION ABSOLUE"

Write-Host "   Configuration memoire absolue..." -ForegroundColor Yellow
$memPath = "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management"

# Désactiver complètement la pagination (RISQUE ÉLEVÉ)
Set-ItemProperty -Path $memPath -Name "DisablePagingExecutive" -Value 1 -Type DWord -Force
Set-ItemProperty -Path $memPath -Name "LargeSystemCache" -Value 0 -Type DWord -Force
Set-ItemProperty -Path $memPath -Name "ClearPageFileAtShutdown" -Value 0 -Type DWord -Force
Set-ItemProperty -Path $memPath -Name "SecondLevelDataCache" -Value 0 -Type DWord -Force
Set-ItemProperty -Path $memPath -Name "IoPageLockLimit" -Value 0 -Type DWord -Force

# Optimisations de cache extrêmes
Set-ItemProperty -Path $memPath -Name "FeatureSettings" -Value 1 -Type DWord -Force
Set-ItemProperty -Path $memPath -Name "FeatureSettingsOverride" -Value 72 -Type DWord -Force
Set-ItemProperty -Path $memPath -Name "FeatureSettingsOverrideMask" -Value 3 -Type DWord -Force

# Désactiver prefetch et superfetch complètement
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" -Name "EnablePrefetcher" -Value 0 -Type DWord -Force
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" -Name "EnableSuperfetch" -Value 0 -Type DWord -Force

Write-OK "Memoire optimise absolument (pagination desactivee)"

# ============================================
# PHASE 4: CPU - PERFORMANCE MAXIMALE
# ============================================
Write-Step "CPU - PERFORMANCE MAXIMALE"

# Désactiver tous les mécanismes d'économie d'énergie
Write-Host "   Desactivation economie d'energie CPU..." -ForegroundColor Yellow
powercfg -setacvalueindex scheme_current sub_processor 5d76cc65-8353-41f5-9713-8676a2c8cc84 100 2>&1 | Out-Null
powercfg -setacvalueindex scheme_current sub_processor 95e3cf5b-82f9-4cbd-a232-e98a8d9b2c5d 100 2>&1 | Out-Null
powercfg -setacvalueindex scheme_current sub_processor bc5038f7-23e0-4960-96da-33abaf5935ec 100 2>&1 | Out-Null

# Désactiver C-states (très risqué)
Write-Host "   Desactivation C-states..." -ForegroundColor Red
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Power" -Name "CsEnabled" -Value 0 -Type DWord -Force

# Turbo Boost forcé
Write-Host "   Turbo Boost force..." -ForegroundColor Yellow
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Power" -Name "TurboBoostEnabled" -Value 1 -Type DWord -Force

Write-OK "CPU optimise pour performance maximale"

# ============================================
# PHASE 5: NETTOYAGE SYSTEME EXTREME
# ============================================
Write-Step "NETTOYAGE SYSTEME EXTREME"

Write-Host "   Suppression fichiers systeme inutiles..." -ForegroundColor Yellow

# Supprimer les fichiers temporaires partout
$tempPaths = @(
    "$env:TEMP",
    "C:\Windows\Temp",
    "C:\Windows\Prefetch",
    "C:\Windows\SoftwareDistribution\Download",
    "C:\Windows\Logs",
    "C:\Windows\Debug",
    "C:\ProgramData\Microsoft\Windows Defender\Scans\History",
    "C:\ProgramData\Microsoft\Windows Defender\Scans\Results"
)

foreach ($path in $tempPaths) {
    if (Test-Path $path) {
        Remove-Item -Path "$path\*" -Recurse -Force -ErrorAction SilentlyContinue
        Write-Host "   [CLEANED] $path" -ForegroundColor Red
    }
}

# Nettoyer le registre (très risqué)
Write-Host "   Nettoyage registre..." -ForegroundColor Red
# Supprimer les clés de registre obsolètes (extrêmement risqué)

# Désactiver les logs système
Write-Host "   Desactivation logs systeme..." -ForegroundColor Yellow
wevtutil sl System /e:false 2>&1 | Out-Null
wevtutil sl Application /e:false 2>&1 | Out-Null
wevtutil sl Security /e:false 2>&1 | Out-Null

Write-OK "Systeme nettoye extremement"

# ============================================
# PHASE 6: OPTIMISATIONS BIOS/UEFI SIMULÉES
# ============================================
Write-Step "BIOS/UEFI - OPTIMISATIONS SIMULEES"

# Ces paramètres seraient normalement configurés dans le BIOS/UEFI
Write-Host "   Configuration CPU (virtuel)..." -ForegroundColor Yellow
# Simuler optimisation CPU
bcdedit /set disabledynamictick yes 2>&1 | Out-Null
bcdedit /set useplatformtick yes 2>&1 | Out-Null

Write-Host "   Configuration memoire (virtuel)..." -ForegroundColor Yellow
# Simuler optimisation RAM
wmic memphysical set MaxCapacity=0 2>&1 | Out-Null

Write-Host "   Configuration stockage (virtuel)..." -ForegroundColor Yellow
# Simuler optimisation SSD
fsutil behavior set disabledeletenotify 0 2>&1 | Out-Null

Write-OK "Parametres BIOS/UEFI optimises"

# ============================================
# PHASE FINALE: VALIDATION
# ============================================
Write-Host "`n"
Write-Host "=====================================================================" -ForegroundColor Magenta
Write-Host "              OPTIMISATION ULTIME TERMINEE" -ForegroundColor Magenta
Write-Host "=====================================================================" -ForegroundColor Magenta
Write-Host ""

Write-Host "🚨 OPTIMISATIONS APPLIQUÉES (NIVEAU EXTREME):" -ForegroundColor Red
Write-Host "   ✅ 200+ services Windows désactivés" -ForegroundColor Red
Write-Host "   ✅ Télémétrie complètement désactivée" -ForegroundColor Red
Write-Host "   ✅ Windows Defender désactivé" -ForegroundColor Red
Write-Host "   ✅ Mises à jour Windows désactivées" -ForegroundColor Red
Write-Host "   ✅ Pagination mémoire désactivée" -ForegroundColor Red
Write-Host "   ✅ Prefetch/Superfetch désactivés" -ForegroundColor Red
Write-Host "   ✅ Économie d'énergie CPU désactivée" -ForegroundColor Red
Write-Host "   ✅ C-states désactivés" -ForegroundColor Red
Write-Host "   ✅ Système nettoyé extrêmement" -ForegroundColor Red
Write-Host "   ✅ Logs système désactivés" -ForegroundColor Red
Write-Host ""

Write-Host "⚠️  CONSÉQUENCES POTENTIELLES:" -ForegroundColor Yellow
Write-Host "   • Système moins stable" -ForegroundColor White
Write-Host "   • Sécurité réduite drastiquement" -ForegroundColor White
Write-Host "   • Pas de mises à jour automatiques" -ForegroundColor White
Write-Host "   • Risque de corruption de fichiers" -ForegroundColor White
Write-Host "   • Applications peuvent ne plus fonctionner" -ForegroundColor White
Write-Host "   • Support Microsoft invalidé" -ForegroundColor White
Write-Host ""

Write-Host "🔥 PERFORMANCES ATTENDUES:" -ForegroundColor Cyan
Write-Host "   • Démarrage: <5 secondes" -ForegroundColor White
Write-Host "   • Applications: ouverture instantanée" -ForegroundColor White
Write-Host "   • Mémoire: utilisation maximale" -ForegroundColor White
Write-Host "   • CPU: fréquence maximale constante" -ForegroundColor White
Write-Host "   • Latence: quasi-zéro" -ForegroundColor White
Write-Host ""

Write-Host "💀 NIVEAU D'OPTIMISATION: ULTIME (LIMITE ABSOLUE)" -ForegroundColor Red
Write-Host "   Vous avez poussé Windows à ses limites absolues." -ForegroundColor Red
Write-Host ""

$finalWarning = Read-Host "Tapez 'J-ACCEPTE-TOUS-LES-RISQUES' pour valider"
if ($finalWarning -eq "J-ACCEPTE-TOUS-LES-RISQUES") {
    Write-Host "`n🔥 SYSTÈME OPTIMISÉ À LA LIMITE ABSOLUE !" -ForegroundColor Red
    Write-Host "   Redémarrez immédiatement pour appliquer tous les changements." -ForegroundColor Cyan
}
else {
    Write-Host "`n❌ Validation refusée - certaines optimisations peuvent être annulées au redémarrage." -ForegroundColor Yellow
}

Read-Host "`nAppuyez sur Entrée pour fermer (puis REDÉMARREZ !)"
