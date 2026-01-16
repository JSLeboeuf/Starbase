# Rapport Optimisation Agentic Coding
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "   RAPPORT OPTIMISATION AGENTIC CODING" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Variables d'environnement
Write-Host "[VARIABLES ENVIRONNEMENT]" -ForegroundColor Yellow
$nodeOpts = [Environment]::GetEnvironmentVariable("NODE_OPTIONS", "User")
$uvPool = [Environment]::GetEnvironmentVariable("UV_THREADPOOL_SIZE", "User")
$npmFund = [Environment]::GetEnvironmentVariable("npm_config_fund", "User")
Write-Host "  NODE_OPTIONS:       $nodeOpts" -ForegroundColor Green
Write-Host "  UV_THREADPOOL_SIZE: $uvPool" -ForegroundColor Green
Write-Host "  npm_config_fund:    $npmFund" -ForegroundColor Green
Write-Host ""

# Plan alimentation
Write-Host "[PLAN ALIMENTATION]" -ForegroundColor Yellow
powercfg /getactivescheme
Write-Host ""

# Exclusions Defender
Write-Host "[EXCLUSIONS DEFENDER]" -ForegroundColor Yellow
try {
    $prefs = Get-MpPreference
    Write-Host "  Dossiers exclus:" -ForegroundColor White
    $prefs.ExclusionPath | Where-Object { $_ } | ForEach-Object { Write-Host "    - $_" -ForegroundColor Gray }
    Write-Host "  Processus exclus:" -ForegroundColor White
    $prefs.ExclusionProcess | Where-Object { $_ } | ForEach-Object { Write-Host "    - $_" -ForegroundColor Gray }
} catch {
    Write-Host "  (Lecture impossible)" -ForegroundColor Gray
}
Write-Host ""

# Hardware
Write-Host "[HARDWARE]" -ForegroundColor Yellow
$cpu = Get-CimInstance Win32_Processor | Select-Object -First 1
$ram = [math]::Round((Get-CimInstance Win32_ComputerSystem).TotalPhysicalMemory / 1GB, 1)
Write-Host "  CPU: $($cpu.Name)" -ForegroundColor White
Write-Host "  Cores: $($cpu.NumberOfCores) cores ($($cpu.NumberOfLogicalProcessors) threads)" -ForegroundColor White
Write-Host "  RAM: $ram GB" -ForegroundColor White
Write-Host ""

Write-Host "========================================" -ForegroundColor Green
Write-Host "   OPTIMISATION COMPLETE!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
