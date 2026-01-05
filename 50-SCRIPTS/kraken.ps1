# ============================================================
# 🐙 KRAKEN v14.0 - Claude Code Maximum Autonomy Launcher
# ============================================================
# Windows 11 Edition | Optimized for: Performance | Autonomy | Persistence
# Usage: .\kraken.ps1 [-Fast] [-Deep] [-Plan]

param(
    [switch]$Fast,
    [switch]$Deep,
    [switch]$Plan,
    [Parameter(ValueFromRemainingArguments = $true)]
    [string[]]$ExtraArgs
)

# Colors
$Purple = "`e[35m"
$Cyan = "`e[36m"
$Green = "`e[32m"
$Yellow = "`e[33m"
$Blue = "`e[34m"
$NC = "`e[0m"

# ASCII Art
Write-Host @"
$Purple
    ▄█▀▀▀█▄█                          ▀████▀▄█▀▀▀█▄█   
   ▄██    ▀█                            ██ ▄██    ▀█   
   ▀███▄     ▄██▀██▄▀████████▄ ▄█▀▀▀█▄  ██ ▀███▄       
     ▀█████▄██▀   ▀██ ██   ▀██▄██    ▀  ██   ▀█████▄   
   ▄     ▀████     ██ ██    ███▀█████▄  ██ ▄     ▀██   
   ██     ███▀▄   ▄██ ██   ▄███▄    ██  ██ ██     ██   
   █▀█████▀  ▀█████▀▄████████ ▀█████▀▄████▄█▀█████▀    
$NC
"@

Write-Host "${Cyan}🐙 KRAKEN v14.0 - Maximum Autonomy Mode (Windows)${NC}"
Write-Host "${Yellow}   54 MCPs | 32k Thinking | 50 Parallel | Hive Mind${NC}"
Write-Host ""

# ============================================
# PERFORMANCE OPTIMIZATIONS
# ============================================
Write-Host "${Cyan}⚡ Setting performance variables...${NC}"

$env:NODE_OPTIONS = "--max-old-space-size=16384"
$env:UV_THREADPOOL_SIZE = "16"
$env:CLAUDE_CODE_MAX_THINKING_TOKENS = "32768"
$env:CLAUDE_CODE_MAX_OUTPUT_TOKENS = "16384"
$env:CLAUDE_CODE_USE_STREAMING = "1"
$env:CLAUDE_CODE_PARALLEL_TOOLS = "1"
$env:CLAUDE_CODE_ENABLE_TELEMETRY = "0"
$env:npm_config_fund = "false"
$env:npm_config_audit = "false"
$env:PYTHONDONTWRITEBYTECODE = "1"
$env:PYTHONUNBUFFERED = "1"

Write-Host "${Green}✅ Environment configured${NC}"

# ============================================
# LAUNCH MODE
# ============================================
$ClaudeArgs = @("--dangerously-skip-permissions")

if ($Fast) {
    Write-Host "${Green}⚡ Fast mode enabled${NC}"
}
elseif ($Deep) {
    Write-Host "${Purple}🧠 Deep thinking mode enabled (32k tokens)${NC}"
}
elseif ($Plan) {
    Write-Host "${Blue}📋 Plan mode enabled${NC}"
    $ClaudeArgs = @("--permission-mode", "plan")
}
else {
    Write-Host "${Cyan}   [MODE] Default - Maximum autonomy${NC}"
}

# Add extra arguments
if ($ExtraArgs) {
    $ClaudeArgs += $ExtraArgs
}

# ============================================
# LAUNCH CLAUDE CODE
# ============================================
Write-Host ""
Write-Host "${Cyan}🚀 Launching Claude Code...${NC}"
Write-Host "${Yellow}   Args: $($ClaudeArgs -join ' ')${NC}"
Write-Host ""

# Check if claude is available
$claudePath = Get-Command claude -ErrorAction SilentlyContinue

if ($claudePath) {
    Write-Host "${Green}✅ Claude Code ready${NC}"
    Write-Host "${Cyan}Use: claude `"your prompt here`"${NC}"
    Write-Host ""
    # Don't auto-launch, just confirm it's ready
}
else {
    Write-Host "${Yellow}⚠️ Claude Code not found in PATH${NC}"
    Write-Host "${Cyan}Opening Cursor instead...${NC}"
    
    # Try to open Cursor
    $cursorPath = "$env:LOCALAPPDATA\Programs\cursor\Cursor.exe"
    if (Test-Path $cursorPath) {
        Start-Process $cursorPath
    }
    else {
        Write-Host "${Yellow}Please install Claude Code or Cursor${NC}"
    }
}

Write-Host "${Purple}KRAKEN READY${NC}"

