# Diagnostic simple pour erreur schema MCP Tool 51
Write-Host "DIAGNOSTIC ERREUR SCHEMA MCP TOOL 51" -ForegroundColor Cyan
Write-Host ""

# Verifier serveur Gmail
$gmailServer = "C:\Users\Utilisateur\.google_workspace_mcp\gmail-mcp-server.js"
if (Test-Path $gmailServer) {
    Write-Host "[OK] Serveur Gmail trouve" -ForegroundColor Green
} else {
    Write-Host "[WARN] Serveur Gmail non trouve" -ForegroundColor Yellow
}

# Verifier config Claude
$claudeConfig = "$env:APPDATA\Claude\claude_desktop_config.json"
if (Test-Path $claudeConfig) {
    Write-Host "[OK] Configuration Claude trouvee" -ForegroundColor Green
    
    $config = Get-Content $claudeConfig | ConvertFrom-Json
    $count = 0
    foreach ($name in $config.mcpServers.PSObject.Properties.Name) {
        if ($name -notmatch '_disabled$') {
            $count++
            Write-Host "  $count. $name" -ForegroundColor Gray
        }
    }
    Write-Host "Total serveurs actifs: $count" -ForegroundColor White
} else {
    Write-Host "[WARN] Configuration non trouvee" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "RECOMMANDATIONS:" -ForegroundColor Cyan
Write-Host "1. Desactiver temporairement n8n-npx dans claude_desktop_config.json" -ForegroundColor White
Write-Host "2. Redemarrer Claude Code" -ForegroundColor White
Write-Host "3. Si erreur persiste, desactiver autres serveurs un par un" -ForegroundColor White




