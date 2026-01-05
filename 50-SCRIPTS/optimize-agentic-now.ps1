# Optimisations Agentic Coding - Sans Admin
$ErrorActionPreference = "Continue"

Write-Host "=== OPTIMISATIONS AGENTIC CODING ===" -ForegroundColor Cyan
Write-Host ""

# 1. Variables d'environnement Node.js
Write-Host "[1/6] Configuration Node.js..." -ForegroundColor Yellow
[Environment]::SetEnvironmentVariable("NODE_OPTIONS", "--max-old-space-size=16384", "User")
Write-Host "   NODE_OPTIONS = --max-old-space-size=16384 (16GB)" -ForegroundColor Green

# 2. npm optimizations
Write-Host "[2/6] Optimisation npm..." -ForegroundColor Yellow
[Environment]::SetEnvironmentVariable("npm_config_fund", "false", "User")
[Environment]::SetEnvironmentVariable("npm_config_audit", "false", "User")
Write-Host "   npm fund/audit desactives" -ForegroundColor Green

# 3. UV_THREADPOOL_SIZE pour meilleure perf I/O
Write-Host "[3/6] Configuration UV threadpool..." -ForegroundColor Yellow
[Environment]::SetEnvironmentVariable("UV_THREADPOOL_SIZE", "16", "User")
Write-Host "   UV_THREADPOOL_SIZE = 16" -ForegroundColor Green

# 4. Check current power plan
Write-Host "[4/6] Plan alimentation actuel..." -ForegroundColor Yellow
$currentPlan = powercfg /getactivescheme
Write-Host "   $currentPlan" -ForegroundColor White

# 5. System info
Write-Host "[5/6] Info systeme..." -ForegroundColor Yellow
$ram = [math]::Round((Get-CimInstance Win32_ComputerSystem).TotalPhysicalMemory / 1GB, 1)
$cpu = (Get-CimInstance Win32_Processor | Select-Object -First 1).Name
$cores = (Get-CimInstance Win32_Processor | Select-Object -First 1).NumberOfLogicalProcessors
Write-Host "   RAM: $ram GB" -ForegroundColor White
Write-Host "   CPU: $cpu" -ForegroundColor White
Write-Host "   Threads: $cores" -ForegroundColor White

# 6. Afficher recommandations admin
Write-Host "[6/6] Recommandations (admin requis)..." -ForegroundColor Yellow
Write-Host ""
Write-Host "Pour optimisation complete, executez EN ADMIN:" -ForegroundColor Cyan
Write-Host "   & 'C:\Users\Utilisateur\DEFENDER-MAX-AGENTIC-OPTIMIZE.ps1'" -ForegroundColor White
Write-Host ""
Write-Host "Ou ces commandes individuelles:" -ForegroundColor Cyan
Write-Host "   # Exclusions Defender (critique pour perf)" -ForegroundColor Gray
Write-Host "   Add-MpPreference -ExclusionPath 'C:\Users\Utilisateur\jerome'" -ForegroundColor White
Write-Host "   Add-MpPreference -ExclusionPath 'C:\Users\Utilisateur\node_modules'" -ForegroundColor White
Write-Host "   Add-MpPreference -ExclusionProcess 'node.exe'" -ForegroundColor White
Write-Host "   Add-MpPreference -ExclusionProcess 'python.exe'" -ForegroundColor White
Write-Host ""
Write-Host "   # Plan Ultimate Performance" -ForegroundColor Gray
Write-Host "   powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61" -ForegroundColor White
Write-Host ""

Write-Host "=== OPTIMISATIONS USER APPLIQUEES ===" -ForegroundColor Green
Write-Host "Redemarrez votre terminal pour appliquer les variables." -ForegroundColor Yellow
