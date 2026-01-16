# ================================================================
# EXTRACTION DES ANALYSES CURSOR - DOSSIER JEROME
# Extrait les documents importants de l'export Cursor
# ================================================================

$sourcePath = "C:\Users\Utilisateur\OneDrive - Veta Veterinaire\Downloads\cursor_repos_de_configuration_github.md"
$archivePath = "C:\Users\Utilisateur\jerome\ARCHIVES-GROUPE-LEBOEUF\07-ANALYSES-STRATEGIQUES"

Write-Host "`n" -NoNewline
Write-Host "========================================================" -ForegroundColor Magenta
Write-Host "  EXTRACTION DES ANALYSES CURSOR" -ForegroundColor Magenta
Write-Host "========================================================" -ForegroundColor Magenta

# Creer le dossier si necessaire
if (-not (Test-Path $archivePath)) {
    New-Item -ItemType Directory -Path $archivePath -Force | Out-Null
    Write-Host "  [+] Dossier cree: 07-ANALYSES-STRATEGIQUES" -ForegroundColor Green
}

# Lire le fichier source
Write-Host "`nLecture du fichier source..." -ForegroundColor Cyan
$content = Get-Content $sourcePath -Raw -Encoding UTF8

# Documents a extraire (sections markdown)
$documents = @{
    "INDEX-MASTER-JEROME-LEVAC.md" = @{
        Pattern = "# INDEX MASTER - DOSSIER JEROME LEVAC[\s\S]*?(?=\n---\n\n\*\*User\*\*|\n```\n\n)"
        Description = "Index complet du dossier Jerome Levac"
    }
    "ANALYSE-VRAI-PROBLEME-JEROME.md" = @{
        Pattern = "# ANALYSE - VRAI PROBL[EÈ]ME J[EÉ]R[OÔ]ME[\s\S]*?(?=\n---\n\n\*\*User\*\*|\n```\n\n)"
        Description = "Analyse du vrai probleme - Pourquoi Jerome cible vos parts"
    }
    "INJUSTICE-SALAIRE-JEROME-VS-JEAN-SAMUEL.md" = @{
        Pattern = "# INJUSTICE SALAIRE - J[EÉ]R[OÔ]ME VS JEAN-SAMUEL[\s\S]*?(?=\n---\n\n\*\*User\*\*|\n```\n\n)"
        Description = "Analyse injustice salariale"
    }
    "ANALYSE-JALOUSIE-ENVIE-JEROME.md" = @{
        Pattern = "# ANALYSE PSYCHOLOGIQUE - JALOUSIE ET ENVIE[\s\S]*?(?=\n---\n\n\*\*User\*\*|\n```\n\n)"
        Description = "Analyse psychologique jalousie et envie"
    }
    "RECHERCHES-WEB-APPROFONDIES.md" = @{
        Pattern = "# RECHERCHES WEB APPROFONDIES [AÀ] FAIRE[\s\S]*?(?=\n---\n\n\*\*User\*\*|\n```\n\n)"
        Description = "Liste des recherches web a effectuer"
    }
}

Write-Host "`nExtraction des documents..." -ForegroundColor Cyan
$extracted = 0

foreach ($doc in $documents.GetEnumerator()) {
    $filename = $doc.Key
    $pattern = $doc.Value.Pattern
    $description = $doc.Value.Description

    if ($content -match $pattern) {
        $match = $Matches[0]
        $destFile = "$archivePath\$filename"
        $match | Out-File $destFile -Encoding UTF8
        Write-Host "  [+] $filename ($description)" -ForegroundColor Green
        $extracted++
    }
}

# Extraire aussi un resume de la conversation
Write-Host "`nCreation du resume de la conversation..." -ForegroundColor Cyan

$resumeContent = @"
# RESUME - CONVERSATION CURSOR (15 decembre 2025)

## Source
- Fichier: cursor_repos_de_configuration_github.md
- Taille: ~1.3 MB
- Export: 15 decembre 2025

---

## SUJETS COUVERTS

### 1. Configuration GitHub/MCP
- Recherche repos GitHub (compte JSLeboeuf)
- Configuration MCP servers (github, supabase, n8n, twilio)
- Credentials et API keys

### 2. Migration OneDrive -> Google Drive
- Scripts rclone pour migration complete
- Best practices pour migration

### 3. Analyse Jerome Levac
- 317 emails analyses
- Salaire: 80,000$/an
- Participation: 6% equity
- Premier email: 20 juin 2024
- Projets: 6PLEX, 450 Larocque, Go Dentiste, Dick Ledoux

### 4. Analyses Strategiques Creees
- INDEX-MASTER-JEROME-LEVAC.md
- ANALYSE-VRAI-PROBLEME-JEROME.md
- INJUSTICE-SALAIRE-JEROME-VS-JEAN-SAMUEL.md
- ANALYSE-JALOUSIE-ENVIE-JEROME.md
- RECHERCHES-WEB-APPROFONDIES.md
- ANALYSE-EMAILS-CONVENTIONS-ACTIONNAIRES.md
- Et plusieurs autres...

---

## POINTS CLES SUR JEROME

### Problematique identifiee:
1. Jerome cible VOS parts (23%) et pas celles de Felix (23%)
2. Jerome est paye 80,000$/an - Vous n'avez AUCUN salaire
3. Jerome n'a rien fait sur les cliniques veterinaires en 18 mois
4. Jerome dit que vous avez un "role passif" alors que vous generez de la valeur

### Double standard:
- Jerome veut plus de parts sur ses projets
- Mais garde 6% sur VOS projets ou il n'a rien fait
- Il vous cible specifiquement, pas Felix

### Analyse psychologique:
- Signes de jalousie (receptionniste IA, innovation)
- "Toi t'es au-dessus de moi quand meme" (quand saoul)
- Veut compenser son sentiment d'inferiorite

---

## STRUCTURE PARTS ACTUELLE

| Personne | Parts | Salaire | Role |
|----------|-------|---------|------|
| Cedric | 48% | ? | Associe principal |
| Felix | 23% | ? | Associe (Go Dentiste) |
| Jean-Samuel | 23% | 0$ | Associe (Veta) |
| Jerome | 6% | 80,000$/an | Gestionnaire projets |

---

## RECOMMANDATIONS

1. Refuser le switch de parts sans compensation
2. Exiger que Jerome applique sa logique partout
3. Demander pourquoi il vous cible et pas Felix
4. Documenter toutes les discussions
5. Preparer convention d'actionnaire avec Nicolas Marois

---

*Resume genere le $(Get-Date -Format "yyyy-MM-dd HH:mm")*
"@

$resumeContent | Out-File "$archivePath\RESUME-CONVERSATION-CURSOR.md" -Encoding UTF8
Write-Host "  [+] RESUME-CONVERSATION-CURSOR.md" -ForegroundColor Green

# Creer l'index des analyses
Write-Host "`nCreation de l'index des analyses..." -ForegroundColor Cyan

$indexContent = @"
# INDEX - ANALYSES STRATEGIQUES

## Documents extraits de la conversation Cursor (15 decembre 2025)

---

### Analyses sur Jerome Levac

| Document | Description |
|----------|-------------|
| INDEX-MASTER-JEROME-LEVAC.md | Index complet du dossier Jerome |
| ANALYSE-VRAI-PROBLEME-JEROME.md | Pourquoi Jerome cible vos parts |
| INJUSTICE-SALAIRE-JEROME-VS-JEAN-SAMUEL.md | Comparaison salaire/equite |
| ANALYSE-JALOUSIE-ENVIE-JEROME.md | Analyse psychologique |
| RECHERCHES-WEB-APPROFONDIES.md | Recherches juridiques a faire |

---

### Resume

| Document | Description |
|----------|-------------|
| RESUME-CONVERSATION-CURSOR.md | Resume de toute la conversation |

---

### Source originale
- Fichier: ``cursor_repos_de_configuration_github.md``
- Emplacement: OneDrive - Veta Veterinaire\Downloads\
- Taille: ~1.3 MB

---

*Index genere le $(Get-Date -Format "yyyy-MM-dd HH:mm")*
"@

$indexContent | Out-File "$archivePath\INDEX-ANALYSES.md" -Encoding UTF8
Write-Host "  [+] INDEX-ANALYSES.md" -ForegroundColor Green

# Resume final
Write-Host "`n========================================================" -ForegroundColor Green
Write-Host "  EXTRACTION TERMINEE!" -ForegroundColor Green
Write-Host "========================================================" -ForegroundColor Green
Write-Host "`n  Documents extraits: $($extracted + 2)" -ForegroundColor White
Write-Host "  Emplacement: $archivePath" -ForegroundColor White
Write-Host "`n========================================================`n" -ForegroundColor Green
