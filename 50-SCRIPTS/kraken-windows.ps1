# ============================================================
# KRAKEN v15.0 - Claude Code Maximum Autonomy Launcher
# ============================================================
# Windows 11 Edition | Optimized for: Performance | Autonomy | Persistence
# Usage: .\kraken.ps1 [-Fast] [-Deep] [-Plan] [-Continue] [-Model <model>]
# ============================================================

param(
    [switch]$Fast,
    [switch]$Deep,
    [switch]$Plan,
    [switch]$Continue,
    [string]$Model = "opus-4",
    [Parameter(ValueFromRemainingArguments = $true)]
    [string[]]$ExtraArgs
)

# ============================================
# COLORS & STYLING
# ============================================
$Purple = "`e[35m"
$Cyan = "`e[36m"
$Green = "`e[32m"
$Yellow = "`e[33m"
$Blue = "`e[34m"
$Red = "`e[31m"
$Bold = "`e[1m"
$NC = "`e[0m"

# ============================================
# ASCII ART
# ============================================
Write-Host @"
$Purple$Bold
    ██╗  ██╗██████╗  █████╗ ██╗  ██╗███████╗███╗   ██╗
    ██║ ██╔╝██╔══██╗██╔══██╗██║ ██╔╝██╔════╝████╗  ██║
    █████╔╝ ██████╔╝███████║█████╔╝ █████╗  ██╔██╗ ██║
    ██╔═██╗ ██╔══██╗██╔══██║██╔═██╗ ██╔══╝  ██║╚██╗██║
    ██║  ██╗██║  ██║██║  ██║██║  ██╗███████╗██║ ╚████║
    ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═══╝
$NC
"@

Write-Host "${Cyan}${Bold}KRAKEN v15.0 - Maximum Autonomy Mode (Windows 11)${NC}"
Write-Host "${Yellow}   32k Thinking | Parallel Tools | Hive Mind Ready${NC}"
Write-Host ""

# ============================================
# SYSTEM CHECK
# ============================================
Write-Host "${Cyan}[1/5] System Check...${NC}"

# Check Claude Code
$claudeVersion = claude --version 2>$null
if ($LASTEXITCODE -ne 0) {
    Write-Host "${Red}[ERROR] Claude Code not installed!${NC}"
    Write-Host "${Yellow}Install with: npm install -g @anthropic-ai/claude-code${NC}"
    exit 1
}
Write-Host "${Green}   [OK] Claude Code: $claudeVersion${NC}"

# Check Node.js
$nodeVersion = node --version 2>$null
Write-Host "${Green}   [OK] Node.js: $nodeVersion${NC}"

# Check Git
$gitVersion = git --version 2>$null
Write-Host "${Green}   [OK] Git: $gitVersion${NC}"

# ============================================
# PERFORMANCE OPTIMIZATIONS
# ============================================
Write-Host ""
Write-Host "${Cyan}[2/5] Performance Optimizations...${NC}"

# Node.js
$env:NODE_OPTIONS = "--max-old-space-size=16384"
Write-Host "${Green}   [OK] NODE_OPTIONS: 16GB heap${NC}"

# UV Threadpool
$env:UV_THREADPOOL_SIZE = "16"
Write-Host "${Green}   [OK] UV_THREADPOOL_SIZE: 16${NC}"

# Claude Code specific
$env:CLAUDE_CODE_MAX_THINKING_TOKENS = "32768"
$env:CLAUDE_CODE_MAX_OUTPUT_TOKENS = "16384"
$env:CLAUDE_CODE_USE_STREAMING = "1"
$env:CLAUDE_CODE_PARALLEL_TOOLS = "1"
$env:CLAUDE_CODE_ENABLE_TELEMETRY = "0"
Write-Host "${Green}   [OK] Claude Code: 32k thinking, streaming enabled${NC}"

# npm/pnpm
$env:npm_config_fund = "false"
$env:npm_config_audit = "false"
Write-Host "${Green}   [OK] npm: fund/audit disabled${NC}"

# Python
$env:PYTHONDONTWRITEBYTECODE = "1"
$env:PYTHONUNBUFFERED = "1"
Write-Host "${Green}   [OK] Python: optimized${NC}"

# ============================================
# MCP SERVERS CHECK
# ============================================
Write-Host ""
Write-Host "${Cyan}[3/5] MCP Servers Check...${NC}"

$mcpOutput = claude mcp list 2>&1
$mcpLines = $mcpOutput -split "`n" | Where-Object { $_ -match "Connected|Failed" }
foreach ($line in $mcpLines) {
    if ($line -match "Connected") {
        Write-Host "${Green}   $line${NC}"
    }
    else {
        Write-Host "${Yellow}   $line${NC}"
    }
}

# ============================================
# BUILD LAUNCH ARGUMENTS
# ============================================
Write-Host ""
Write-Host "${Cyan}[4/5] Configuring Launch Mode...${NC}"

$ClaudeArgs = @()

# Mode selection
if ($Fast) {
    Write-Host "${Green}   [MODE] Fast - Quick responses${NC}"
    $ClaudeArgs += @("--model", "sonnet-4")
    $Model = "sonnet-4"
}
elseif ($Deep) {
    Write-Host "${Purple}   [MODE] Deep - Extended thinking (32k tokens)${NC}"
    $ClaudeArgs += @("--model", "opus-4")
    $Model = "opus-4"
}
elseif ($Plan) {
    Write-Host "${Blue}   [MODE] Plan - Planning mode${NC}"
    $ClaudeArgs += @("--permission-mode", "plan")
}
else {
    Write-Host "${Cyan}   [MODE] Default - Maximum autonomy${NC}"
}

# Continue session
if ($Continue) {
    Write-Host "${Yellow}   [SESSION] Continuing last session${NC}"
    $ClaudeArgs += @("--continue")
}

# Model
if ($Model -and -not $Fast -and -not $Deep) {
    $ClaudeArgs += @("--model", $Model)
}
Write-Host "${Green}   [MODEL] $Model${NC}"

# Bypass permissions for maximum autonomy
$ClaudeArgs += @("--dangerously-skip-permissions")
Write-Host "${Yellow}   [PERMISSIONS] Bypassed for autonomy${NC}"

# Add extra arguments
if ($ExtraArgs) {
    $ClaudeArgs += $ExtraArgs
    Write-Host "${Cyan}   [EXTRA] $($ExtraArgs -join ' ')${NC}"
}

# ============================================
# LAUNCH
# ============================================
Write-Host ""
Write-Host "${Cyan}[5/5] Launching Claude Code...${NC}"
Write-Host ""
Write-Host "${Purple}${Bold}============================================${NC}"
Write-Host "${Purple}${Bold}   KRAKEN ACTIVATED - RELEASING THE BEAST${NC}"
Write-Host "${Purple}${Bold}============================================${NC}"
Write-Host ""
Write-Host "${Yellow}Args: claude $($ClaudeArgs -join ' ')${NC}"
Write-Host ""

# Launch Claude Code
& claude @ClaudeArgs


