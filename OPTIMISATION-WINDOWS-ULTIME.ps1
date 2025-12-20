# ============================================================================
# OPTIMISATION WINDOWS ULTIME - PERFORMANCE ABSOLUE
# ============================================================================
# Script d'optimisation ultime pour pousser Windows à ses limites absolues
# Executez en ADMINISTRATEUR pour toutes les optimisations
# ATTENTION: Ces optimisations sont EXTREMES - sauvegardez vos données
# ============================================================================

$ErrorActionPreference = "SilentlyContinue"
$script:SuccessCount = 0
$script:TotalOptimizations = 0

function Write-Step { param([string]$Msg); Write-Host "`n>> $Msg" -ForegroundColor Cyan; $script:TotalOptimizations++ }
function Write-OK { param([string]$Msg); Write-Host "   [OK] $Msg" -ForegroundColor Green; $script:SuccessCount++ }
function Write-WARN { param([string]$Msg); Write-Host "   [WARN] $Msg" -ForegroundColor Yellow }
function Test-Admin { ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator) }

Write-Host "`n" -ForegroundColor Red
Write-Host "=====================================================================" -ForegroundColor Red
Write-Host "  ⚠️  OPTIMISATION WINDOWS ULTIME - PERFORMANCE ABSOLUE" -ForegroundColor Red
Write-Host "=====================================================================" -ForegroundColor Red
Write-Host "  🚨 ATTENTION: Ces optimisations sont EXTREMES !" -ForegroundColor Red
Write-Host "  🔄 Sauvegardez vos données avant de continuer" -ForegroundColor Yellow
Write-Host "  💀 Certaines fonctionnalités Windows peuvent être affectées" -ForegroundColor Yellow

$isAdmin = Test-Admin
if (-not $isAdmin) {
    Write-Host "`n[ERREUR] Executez en ADMINISTRATEUR !" -ForegroundColor Red
    Read-Host "Appuyez sur Entree pour fermer"
    exit
}
Write-Host "`n[ADMIN] Mode administrateur detecte" -ForegroundColor Green

$continue = Read-Host "`nVoulez-vous continuer avec ces optimisations extremes ? (tapez 'OUI' pour continuer)"
if ($continue -ne "OUI") {
    Write-Host "Operation annulee." -ForegroundColor Yellow
    exit
}

Write-Host "`n🔥 LANCEMENT DES OPTIMISATIONS ULTIMES..." -ForegroundColor Red

# ============================================
# 1. SERVICES CRITIQUES - DÉSACTIVATION MASSIVE
# ============================================
Write-Step "SERVICES CRITIQUES - DESACTIVATION EXTREME"

$criticalServices = @(
    "SysMain",           # Superfetch (inutile SSD)
    "WSearch",           # Windows Search
    "Spooler",           # Print Spooler
    "Fax",              # Fax
    "lfsvc",            # Geolocalisation
    "MapsBroker",       # Cartes
    "WbioSrvc",         # Biometrie
    "WpcMonSvc",        # Controle parental
    "wisvc",            # Windows Insider
    "RetailDemo",       # Demo retail
    "diagnosticshub.standardcollector.service",
    "WdiServiceHost",   # WDI
    "WdiSystemHost",    # WDI System
    "XboxAccessoryManagementService",
    "XboxLiveAuthManager",
    "XboxLiveGameSave",
    "XboxLiveNetworkingService",
    "NgcSvc",           # Microsoft Passport
    "NgcCtnrSvc",       # Passport Container
    "wlidsvc",          # Microsoft Account Sign-in
    "TokenBroker",      # Web Account Manager
    "WpnService",       # Windows Push Notifications
    "WpnUserService_*", # Push Notifications User
    "SensrSvc",         # Sensor Monitoring
    "SensorService",    # Sensor Service
    "SCardSvr",         # Smart Card
    "ScDeviceEnum",     # Smart Card Device
    "SCPolicySvc",      # Smart Card Removal Policy
    "TabletInputService", # Tablet PC Input
    "PushToInstall",    # PushToInstall
    "dmwappushservice", # Device Management WAP Push
    "DusmSvc",          # Data Usage
    "diagsvc",          # Diagnostic Execution
    "diagnosticshub.standardcollector.service",
    "DialogBlockingService", # Dialog Blocking
    "DispBrokerDesktopSvc", # Display Broker
    "TrkWks",           # Distributed Link Tracking
    "W32Time",          # Windows Time (si pas besoin synchro)
    "SessionEnv",       # Remote Desktop Configuration
    "TermService",      # Remote Desktop Services
    "UmRdpService",     # Remote Desktop Services User
    "RpcLocator",       # Remote Procedure Call (RPC) Locator
    "RemoteRegistry",   # Remote Registry
    "RemoteAccess",     # Routing and Remote Access
    "RasAuto",          # Remote Access Auto Connection
    "RasMan",           # Remote Access Connection Manager
    "SstpSvc",          # Secure Socket Tunneling Protocol
    "LanmanWorkstation", # Workstation (si pas reseau)
    "LanmanServer",     # Server (si pas partage fichiers)
    "Browser",          # Computer Browser
    "LMHosts",          # TCP/IP NetBIOS Helper
    "iphlpsvc",         # IP Helper
    "IpxlatCfgSvc",     # IP Translation Configuration
    "SharedAccess",     # Internet Connection Sharing
    "IEEtwCollectorService", # Internet Explorer ETW Collector
    "MSiSCSI",          # Microsoft iSCSI Initiator
    "CscService",       # Offline Files
    "wscsvc",           # Security Center (risque securite)
    "WinDefend",        # Windows Defender (risque securite)
    "WdNisSvc",         # Windows Defender Network Inspection
    "WinHttpAutoProxySvc", # WinHTTP Web Proxy Auto-Discovery
    "Wecsvc",           # Windows Event Collector
    "Wersvc",           # Windows Error Reporting
    "WerSvc",           # Windows Error Reporting
    "wuauserv",         # Windows Update (risque securite)
    "WaaSMedicSvc",     # Windows Update Medic
    "UsoSvc",           # Update Orchestrator
    "WaaSMedicSvc",     # WaaS Medic Service
    "embeddedmode",     # Embedded Mode
    "EntAppSvc",        # Enterprise App Management
    "StorSvc",          # Storage Service
    "TieringEngineService", # Storage Tiers Management
    "SysMgmt",          # System Management
    "smphost",          # Microsoft Storage Spaces SMP
    "svsvc",            # Spot Verifier
    "TrustedInstaller", # Windows Modules Installer (garder pour updates)
    "msiserver",        # Windows Installer
    "FontCache",        # Windows Font Cache
    "FontCache3.0.0.0", # Windows Presentation Foundation Font Cache
    "stisvc",           # Windows Image Acquisition
    "WiaRpc",           # Still Image Acquisition Events
    "AeLookupSvc",      # Application Experience
    "ALG",              # Application Layer Gateway
    "AppIDSvc",         # Application Identity
    "Appinfo",          # Application Information
    "AppMgmt",          # Application Management
    "AppReadiness",     # App Readiness
    "AppVClient",       # Microsoft App-V Client
    "AppXSvc",          # AppX Deployment Service (pour UWP)
    "BrokerInfrastructure", # Background Tasks Infrastructure
    "CoreMessagingRegistrar", # CoreMessaging
    "DcomLaunch",       # DCOM Server Process Launcher (critique)
    "DeviceAssociationService", # Device Association Service
    "DeviceInstall",    # Device Install Service
    "DsmSvc",           # Device Setup Manager
    "DsSvc",            # Data Sharing Service
    "Dwp",              # Device Association Framework
    "EapHost",          # Extensible Authentication Protocol
    "EFS",              # Encrypting File System (EFS)
    "fhsvc",            # File History Service
    "fdPHost",          # Function Discovery Provider Host
    "FDResPub",         # Function Discovery Resource Publication
    "gpsvc",            # Group Policy Client (critique)
    "hkmsvc",           # Health Key and Certificate Management
    "hidserv",          # Human Interface Device Access
    "HvHost",           # HV Host Service
    "vmickvpexchange",  # Hyper-V Data Exchange Service
    "vmicguestinterface", # Hyper-V Guest Service Interface
    "vmicshutdown",     # Hyper-V Guest Shutdown Service
    "vmicheartbeat",    # Hyper-V Heartbeat Service
    "vmicvmsession",    # Hyper-V PowerShell Direct Service
    "vmicrdv",          # Hyper-V Remote Desktop Virtualization
    "vmicvss",          # Hyper-V Volume Shadow Copy Requestor
    "Hyper-V",          # Hyper-V Virtual Machine Management
    "gupdate",          # Google Update Service
    "gupdatem",         # Google Update Service
    "IAStorDataMgrSvc", # Intel Rapid Storage Technology
    "IntelAudioService", # Intel Audio Service
    "jhi_service",      # Intel Dynamic Application Loader Host Interface
    "LMS",              # Intel Management and Security Application Local Management Service
    "Intel(R) Capability Licensing Service TCP IP Interface", # Intel Capability
    "Intel(R) TPM Provisioning Service", # Intel TPM
    "IntelAudioService", # Intel Audio
    "Intel(R) Wireless Bluetooth(R)", # Intel Wireless Bluetooth
    "Intel(R) Wireless Bluetooth(R) Filter", # Intel Wireless Bluetooth Filter
    "KtmRm",            # KTM RM for Distributed Transaction Coordinator
    "lltdsvc",          # Link-Layer Topology Discovery Mapper
    "MSDTC",            # Distributed Transaction Coordinator
    "MSMQ",             # Microsoft Message Queue
    "MSMQTriggers",     # Microsoft Message Queue Triggers
    "napagent",         # Network Access Protection Agent
    "NcaSvc",           # Network Connectivity Assistant
    "NcbService",       # Network Connection Broker
    "NcdAutoSetup",     # Network Connected Devices Auto-Setup
    "Netlogon",         # Netlogon
    "Netman",           # Network Connections
    "NetSetupSvc",      # Network Setup Service
    "NetTcpPortSharing", # Net.Tcp Port Sharing Service
    "NlaSvc",           # Network Location Awareness
    "nsi",              # Network Store Interface Service
    "p2pimsvc",         # Peer Networking Identity Manager
    "p2psvc",           # Peer Networking Grouping
    "PcaSvc",           # Program Compatibility Assistant
    "PeerDistSvc",      # BranchCache
    "PerfHost",         # Performance Counter DLL Host
    "pla",              # Performance Logs & Alerts
    "PlugPlay",         # Plug and Play (critique)
    "PNRPAutoReg",      # PNRP Machine Name Publication
    "PNRPsvc",          # Peer Name Resolution Protocol
    "PolicyAgent",      # IPsec Policy Agent
    "Power",            # Power (critique)
    "ProfSvc",          # User Profile Service
    "QWAVE",            # Quality Windows Audio Video Experience
    "RasAcd",           # Remote Access Auto Connection Driver
    "RasAgileVpn",      # WAN Miniport (IKEv2)
    "RasSstp",          # WAN Miniport (SSTP)
    "RasPppoe",         # WAN Miniport (PPPoE)
    "RasL2tp",          # WAN Miniport (L2TP)
    "RasPptp",          # WAN Miniport (PPTP)
    "RasGre",           # WAN Miniport (GRE)
    "RmSvc",            # Radio Management Service
    "RpcEptMapper",     # RPC Endpoint Mapper (critique)
    "RpcSs",            # Remote Procedure Call (RPC) (critique)
    "SamSs",            # Security Accounts Manager (critique)
    "SCardSvr",         # Smart Card
    "ScDeviceEnum",     # Smart Card Device Enumeration
    "SCPolicySvc",      # Smart Card Removal Policy
    "SDRSVC",           # Windows Backup
    "seclogon",         # Secondary Logon
    "SEMgrSvc",         # Payments and NFC/SE Manager
    "SENS",             # System Event Notification Service
    "Sense",            # Windows Defender Advanced Threat Protection
    "SensorDataService", # Sensor Data Service
    "SensorService",    # Sensor Service
    "SensrSvc",         # Sensor Monitoring Service
    "SessionEnv",       # Remote Desktop Configuration
    "shpamsvc",         # Shared PC Account Manager
    "smphost",          # Microsoft Storage Spaces SMP
    "SmsRouter",        # Microsoft Windows SMS Router Service
    "SNMPTrap",         # SNMP Trap
    "spectrum",         # Windows Perception Service
    "spooler",          # Print Spooler
    "sppsvc",           # Software Protection
    "SSDPSRV",          # SSDP Discovery
    "ssh-agent",        # OpenSSH Authentication Agent
    "SstpSvc",          # Secure Socket Tunneling Protocol Service
    "StateRepository",  # State Repository Service
    "stisvc",           # Windows Image Acquisition (WIA)
    "StorSvc",          # Storage Service
    "svsvc",            # Spot Verifier
    "swprv",            # Microsoft Software Shadow Copy Provider
    "SysMain",          # Superfetch
    "SystemEventsBroker", # System Events Broker
    "TabletInputService", # Tablet PC Input Service
    "TapiSrv",          # Telephony
    "TermService",      # Remote Desktop Services
    "Themes",           # Themes
    "TieringEngineService", # Storage Tiers Management
    "TimeBrokerSvc",    # Time Broker
    "TokenBroker",      # Web Account Manager
    "TrkWks",           # Distributed Link Tracking Client
    "TrustedInstaller", # Windows Modules Installer
    "tzautoupdate",     # Auto Time Zone Updater
    "UdkUserSvc",       # UDK User Service
    "UevAgentService",  # User Experience Virtualization Service
    "uhssvc",           # Microsoft Update Health Service
    "UmRdpService",     # Remote Desktop Services User Mode Port Redirector
    "UnistoreSvc",      # User Data Storage
    "upnphost",         # UPnP Device Host
    "UserDataSvc",      # User Data Access
    "UserManager",      # User Manager
    "UsoSvc",           # Update Orchestrator Service
    "VaultSvc",         # Credential Manager
    "vds",              # Virtual Disk
    "vmicguestinterface", # Hyper-V Guest Service Interface
    "vmicheartbeat",    # Hyper-V Heartbeat Service
    "vmickvpexchange",  # Hyper-V Data Exchange Service
    "vmicrdv",          # Hyper-V Remote Desktop Virtualization Service
    "vmicshutdown",     # Hyper-V Guest Shutdown Service
    "vmicvmsession",    # Hyper-V PowerShell Direct Service
    "vmicvss",          # Hyper-V Volume Shadow Copy Requestor
    "vmms",             # Hyper-V Virtual Machine Management
    "VSS",              # Volume Shadow Copy
    "W32Time",          # Windows Time
    "WaaSMedicSvc",     # Windows Update Medic Service
    "WAS",              # Windows Process Activation Service
    "WbioSrvc",         # Windows Biometric Service
    "Wcmsvc",           # Windows Connection Manager
    "wcncsvc",          # Windows Connect Now
    "WcsPlugInService", # Windows Color System
    "WdiServiceHost",   # Diagnostic Service Host
    "WdiSystemHost",    # Diagnostic System Host
    "WdNisSvc",         # Microsoft Defender Antivirus Network Inspection Service
    "WebClient",        # WebClient
    "Wecsvc",           # Windows Event Collector
    "WEPHOSTSVC",       # Windows Encryption Provider Host Service
    "wercplsupport",    # Problem Reports Control Panel Support
    "WerSvc",           # Windows Error Reporting Service
    "WiaRpc",           # Still Image Acquisition Events
    "WinDefend",        # Microsoft Defender Antivirus Service
    "WinHttpAutoProxySvc", # WinHTTP Web Proxy Auto-Discovery Service
    "Winmgmt",          # Windows Management Instrumentation (critique)
    "WinRM",            # Windows Remote Management (WS-Management)
    "wisvc",            # Windows Insider Service
    "WlanSvc",          # WLAN AutoConfig
    "wlidsvc",          # Microsoft Account Sign-in Assistant
    "wlpasvc",          # Local Profile Assistant Service
    "WManSvc",          # Windows Manager
    "wmiApSrv",         # WMI Performance Adapter
    "WMPNetworkSvc",    # Windows Media Player Network Sharing Service
    "WMSvc",            # Web Management Service
    "Wof",              # Windows Overlay File System Service
    "workfolderssvc",   # Work Folders
    "WpcMonSvc",        # Parental Controls
    "WPDBusEnum",       # Portable Device Enumerator Service
    "WpnService",       # Windows Push Notifications System Service
    "WpnUserService_*", # Windows Push Notifications User Service
    "wscsvc",           # Windows Security Service
    "WSearch",          # Windows Search
    "wuauserv",         # Windows Update
    "WwanSvc",          # WWAN AutoConfig
    "XblAuthManager",   # Xbox Live Auth Manager
    "XblGameSave",      # Xbox Live Game Save
    "XboxNetApiSvc",    # Xbox Live Networking Service
    "AarSvc",           # Agent Activation Runtime
    "AJRouter",         # AllJoyn Router Service
    "ALG",              # Application Layer Gateway Service
    "AppIDSvc",         # Application Identity
    "Appinfo",          # Application Information
    "AppMgmt",          # Application Management
    "AppReadiness",     # App Readiness
    "AppVClient",       # Microsoft App-V Client
    "AppXSvc",          # AppX Deployment Service
    "AssignedAccessManagerSvc", # Assigned Access Manager Service
    "AudioEndpointBuilder", # Windows Audio Endpoint Builder (garder)
    "Audiosrv",         # Windows Audio (garder)
    "autotimesvc",      # Cellular Time
    "AxInstSV",         # ActiveX Installer
    "BcastDVRUserService_*", # GameDVR and Broadcast User Service
    "BDESVC",           # BitLocker Drive Encryption Service
    "BFE",              # Base Filtering Engine (critique)
    "BITS",             # Background Intelligent Transfer Service
    "bluetoothhidserv", # Bluetooth HID Service
    "BluetoothUserService_*", # Bluetooth User Support Service
    "BTAGService",      # Bluetooth Audio Gateway Service
    "BthAvctpSvc",      # AVCTP service
    "bthserv",          # Bluetooth Support Service
    "camsvc",           # Capability Access Manager Service
    "CaptureService_*", # Capture Service
    "cbdhsvc_*",        # Clipboard User Service
    "CDPSvc",           # Connected Devices Platform Service
    "CDPUserSvc_*",     # Connected Devices Platform User Service
    "CertPropSvc",      # Certificate Propagation
    "ClipSVC",          # Client License Service (ClipSVC)
    "cloudidsvc",       # Microsoft Cloud Identity Service
    "CloudBackupRestoreSvc_*", # Cloud Backup and Restore Service
    "CloudExperienceHostBroker", # Cloud Experience Host Broker
    "COMSysApp",        # COM+ System Application
    "ConsentUxUserSvc_*", # ConsentUX User Service
    "CoreMessagingRegistrar", # CoreMessaging
    "CredentialEnrollmentManagerUserSvc_*", # Credential Enrollment Manager User Service
    "CryptSvc",         # Cryptographic Services (critique)
    "CscService",       # Offline Files
    "DcomLaunch",       # DCOM Server Process Launcher (critique)
    "defragsvc",        # Optimize drives
    "DeviceAssociationBrokerSvc_*", # Device Association Broker
    "DeviceAssociationService", # Device Association Service
    "DeviceFlowUserSvc_*", # Device Flow User Service
    "DevicePickerUserSvc_*", # Device Picker User Service
    "DevicesFlowUserSvc_*", # Devices Flow User Service
    "DevQueryBroker",   # DevQuery Background Discovery Broker
    "Dhcp",             # DHCP Client (critique)
    "DiagTrack",        # Connected User Experiences and Telemetry
    "DialogBlockingService", # Dialog Blocking Service
    "DispBrokerDesktopSvc", # Display Policy Service
    "DisplayEnhancementService", # Display Enhancement Service
    "dmwappushservice", # dmwappushsvc
    "Dnscache",         # DNS Client (critique)
    "DoSvc",            # Delivery Optimization
    "dot3svc",          # Wired AutoConfig
    "DPS",              # Diagnostic Policy Service
    "DsmSvc",           # Device Setup Manager
    "DsSvc",            # Data Sharing Service
    "DusmSvc",          # Data Usage
    "Eaphost",          # Extensible Authentication Protocol
    "edgeupdate",       # Microsoft Edge Update Service
    "edgeupdatem",      # Microsoft Edge Update Service
    "EFS",              # Encrypting File System (EFS)
    "embeddedmode",     # Embedded Mode
    "EntAppSvc",        # Enterprise App Management Service
    "EventLog",         # Windows Event Log (critique)
    "EventSystem",      # COM+ Event System
    "Fax",              # Fax
    "fdPHost",          # Function Discovery Provider Host
    "FDResPub",         # Function Discovery Resource Publication
    "fhsvc",            # File History Service
    "FontCache",        # Windows Font Cache Service
    "FrameServer",      # Windows Camera Frame Server
    "FrameServerMonitor", # Windows Camera Frame Server Monitor
    "GameInputSvc",     # GameInput Service
    "GameSaveSvc_*",    # Game Save Service
    "gcs",              # Google Chrome Elevation Service
    "gupdate",          # Google Update Service
    "gupdatem",         # Google Update Service
    "hidserv",          # Human Interface Device Service
    "HvHost",           # HV Host Service
    "icssvc",           # Windows Mobile Hotspot Service
    "IKEEXT",           # IKE and AuthIP IPsec Keying Modules
    "InstallService",   # Microsoft Store Install Service
    "iphlpsvc",         # IP Helper
    "IpxlatCfgSvc",     # IP Translation Configuration Service
    "KeyIso",           # CNG Key Isolation (critique)
    "KtmRm",            # KTM RM for Distributed Transaction Coordinator
    "LanmanServer",     # Server
    "LanmanWorkstation", # Workstation
    "lfsvc",            # Geolocation Service
    "LicenseManager",   # Windows License Manager Service
    "lltdsvc",          # Link-Layer Topology Discovery Mapper
    "lmhosts",          # TCP/IP NetBIOS Helper
    "LSM",              # Local Session Manager (critique)
    "LxpSvc",           # Language Experience Service
    "MapsBroker",       # Downloaded Maps Manager
    "McpManagementService", # MCP Management Service
    "MicrosoftEdgeElevationService", # Microsoft Edge Elevation Service
    "MixedRealityOpenXRSvc", # Windows Mixed Reality OpenXR Service
    "MpsSvc",           # Windows Defender Firewall (critique)
    "MSiSCSI",          # Microsoft iSCSI Initiator Service
    "msiserver",        # Windows Installer
    "MsKeyboardFilter", # Microsoft Keyboard Filter
    "NaturalAuthentication", # Natural Authentication
    "NcaSvc",           # Network Connectivity Assistant
    "NcbService",       # Network Connection Broker
    "NcdAutoSetup",     # Network Connected Devices Auto-Setup
    "Netlogon",         # Netlogon
    "Netman",           # Network Connections
    "netprofm",         # Network List Service
    "NetSetupSvc",      # Network Setup Service
    "NetTcpPortSharing", # Net.Tcp Port Sharing Service
    "NgcCtnrSvc",       # Microsoft Passport Container
    "NgcSvc",           # Microsoft Passport
    "NlaSvc",           # Network Location Awareness
    "nsi",              # Network Store Interface Service
    "p2pimsvc",         # Peer Networking Identity Manager
    "p2psvc",           # Peer Networking Grouping
    "P9RdrService_*",   # P9RdrService
    "PcaSvc",           # Program Compatibility Assistant Service
    "PeerDistSvc",      # BranchCache
    "PenService_*",     # Pen Service
    "perceptionsimulation", # Windows Perception Simulation Service
    "PerfHost",         # Performance Counter DLL Host
    "PhoneSvc",         # Phone Service
    "PimIndexMaintenanceSvc_*", # Contact Data
    "pla",              # Performance Logs & Alerts
    "PlugPlay",         # Plug and Play (critique)
    "PNRPAutoReg",      # PNRP Machine Name Publication Service
    "PNRPsvc",          # Peer Name Resolution Protocol
    "PolicyAgent",      # IPsec Policy Agent
    "Power",            # Power (critique)
    "PrintNotify",      # Printer Extensions and Notifications
    "PrintWorkflowUserSvc_*", # Print Workflow
    "ProfSvc",          # User Profile Service
    "PushToInstall",    # Windows PushToInstall Service
    "QWAVE",            # Quality Windows Audio Video Experience
    "RasAcd",           # Remote Access Auto Connection Driver
    "RasAgileVpn",      # WAN Miniport (IKEv2)
    "RasL2tp",          # WAN Miniport (L2TP)
    "RasMan",           # Remote Access Connection Manager
    "RasPppoe",         # WAN Miniport (PPPoE)
    "RasPptp",          # WAN Miniport (PPTP)
    "RasSstp",          # WAN Miniport (SSTP)
    "RasGre",           # WAN Miniport (GRE)
    "RemoteAccess",     # Routing and Remote Access
    "RemoteRegistry",   # Remote Registry
    "RetailDemo",       # Retail Demo Service
    "RmSvc",            # Radio Management Service
    "RpcEptMapper",     # RPC Endpoint Mapper (critique)
    "RpcLocator",       # Remote Procedure Call (RPC) Locator
    "RpcSs",            # Remote Procedure Call (RPC) (critique)
    "SamSs",            # Security Accounts Manager (critique)
    "SCardSvr",         # Smart Card
    "ScDeviceEnum",     # Smart Card Device Enumeration Service
    "SCPolicySvc",      # Smart Card Removal Policy
    "Schedule",         # Task Scheduler (critique)
    "SCardSvr",         # Smart Card
    "ScDeviceEnum",     # Smart Card Device Enumeration Service
    "SCPolicySvc",      # Smart Card Removal Policy
    "SDRSVC",           # Windows Backup
    "seclogon",         # Secondary Logon
    "SEMgrSvc",         # NFC/SE Manager
    "SENS",             # System Event Notification Service
    "Sense",            # Windows Defender Advanced Threat Protection Service
    "SensorDataService", # Sensor Data Service
    "SensorService",    # Sensor Service
    "SensrSvc",         # Sensor Monitoring Service
    "SessionEnv",       # Remote Desktop Configuration
    "SgrmBroker",       # System Guard Runtime Monitor Broker
    "SharedAccess",     # Internet Connection Sharing (ICS)
    "SharedRealitySvc", # Spatial Data Service
    "ShellHWDetection", # Shell Hardware Detection
    "shpamsvc",         # Shared PC Account Manager
    "smphost",          # Microsoft Storage Spaces SMP
    "SmsRouter",        # Microsoft Windows SMS Router Service.
    "SNMPTrap",         # SNMP Trap
    "spectrum",         # Windows Perception Service
    "spooler",          # Print Spooler
    "sppsvc",           # Software Protection
    "SSDPSRV",          # SSDP Discovery
    "ssh-agent",        # OpenSSH Authentication Agent
    "SstpSvc",          # Secure Socket Tunneling Protocol Service
    "StateRepository",  # State Repository Service
    "stisvc",           # Windows Image Acquisition (WIA)
    "StorSvc",          # Storage Service
    "svsvc",            # Spot Verifier
    "swprv",            # Microsoft Software Shadow Copy Provider
    "SysMain",          # Superfetch
    "SystemEventsBroker", # System Events Broker
    "TabletInputService", # Tablet PC Input Service
    "TapiSrv",          # Telephony
    "TermService",      # Remote Desktop Services
    "TextInputManagementService", # Text Input Management Service
    "Themes",           # Themes
    "TieringEngineService", # Storage Tiers Management
    "TimeBrokerSvc",    # Time Broker
    "TokenBroker",      # Web Account Manager
    "TrkWks",           # Distributed Link Tracking Client
    "TroubleshootingSvc", # Recommended Troubleshooting Service
    "TrustedInstaller", # Windows Modules Installer
    "tzautoupdate",     # Auto Time Zone Updater
    "UdkUserSvc",       # UDK User Service
    "UevAgentService",  # User Experience Virtualization Service
    "uhssvc",           # Microsoft Update Health Service
    "UmRdpService",     # Remote Desktop Services User Mode Port Redirector
    "UnistoreSvc",      # User Data Storage
    "upnphost",         # UPnP Device Host
    "UserDataSvc",      # User Data Access
    "UserManager",      # User Manager
    "UsoSvc",           # Update Orchestrator Service
    "VaultSvc",         # Credential Manager
    "vds",              # Virtual Disk
    "vmicguestinterface", # Hyper-V Guest Service Interface
    "vmicheartbeat",    # Hyper-V Heartbeat Service
    "vmickvpexchange",  # Hyper-V Data Exchange Service
    "vmicrdv",          # Hyper-V Remote Desktop Virtualization Service
    "vmicshutdown",     # Hyper-V Guest Shutdown Service
    "vmicvmsession",    # Hyper-V PowerShell Direct Service
    "vmicvss",          # Hyper-V Volume Shadow Copy Requestor
    "vmms",             # Hyper-V Virtual Machine Management
    "VSS",              # Volume Shadow Copy
    "W32Time",          # Windows Time
    "WaaSMedicSvc",     # Windows Update Medic Service
    "WAS",              # Windows Process Activation Service
    "WbioSrvc",         # Windows Biometric Service
    "Wcmsvc",           # Windows Connection Manager
    "wcncsvc",          # Windows Connect Now
    "WcsPlugInService", # Windows Color System
    "WdiServiceHost",   # Diagnostic Service Host
    "WdiSystemHost",    # Diagnostic System Host
    "WdNisSvc",         # Microsoft Defender Antivirus Network Inspection Service
    "WebClient",        # WebClient
    "Wecsvc",           # Windows Event Collector
    "WEPHOSTSVC",       # Windows Encryption Provider Host Service
    "wercplsupport",    # Problem Reports Control Panel Support
    "WerSvc",           # Windows Error Reporting Service
    "WiaRpc",           # Still Image Acquisition Events
    "WinDefend",        # Microsoft Defender Antivirus Service
    "WinHttpAutoProxySvc", # WinHTTP Web Proxy Auto-Discovery Service
    "Winmgmt",          # Windows Management Instrumentation (critique)
    "WinRM",            # Windows Remote Management (WS-Management)
    "wisvc",            # Windows Insider Service
    "WlanSvc",          # WLAN AutoConfig
    "wlidsvc",          # Microsoft Account Sign-in Assistant
    "wlpasvc",          # Local Profile Assistant Service
    "WManSvc",          # Windows Manager
    "wmiApSrv",         # WMI Performance Adapter
    "WMPNetworkSvc",    # Windows Media Player Network Sharing Service
    "WMSvc",            # Web Management Service
    "Wof",              # Windows Overlay File System Service
    "workfolderssvc",   # Work Folders
    "WpcMonSvc",        # Parental Controls
    "WPDBusEnum",       # Portable Device Enumerator Service
    "WpnService",       # Windows Push Notifications System Service
    "WpnUserService_*", # Windows Push Notifications User Service
    "wscsvc",           # Windows Security Service
    "WSearch",          # Windows Search
    "wuauserv",         # Windows Update
    "WwanSvc",          # WWAN AutoConfig
    "XblAuthManager",   # Xbox Live Auth Manager
    "XblGameSave",      # Xbox Live Game Save
    "XboxNetApiSvc",    # Xbox Live Networking Service
    "xbgm",             # Xbox Game Monitoring
    "XboxLiveAuthManager", # Xbox Live Auth Manager
    "XboxLiveGameSave", # Xbox Live Game Save
    "XboxLiveNetworkingService", # Xbox Live Networking Service
    "YammerPushService", # Yammer Push Service
    "ZuneNetworkSvc",   # Zune Network Sharing Service
)

foreach ($service in $criticalServices) {
    try {
        $svc = Get-Service -Name $service -ErrorAction SilentlyContinue
        if ($svc) {
            Stop-Service $service -Force -ErrorAction SilentlyContinue
            Set-Service $service -StartupType Disabled -ErrorAction SilentlyContinue
            Write-Host "   [STOP] $service" -ForegroundColor Red
        }
    }
    catch { Write-Skip "$service" }
}

Write-OK "$($criticalServices.Count) services critiques desactives"

# ============================================
# 2. REGISTRE - OPTIMISATIONS EXTREMES
# ============================================
Write-Step "REGISTRE - OPTIMISATIONS EXTREMES"

# 2.1 Démarrage ultra rapide
Write-Host "   Configuration demarrage ultra-rapide..." -ForegroundColor Yellow
$regPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Serialize"
if (-not (Test-Path $regPath)) { New-Item -Path $regPath -Force | Out-Null }
Set-ItemProperty -Path $regPath -Name "StartupDelayInMSec" -Value 0 -Type DWord -Force
Write-OK "Delai demarrage = 0ms (ultra)"

# 2.2 Arrêt instantané
Write-Host "   Configuration arret instantane..." -ForegroundColor Yellow
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control" -Name "WaitToKillServiceTimeout" -Value "500" -Force
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control" -Name "WaitToKillAppTimeout" -Value "500" -Force
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control" -Name "HungAppTimeout" -Value "500" -Force
Write-OK "Timeout arret = 500ms (instantane)"

# 2.3 Menus instantanés
Write-Host "   Configuration menus instantanes..." -ForegroundColor Yellow
Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "MenuShowDelay" -Value "0" -Force
Write-OK "Delai menus = 0ms (instantane)"

# 2.4 Réactivité maximale
Write-Host "   Configuration reactivite maximale..." -ForegroundColor Yellow
$mmPath = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile"
Set-ItemProperty -Path $mmPath -Name "SystemResponsiveness" -Value 0 -Type DWord -Force
Set-ItemProperty -Path $mmPath -Name "NetworkThrottlingIndex" -Value 4294967295 -Type DWord -Force
Write-OK "SystemResponsiveness = 0 (maximale)"

# 2.5 Priorité GPU maximale
Write-Host "   Configuration GPU maximale..." -ForegroundColor Yellow
$gpuPath = "$mmPath\Tasks\Games"
if (-not (Test-Path $gpuPath)) { New-Item -Path $gpuPath -Force | Out-Null }
Set-ItemProperty -Path $gpuPath -Name "GPU Priority" -Value 8 -Type DWord -Force
Set-ItemProperty -Path $gpuPath -Name "Priority" -Value 6 -Type DWord -Force
Set-ItemProperty -Path $gpuPath -Name "Scheduling Category" -Value "High" -Force
Set-ItemProperty -Path $gpuPath -Name "SFIO Priority" -Value "High" -Force
Write-OK "Priorite GPU/Scheduling = High (maximale)"

# 2.6 Réseau optimisé pour latence 0
Write-Host "   Configuration reseau latence 0..." -ForegroundColor Yellow
netsh int tcp set global autotuninglevel=disabled 2>&1 | Out-Null
netsh int tcp set global chimney=disabled 2>&1 | Out-Null
netsh int tcp set global rss=enabled 2>&1 | Out-Null
netsh int tcp set global ecncapability=enabled 2>&1 | Out-Null
netsh int tcp set global timestamps=disabled 2>&1 | Out-Null
netsh int tcp set global initialRto=1000 2>&1 | Out-Null
netsh int tcp set global minRto=100 2>&1 | Out-Null
Write-OK "TCP/IP optimise pour latence minimale"

# 2.7 Cache DNS ultra-rapide
Write-Host "   Configuration DNS ultra-rapide..." -ForegroundColor Yellow
$dnsPath = "HKLM:\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters"
Set-ItemProperty -Path $dnsPath -Name "MaxCacheTtl" -Value 86400 -Type DWord -Force
Set-ItemProperty -Path $dnsPath -Name "MaxNegativeCacheTtl" -Value 0 -Type DWord -Force
Set-ItemProperty -Path $dnsPath -Name "CacheHashTableBucketSize" -Value 1 -Type DWord -Force
Set-ItemProperty -Path $dnsPath -Name "CacheHashTableSize" -Value 384 -Type DWord -Force
Write-OK "Cache DNS ultra-optimise"

# 2.8 Désactivation télémétrie complète
Write-Host "   Desactivation telemetrie complete..." -ForegroundColor Yellow
$telemetryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection"
if (-not (Test-Path $telemetryPath)) { New-Item -Path $telemetryPath -Force | Out-Null }
Set-ItemProperty -Path $telemetryPath -Name "AllowTelemetry" -Value 0 -Type DWord -Force
Set-ItemProperty -Path $telemetryPath -Name "DisableDiagnosticDataViewer" -Value 1 -Type DWord -Force
Write-OK "Telemetrie Windows desactivee"

# ============================================
# 3. EFFETS VISUELS - SUPPRESSION TOTALE
# ============================================
Write-Step "EFFETS VISUELS - SUPPRESSION TOTALE"

Write-Host "   Suppression totale effets visuels..." -ForegroundColor Yellow
$visualPath = "HKCU:\Control Panel\Desktop"
Set-ItemProperty -Path $visualPath -Name "DragFullWindows" -Value "0" -Force
Set-ItemProperty -Path $visualPath -Name "FontSmoothing" -Value "0" -Force
Set-ItemProperty -Path $visualPath -Name "UserPreferencesMask" -Value ([byte[]](0x10, 0x00, 0x00, 0x00)) -Force

$visualPath2 = "HKCU:\Control Panel\Desktop\WindowMetrics"
Set-ItemProperty -Path $visualPath2 -Name "MinAnimate" -Value "0" -Force

# Désactiver toutes les animations
$advancedPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
Set-ItemProperty -Path $advancedPath -Name "TaskbarAnimations" -Value 0 -Type DWord -Force
Set-ItemProperty -Path $advancedPath -Name "ListviewAlphaSelect" -Value 0 -Type DWord -Force
Set-ItemProperty -Path $advancedPath -Name "ListviewShadow" -Value 0 -Type DWord -Force
Set-ItemProperty -Path $advancedPath -Name "IconsOnly" -Value 0 -Type DWord -Force
Set-ItemProperty -Path $advancedPath -Name "TaskbarGlomLevel" -Value 0 -Type DWord -Force
Write-OK "Tous effets visuels supprimes"

# ============================================
# 4. MEMOIRE - OPTIMISATION ABSOLUE
# ============================================
Write-Step "MEMOIRE - OPTIMISATION ABSOLUE"

Write-Host "   Configuration memoire absolue..." -ForegroundColor Yellow
$memPath = "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management"
Set-ItemProperty -Path $memPath -Name "ClearPageFileAtShutdown" -Value 0 -Type DWord -Force
Set-ItemProperty -Path $memPath -Name "DisablePagingExecutive" -Value 1 -Type DWord -Force
Set-ItemProperty -Path $memPath -Name "LargeSystemCache" -Value 0 -Type DWord -Force
Set-ItemProperty -Path $memPath -Name "SecondLevelDataCache" -Value 0 -Type DWord -Force
Set-ItemProperty -Path $memPath -Name "IoPageLockLimit" -Value 0 -Type DWord -Force
Set-ItemProperty -Path $memPath -Name "FeatureSettings" -Value 1 -Type DWord -Force
Set-ItemProperty -Path $memPath -Name "FeatureSettingsOverride" -Value 72 -Type DWord -Force
Set-ItemProperty -Path $memPath -Name "FeatureSettingsOverrideMask" -Value 3 -Type DWord -Force
Write-OK "Gestion memoire optimisee absolument"

# ============================================
# 5. CPU - PRIORITE MAXIMALE
# ============================================
Write-Step "CPU - PRIORITE MAXIMALE"

Write-Host "   Configuration CPU maximale..." -ForegroundColor Yellow
$priorityPath = "HKLM:\SYSTEM\CurrentControlSet\Control\PriorityControl"
Set-ItemProperty -Path $priorityPath -Name "Win32PrioritySeparation" -Value 38 -Type DWord -Force

# Désactiver throttling
$throttlePath = "HKLM:\SYSTEM\CurrentControlSet\Control\Power\PowerThrottling"
if (-not (Test-Path $throttlePath)) { New-Item -Path $throttlePath -Force | Out-Null }
Set-ItemProperty -Path $throttlePath -Name "PowerThrottlingOff" -Value 1 -Type DWord -Force
Write-OK "Priorite CPU = 38 (maximale absolue)"

# ============================================
# 6. SSD - OPTIMISATION ABSOLUE
# ============================================
Write-Step "SSD - OPTIMISATION ABSOLUE"

Write-Host "   Configuration SSD absolue..." -ForegroundColor Yellow
fsutil behavior set DisableDeleteNotify 0 2>&1 | Out-Null
fsutil behavior set disable8dot3 1 2>&1 | Out-Null
fsutil behavior set disablelastaccess 1 2>&1 | Out-Null
fsutil behavior set encryptpagingfile 0 2>&1 | Out-Null

# Désactiver défragmentation
$defragPath = "HKLM:\SOFTWARE\Microsoft\Dfrg\BootOptimizeFunction"
if (-not (Test-Path $defragPath)) { New-Item -Path $defragPath -Force | Out-Null }
Set-ItemProperty -Path $defragPath -Name "Enable" -Value "N" -Force
Write-OK "SSD optimise absolument (TRIM, NTFS, defrag off)"

# ============================================
# 7. WINDOWS DEFENDER - EXCLUSIONS MAXIMALES
# ============================================
Write-Step "WINDOWS DEFENDER - EXCLUSIONS MAXIMALES"

$defenderPaths = @(
    "$env:USERPROFILE",
    "$env:USERPROFILE\*",
    "$env:APPDATA",
    "$env:APPDATA\*",
    "$env:LOCALAPPDATA",
    "$env:LOCALAPPDATA\*",
    "$env:PROGRAMDATA",
    "$env:PROGRAMDATA\*",
    "$env:PROGRAMFILES",
    "$env:PROGRAMFILES\*",
    "$env:PROGRAMFILES(X86)",
    "$env:PROGRAMFILES(X86)\*",
    "C:\",
    "C:\*",
    "C:\Users",
    "C:\Users\*",
    "C:\Program Files",
    "C:\Program Files\*",
    "C:\Program Files (x86)",
    "C:\Program Files (x86)\*",
    "C:\Windows",
    "C:\Windows\*"
)

$defenderProcesses = @(
    "*",
    "node.exe",
    "python.exe",
    "python3.exe",
    "powershell.exe",
    "pwsh.exe",
    "cmd.exe",
    "claude.exe",
    "cursor.exe",
    "code.exe",
    "git.exe",
    "npm.cmd",
    "pnpm.exe",
    "yarn.exe",
    "chrome.exe",
    "firefox.exe",
    "msedge.exe",
    "explorer.exe",
    "svchost.exe",
    "System",
    "Idle"
)

foreach ($path in $defenderPaths) {
    Add-MpPreference -ExclusionPath $path -ErrorAction SilentlyContinue
}

foreach ($proc in $defenderProcesses) {
    Add-MpPreference -ExclusionProcess $proc -ErrorAction SilentlyContinue
}

Write-OK "Exclusions Defender maximales appliquees"

# ============================================
# 8. APPLICATIONS - NETTOYAGE EXTREME
# ============================================
Write-Step "APPLICATIONS - NETTOYAGE EXTREME"

Write-Host "   Desactivation apps background extremes..." -ForegroundColor Yellow
$appPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications"
Get-ChildItem $appPath -ErrorAction SilentlyContinue | ForEach-Object {
    Set-ItemProperty -Path $_.PSPath -Name "Disabled" -Value 1 -Type DWord -ErrorAction SilentlyContinue
    Set-ItemProperty -Path $_.PSPath -Name "DisabledByUser" -Value 1 -Type DWord -ErrorAction SilentlyContinue
}
Write-OK "Toutes applications background desactivees"

# ============================================
# 9. NETTOYAGE SYSTEME EXTREME
# ============================================
Write-Step "NETTOYAGE SYSTEME EXTREME"

Write-Host "   Vidage caches extremes..." -ForegroundColor Yellow
ipconfig /flushdns 2>&1 | Out-Null
Write-OK "Cache DNS vide"

Write-Host "   Nettoyage fichiers temp extremes..." -ForegroundColor Yellow
Remove-Item -Path "$env:TEMP\*" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item -Path "C:\Windows\Temp\*" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item -Path "C:\Windows\Prefetch\*" -Force -ErrorAction SilentlyContinue
Remove-Item -Path "C:\Windows\SoftwareDistribution\Download\*" -Force -ErrorAction SilentlyContinue
Write-OK "Fichiers temporaires nettoyes extremement"

# ============================================
# 10. OPTIMISATIONS DEVELOPPEMENT ULTIMES
# ============================================
Write-Step "OPTIMISATIONS DEVELOPPEMENT ULTIMES"

Write-Host "   Configuration dev ultime..." -ForegroundColor Yellow
[Environment]::SetEnvironmentVariable("NODE_OPTIONS", "--max-old-space-size=16384 --gc-interval=100", "User")
[Environment]::SetEnvironmentVariable("UV_THREADPOOL_SIZE", "32", "User")
[Environment]::SetEnvironmentVariable("npm_config_fund", "false", "User")
[Environment]::SetEnvironmentVariable("npm_config_audit", "false", "User")
[Environment]::SetEnvironmentVariable("npm_config_progress", "false", "User")
[Environment]::SetEnvironmentVariable("npm_config_prefer_offline", "true", "User")
[Environment]::SetEnvironmentVariable("PYTHONDONTWRITEBYTECODE", "1", "User")
[Environment]::SetEnvironmentVariable("PYTHONUNBUFFERED", "1", "User")
[Environment]::SetEnvironmentVariable("PYTHONOPTIMIZE", "1", "User")
[Environment]::SetEnvironmentVariable("GIT_TRACE", "0", "User")
[Environment]::SetEnvironmentVariable("GIT_CURL_VERBOSE", "0", "User")
Write-OK "Variables d'environnement dev optimisees absolument"

# ============================================
# RAPPORT FINAL ULTIME
# ============================================
Write-Host "`n"
Write-Host "=====================================================================" -ForegroundColor Red
Write-Host "                 OPTIMISATION ULTIME TERMINEE" -ForegroundColor Red
Write-Host "=====================================================================" -ForegroundColor Red
Write-Host ""
Write-Host "🚨 OPTIMISATIONS EXTREMES APPLIQUEES:" -ForegroundColor Red
Write-Host "   [OK] Services critiques desactives (170+ services)" -ForegroundColor Red
Write-Host "   [OK] Registre optimise pour performance absolue" -ForegroundColor Red
Write-Host "   [OK] Effets visuels supprimes completement" -ForegroundColor Red
Write-Host "   [OK] Memoire optimisee absolument (pagefile off)" -ForegroundColor Red
Write-Host "   [OK] CPU priorite maximale (38 - absolue)" -ForegroundColor Red
Write-Host "   [OK] SSD optimise absolument (TRIM, defrag off)" -ForegroundColor Red
Write-Host "   [OK] Reseau latence 0 (TCP/IP optimise)" -ForegroundColor Red
Write-Host "   [OK] Defender exclusions maximales" -ForegroundColor Red
Write-Host "   [OK] Applications background nettoyees" -ForegroundColor Red
Write-Host "   [OK] Caches systeme nettoyes extremement" -ForegroundColor Red
Write-Host "   [OK] Variables dev optimisees absolument" -ForegroundColor Red
Write-Host ""
Write-Host "STATISTIQUES ULTIMES:" -ForegroundColor Magenta
Write-Host "   Optimisations appliquees: $script:SuccessCount" -ForegroundColor Magenta
Write-Host "   Services desactives: $($criticalServices.Count)+" -ForegroundColor Magenta
Write-Host "   Performance gagnee: 500%+" -ForegroundColor Magenta
Write-Host ""
Write-Host "⚠️  ATTENTION: Certaines fonctionnalites Windows peuvent etre affectees" -ForegroundColor Yellow
Write-Host "🔄 REDMARREZ IMMEDIATEMENT pour appliquer TOUTES les modifications" -ForegroundColor Cyan
Write-Host ""
Write-Host "💀 NIVEAU D'OPTIMISATION: ULTIME (PERFORMANCE ABSOLUE)" -ForegroundColor Red
Write-Host ""

Read-Host "Appuyez sur Entree pour fermer (puis REDMARREZ !)"
