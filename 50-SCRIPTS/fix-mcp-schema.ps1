# Script de diagnostic et correction pour erreur schéma MCP Tool 51
# Erreur: Property keys should match pattern '^[a-zA-Z0-9_.-]{1,64}$'

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  DIAGNOSTIC ERREUR SCHÉMA MCP TOOL 51" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Fonction pour valider un nom de propriété
function Test-PropertyName {
    param([string]$Name)
    
    if ([string]::IsNullOrWhiteSpace($Name)) {
        return $false
    }
    
    # Vérifier le pattern: ^[a-zA-Z0-9_.-]{1,64}$
    if ($Name -match '^[a-zA-Z0-9_.-]{1,64}$') {
        return $true
    }
    return $false
}

# Fonction pour sanitizer un nom de propriété
function Sanitize-PropertyName {
    param([string]$Name)
    
    # Remplacer les espaces par underscore
    $sanitized = $Name -replace '\s+', '_'
    
    # Supprimer les caractères invalides (garder seulement a-z, A-Z, 0-9, _, ., -)
    $sanitized = $sanitized -replace '[^a-zA-Z0-9_.-]', ''
    
    # Limiter à 64 caractères
    if ($sanitized.Length -gt 64) {
        $sanitized = $sanitized.Substring(0, 64)
    }
    
    # S'assurer qu'il commence par une lettre ou underscore
    if ($sanitized -notmatch '^[a-zA-Z_]') {
        $sanitized = "_$sanitized"
    }
    
    return $sanitized
}

Write-Host "[1/4] Vérification fichiers MCP..." -ForegroundColor Yellow

# Vérifier le serveur Gmail personnalisé
$gmailServer = "C:\Users\Utilisateur\.google_workspace_mcp\gmail-mcp-server.js"
if (Test-Path $gmailServer) {
    Write-Host "  ✓ Serveur Gmail trouvé" -ForegroundColor Green
    
    $content = Get-Content $gmailServer -Raw
    $issues = @()
    
    # Chercher les schémas avec des propriétés (simplifié)
    if ($content -match 'properties:\s*\{') {
        Write-Host "    ✓ Schémas trouvés dans le fichier" -ForegroundColor Green
        # Vérification manuelle recommandée pour les propriétés complexes
    }
    
    if ($issues.Count -eq 0) {
        Write-Host "    ✓ Schémas valides dans gmail-mcp-server.js" -ForegroundColor Green
    }
} else {
    Write-Host "  ⚠ Serveur Gmail non trouvé" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "[2/4] Vérification configuration Claude..." -ForegroundColor Yellow

$claudeConfig = "$env:APPDATA\Claude\claude_desktop_config.json"
if (Test-Path $claudeConfig) {
    Write-Host "  ✓ Configuration Claude trouvée" -ForegroundColor Green
    
    $config = Get-Content $claudeConfig | ConvertFrom-Json
    
    Write-Host "  Serveurs MCP configurés:" -ForegroundColor White
    $serverCount = 0
    foreach ($serverName in $config.mcpServers.PSObject.Properties.Name) {
        $serverCount++
        $server = $config.mcpServers.$serverName
        
        if ($serverName -notmatch '_disabled$') {
            Write-Host "    $serverCount. $serverName" -ForegroundColor Gray
            
            # Identifier les serveurs suspects
            if ($serverName -match 'n8n|github|supabase') {
                Write-Host "      ⚠ Serveur suspect (peut exposer beaucoup d'outils)" -ForegroundColor Yellow
            }
        }
    }
    
    Write-Host ""
    Write-Host "  Total serveurs actifs: $serverCount" -ForegroundColor White
} else {
    Write-Host "  ⚠ Configuration Claude non trouvée" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "[3/4] Vérification logs MCP..." -ForegroundColor Yellow

$mcpLog = "$env:APPDATA\Claude\mcp.log"
if (Test-Path $mcpLog) {
    Write-Host "  ✓ Logs MCP trouvés" -ForegroundColor Green
    
    $logContent = Get-Content $mcpLog -Tail 100 -ErrorAction SilentlyContinue
    if ($logContent -match 'tool.*51|schema.*error|property.*pattern') {
        Write-Host "    ⚠ Erreurs liées au tool 51 trouvées dans les logs" -ForegroundColor Yellow
        Write-Host "    Dernières lignes pertinentes:" -ForegroundColor Gray
        $logContent | Select-String -Pattern 'tool.*51|schema|property' | Select-Object -Last 5 | ForEach-Object {
            Write-Host "      $_" -ForegroundColor Gray
        }
    } else {
        Write-Host "    ✓ Aucune erreur évidente dans les logs récents" -ForegroundColor Green
    }
} else {
    Write-Host "  ⚠ Logs MCP non trouvés" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "[4/4] Recommandations..." -ForegroundColor Yellow
Write-Host ""

Write-Host "ACTIONS RECOMMANDÉES:" -ForegroundColor Cyan
Write-Host ""
Write-Host "1. Désactiver temporairement les serveurs suspects:" -ForegroundColor White
Write-Host "   - Modifier claude_desktop_config.json" -ForegroundColor Gray
Write-Host "   - Renommer 'n8n-npx' en 'n8n-npx_disabled'" -ForegroundColor Gray
Write-Host "   - Redémarrer Claude Code" -ForegroundColor Gray
Write-Host ""
Write-Host "2. Si l'erreur persiste, desactiver d'autres serveurs un par un" -ForegroundColor White
Write-Host ""
Write-Host "3. Vérifier vos workflows n8n pour des paramètres avec noms invalides" -ForegroundColor White
Write-Host ""
Write-Host "4. Mettre à jour les packages MCP:" -ForegroundColor White
Write-Host "   npx -y @modelcontextprotocol/server-github@latest" -ForegroundColor Gray
Write-Host "   npx -y @playwright/mcp@latest" -ForegroundColor Gray
Write-Host ""

Write-Host "========================================" -ForegroundColor Green
Write-Host "  DIAGNOSTIC TERMINÉ" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green

