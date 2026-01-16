# Script de reorganisation du repo jerome_repo
# Execution autonome - Janvier 2026

$repoPath = "C:\Users\Utilisateur\jerome_repo"

# Creer les dossiers s'ils n'existent pas
$dossiers = @(
    "00-INDEX",
    "10-SITUATION-ACTUELLE",
    "20-PREUVES",
    "30-EMAILS",
    "40-ANALYSES",
    "50-SCRIPTS",
    "60-RESSOURCES",
    "70-PROJETS",
    "80-OUTILS-CLAUDE",
    "_ARCHIVES",
    "_ARCHIVES\DOUBLONS"
)

foreach ($dossier in $dossiers) {
    $path = Join-Path $repoPath $dossier
    if (-not (Test-Path $path)) {
        New-Item -ItemType Directory -Path $path -Force | Out-Null
        Write-Host "Cree: $dossier" -ForegroundColor Green
    }
}

# Deplacer les ANALYSES
$analyses = Get-ChildItem -Path $repoPath -Filter "ANALYSE-*.md" -File
foreach ($f in $analyses) {
    Move-Item -Path $f.FullName -Destination (Join-Path $repoPath "40-ANALYSES") -Force
    Write-Host "Deplace vers 40-ANALYSES: $($f.Name)" -ForegroundColor Cyan
}

# Deplacer SYNTHESE
$syntheses = Get-ChildItem -Path $repoPath -Filter "*SYNTHESE*.md" -File
foreach ($f in $syntheses) {
    Move-Item -Path $f.FullName -Destination (Join-Path $repoPath "40-ANALYSES") -Force
    Write-Host "Deplace vers 40-ANALYSES: $($f.Name)" -ForegroundColor Cyan
}

# Deplacer STRATEGIE
$strategies = Get-ChildItem -Path $repoPath -Filter "STRATEGI*.md" -File
foreach ($f in $strategies) {
    Move-Item -Path $f.FullName -Destination (Join-Path $repoPath "40-ANALYSES") -Force
    Write-Host "Deplace vers 40-ANALYSES: $($f.Name)" -ForegroundColor Cyan
}

# Deplacer MEMO, ALERTE, CEDRIC*, POURQUOI*, OFFRE*, PROPOSITION*, RETOURNEMENT*, CALCUL*, VALEUR*, PSYCHO*
$patterns = @("MEMO*.md", "ALERTE*.md", "CEDRIC*.md", "POURQUOI*.md", "OFFRE*.md", "PROPOSITION*.md", "RETOURNEMENT*.md", "CALCUL*.md", "VALEUR*.md", "PSYCHO*.md")
foreach ($pattern in $patterns) {
    $files = Get-ChildItem -Path $repoPath -Filter $pattern -File -ErrorAction SilentlyContinue
    foreach ($f in $files) {
        Move-Item -Path $f.FullName -Destination (Join-Path $repoPath "40-ANALYSES") -Force
        Write-Host "Deplace vers 40-ANALYSES: $($f.Name)" -ForegroundColor Cyan
    }
}

# Deplacer les EMAILS (.txt)
$emailPatterns = @("*-EMAILS*.txt", "*TOUS-EMAILS*.txt", "6PLEX-EMAILS.txt", "TERRASSE-DU-PONT-EMAILS.txt", "EXTRACTED-EMAILS*.txt")
foreach ($pattern in $emailPatterns) {
    $files = Get-ChildItem -Path $repoPath -Filter $pattern -File -ErrorAction SilentlyContinue
    foreach ($f in $files) {
        Move-Item -Path $f.FullName -Destination (Join-Path $repoPath "30-EMAILS") -Force
        Write-Host "Deplace vers 30-EMAILS: $($f.Name)" -ForegroundColor Yellow
    }
}

# Deplacer les SCRIPTS (.ps1)
$scripts = Get-ChildItem -Path $repoPath -Filter "*.ps1" -File | Where-Object { $_.Name -ne "REORGANISER-REPO.ps1" }
foreach ($f in $scripts) {
    Move-Item -Path $f.FullName -Destination (Join-Path $repoPath "50-SCRIPTS") -Force
    Write-Host "Deplace vers 50-SCRIPTS: $($f.Name)" -ForegroundColor Magenta
}

# Deplacer OUTILS CLAUDE
$claudePatterns = @("CLAUDE*.md", "PROMPT*.md", "MCP*.md", "GUIDE*.md", "OPTIMIS*.md", "MAXIMISER*.md", "ANTHROPIC*.md", "FIX-MCP*.md")
foreach ($pattern in $claudePatterns) {
    $files = Get-ChildItem -Path $repoPath -Filter $pattern -File -ErrorAction SilentlyContinue
    foreach ($f in $files) {
        if ($f.Name -ne "CLAUDE.md") {  # Garder CLAUDE.md a la racine
            Move-Item -Path $f.FullName -Destination (Join-Path $repoPath "80-OUTILS-CLAUDE") -Force
            Write-Host "Deplace vers 80-OUTILS-CLAUDE: $($f.Name)" -ForegroundColor Blue
        }
    }
}

# Deplacer RESSOURCES
$ressourcesPatterns = @("HISTOIRE*.md", "LE-PRINCE*.md", "LONSDALE*.md", "LISTE-AVOCATS*.md")
foreach ($pattern in $ressourcesPatterns) {
    $files = Get-ChildItem -Path $repoPath -Filter $pattern -File -ErrorAction SilentlyContinue
    foreach ($f in $files) {
        Move-Item -Path $f.FullName -Destination (Join-Path $repoPath "60-RESSOURCES") -Force
        Write-Host "Deplace vers 60-RESSOURCES: $($f.Name)" -ForegroundColor DarkYellow
    }
}

# Deplacer PREUVES
$preuvesPatterns = @("DOSSIER*.md", "FAITS*.md", "DOUBLE-STANDARD*.md", "INJUSTICE*.md", "TRANSCRIPT*.md")
foreach ($pattern in $preuvesPatterns) {
    $files = Get-ChildItem -Path $repoPath -Filter $pattern -File -ErrorAction SilentlyContinue
    foreach ($f in $files) {
        Move-Item -Path $f.FullName -Destination (Join-Path $repoPath "20-PREUVES") -Force
        Write-Host "Deplace vers 20-PREUVES: $($f.Name)" -ForegroundColor Red
    }
}

# Deplacer SITUATION ACTUELLE
$situationPatterns = @("RESUME*.md", "PROCHAINES*.md", "QUESTIONS*.md", "RECHERCHES*.md", "RESULTATS*.md", "DECORTICATION*.md", "MEGA-SYNTHESE*.md")
foreach ($pattern in $situationPatterns) {
    $files = Get-ChildItem -Path $repoPath -Filter $pattern -File -ErrorAction SilentlyContinue
    foreach ($f in $files) {
        Move-Item -Path $f.FullName -Destination (Join-Path $repoPath "10-SITUATION-ACTUELLE") -Force
        Write-Host "Deplace vers 10-SITUATION-ACTUELLE: $($f.Name)" -ForegroundColor White
    }
}

# Deplacer PROJETS
$projetsPatterns = @("RH-SUPPORT*.md", "BLOOM*.md", "CLAUSES*.md")
foreach ($pattern in $projetsPatterns) {
    $files = Get-ChildItem -Path $repoPath -Filter $pattern -File -ErrorAction SilentlyContinue
    foreach ($f in $files) {
        Move-Item -Path $f.FullName -Destination (Join-Path $repoPath "70-PROJETS") -Force
        Write-Host "Deplace vers 70-PROJETS: $($f.Name)" -ForegroundColor DarkCyan
    }
}

Write-Host "`n=== REORGANISATION TERMINEE ===" -ForegroundColor Green
Write-Host "Verifiez les dossiers crees." -ForegroundColor Green
