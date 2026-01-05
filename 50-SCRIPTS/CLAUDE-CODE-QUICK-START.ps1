# ============================================================================
# CLAUDE CODE - QUICK START
# ============================================================================
# Script de lancement rapide pour Claude Code avec configuration optimale
# ============================================================================

param(
    [string]$Mode = "interactive",
    [string]$Model = "opus-4",
    [string]$Project = ""
)

Write-Host ""
Write-Host "=====================================================================" -ForegroundColor Cyan
Write-Host "  CLAUDE CODE - QUICK START" -ForegroundColor Cyan
Write-Host "=====================================================================" -ForegroundColor Cyan
Write-Host ""

# Verifier que Claude Code est installe
$claudeVersion = claude --version 2>&1
if ($LASTEXITCODE -ne 0) {
    Write-Host "[ERREUR] Claude Code n'est pas installe!" -ForegroundColor Red
    Write-Host "Installez-le avec: npm install -g @anthropic-ai/claude-code" -ForegroundColor Yellow
    exit 1
}

Write-Host "[OK] Claude Code version: $claudeVersion" -ForegroundColor Green

# Afficher les serveurs MCP
Write-Host ""
Write-Host "Serveurs MCP:" -ForegroundColor Yellow
claude mcp list 2>&1 | ForEach-Object { Write-Host "   $_" -ForegroundColor White }

Write-Host ""
Write-Host "Configuration:" -ForegroundColor Yellow
Write-Host "   Mode: $Mode" -ForegroundColor White
Write-Host "   Model: $Model" -ForegroundColor White
Write-Host "   Project: $(if ($Project) { $Project } else { 'Current directory' })" -ForegroundColor White

Write-Host ""
Write-Host "=====================================================================" -ForegroundColor Green

# Lancer Claude Code selon le mode
switch ($Mode) {
    "interactive" {
        Write-Host "Lancement en mode interactif..." -ForegroundColor Cyan
        if ($Project) {
            Set-Location $Project
        }
        claude --model $Model
    }
    "continue" {
        Write-Host "Reprise de la derniere session..." -ForegroundColor Cyan
        claude --continue --model $Model
    }
    "print" {
        Write-Host "Mode print (non-interactif)..." -ForegroundColor Cyan
        claude --print --model $Model
    }
    default {
        Write-Host "Mode interactif par defaut..." -ForegroundColor Cyan
        claude --model $Model
    }
}


