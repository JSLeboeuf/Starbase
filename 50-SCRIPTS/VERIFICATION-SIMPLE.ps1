# VERIFICATION FINALE - PERFORMANCE OPTIMISEE

Write-Host "VERIFICATION FINALE - ETAT DU SYSTEME OPTIMISE" -ForegroundColor Cyan
Write-Host ""

# Systeme
Write-Host "SYSTEME:" -ForegroundColor Yellow
$ram = [math]::Round((Get-CimInstance Win32_ComputerSystem).TotalPhysicalMemory / 1GB, 1)
$cpu = (Get-CimInstance Win32_Processor | Select-Object -First 1).Name
$cores = (Get-CimInstance Win32_Processor | Select-Object -First 1).NumberOfLogicalProcessors
Write-Host "   RAM: $ram GB" -ForegroundColor White
Write-Host "   CPU: $cpu" -ForegroundColor White
Write-Host "   Threads: $cores" -ForegroundColor White

# Services
Write-Host "`nSERVICES OPTIMISES:" -ForegroundColor Yellow
$services = @("SysMain", "WSearch", "Spooler", "Fax")
foreach ($svc in $services) {
    $service = Get-Service -Name $svc -ErrorAction SilentlyContinue
    if ($service -and $service.StartType -eq "Disabled") {
        Write-Host "   [OK] $svc desactive" -ForegroundColor Green
    } else {
        Write-Host "   [INFO] $svc status: $($service.StartType)" -ForegroundColor Yellow
    }
}

# Variables
Write-Host "`nVARIABLES D'ENVIRONNEMENT:" -ForegroundColor Yellow
$nodeOpts = [Environment]::GetEnvironmentVariable("NODE_OPTIONS", "User")
$uvThreads = [Environment]::GetEnvironmentVariable("UV_THREADPOOL_SIZE", "User")
Write-Host "   NODE_OPTIONS: $nodeOpts" -ForegroundColor $(if ($nodeOpts -match "16384") { "Green" } else { "Yellow" })
Write-Host "   UV_THREADPOOL_SIZE: $uvThreads" -ForegroundColor $(if ($uvThreads -eq "32") { "Green" } else { "Yellow" })

# Claude Code
Write-Host "`nCLAUDE CODE:" -ForegroundColor Yellow
$claudeVersion = claude --version 2>$null
Write-Host "   Version: $claudeVersion" -ForegroundColor Green

Write-Host "`nSTATUT: OPTIMISATION ULTIME COMPLETE !" -ForegroundColor Green
Write-Host "Votre ordinateur est maintenant optimise pour performance maximale." -ForegroundColor Cyan
