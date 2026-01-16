# KRAKEN SIMPLE - Claude Code Launcher

param([switch]$Fast, [switch]$Deep, [switch]$Plan)

Write-Host 'KRAKEN v15.0 - Maximum Autonomy Mode (Windows 11)' -ForegroundColor Cyan
Write-Host '32k Thinking | Parallel Tools | Hive Mind Ready' -ForegroundColor Yellow
Write-Host ''

# Variables d'environnement
$env:NODE_OPTIONS = '--max-old-space-size=16384'
$env:UV_THREADPOOL_SIZE = '16'
$env:CLAUDE_CODE_MAX_THINKING_TOKENS = '32768'
$env:CLAUDE_CODE_MAX_OUTPUT_TOKENS = '16384'
$env:CLAUDE_CODE_USE_STREAMING = '1'
$env:CLAUDE_CODE_PARALLEL_TOOLS = '1'
$env:CLAUDE_CODE_ENABLE_TELEMETRY = '0'

# Arguments Claude
$args = @('--dangerously-skip-permissions')

if ($Fast) {
    Write-Host '[MODE] Fast - Quick responses' -ForegroundColor Green
    $args += @('--model', 'sonnet-4')
}
elseif ($Deep) {
    Write-Host '[MODE] Deep - Extended thinking (32k tokens)' -ForegroundColor Magenta
    $args += @('--model', 'opus-4')
}
elseif ($Plan) {
    Write-Host '[MODE] Plan - Planning mode' -ForegroundColor Blue
    $args += @('--permission-mode', 'plan')
}
else {
    Write-Host '[MODE] Default - Maximum autonomy' -ForegroundColor Cyan
}

Write-Host 'Launching Claude Code with maximum autonomy...' -ForegroundColor Yellow
Write-Host "Args: claude $($args -join ' ')" -ForegroundColor White
Write-Host ''
Write-Host '============================================' -ForegroundColor Magenta
Write-Host '   KRAKEN ACTIVATED - RELEASING THE BEAST' -ForegroundColor Magenta
Write-Host '============================================' -ForegroundColor Magenta
Write-Host ''

# Lancer Claude Code
& claude @args
