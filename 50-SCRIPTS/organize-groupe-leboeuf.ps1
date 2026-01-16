# ================================================================
# ORGANISATION COMPLETE - GROUPE LEBOEUF
# Script d'organisation de toutes les donnees extraites
# ================================================================

$basePath = "C:\Users\Utilisateur\jerome"
$archivePath = "$basePath\ARCHIVES-GROUPE-LEBOEUF"

Write-Host "`n" -NoNewline
Write-Host "========================================================" -ForegroundColor Magenta
Write-Host "  ORGANISATION DES ARCHIVES - GROUPE LEBOEUF" -ForegroundColor Magenta
Write-Host "========================================================" -ForegroundColor Magenta

# ================================================================
# CREATION DE LA STRUCTURE DE DOSSIERS
# ================================================================

$folders = @(
    "$archivePath",
    "$archivePath\00-INDEX",
    "$archivePath\01-HISTOIRE-DOCUMENTATION",
    "$archivePath\02-COURRIELS-EXTRAITS",
    "$archivePath\02-COURRIELS-EXTRAITS\CEDRIC-LEBOEUF",
    "$archivePath\02-COURRIELS-EXTRAITS\MARIE-CHRISTINE-PARISIEN",
    "$archivePath\02-COURRIELS-EXTRAITS\RH-SUPPORT",
    "$archivePath\02-COURRIELS-EXTRAITS\FELIX-HAMEL",
    "$archivePath\02-COURRIELS-EXTRAITS\JEROME-LEVAC",
    "$archivePath\02-COURRIELS-EXTRAITS\VALERIE-RAINVILLE",
    "$archivePath\03-PIECES-JOINTES",
    "$archivePath\03-PIECES-JOINTES\PAR-SOURCE",
    "$archivePath\03-PIECES-JOINTES\PAR-CATEGORIE",
    "$archivePath\03-PIECES-JOINTES\PAR-CATEGORIE\CONTRATS-TRAVAIL",
    "$archivePath\03-PIECES-JOINTES\PAR-CATEGORIE\CVS-CANDIDATS",
    "$archivePath\03-PIECES-JOINTES\PAR-CATEGORIE\FACTURES-JURIDIQUES",
    "$archivePath\03-PIECES-JOINTES\PAR-CATEGORIE\POLITIQUES-RH",
    "$archivePath\03-PIECES-JOINTES\PAR-CATEGORIE\DOCUMENTS-CORPORATIFS",
    "$archivePath\03-PIECES-JOINTES\PAR-CATEGORIE\RAPPORTS-KPI",
    "$archivePath\03-PIECES-JOINTES\PAR-CATEGORIE\LOGOS-IMAGES",
    "$archivePath\03-PIECES-JOINTES\PAR-CATEGORIE\AUTRES",
    "$archivePath\04-ENTREPRISES",
    "$archivePath\04-ENTREPRISES\BLOOM-COMPTABILITE",
    "$archivePath\04-ENTREPRISES\RH-SUPPORT",
    "$archivePath\04-ENTREPRISES\VETA-CLINIQUE",
    "$archivePath\04-ENTREPRISES\VALLEYFIELD-ACQUISITION",
    "$archivePath\04-ENTREPRISES\SOCIETES-HOLDING",
    "$archivePath\05-DOSSIERS-JURIDIQUES",
    "$archivePath\05-DOSSIERS-JURIDIQUES\BLOOM-38827-PARISIEN",
    "$archivePath\05-DOSSIERS-JURIDIQUES\ACQUISITION-VALLEYFIELD",
    "$archivePath\06-SCRIPTS-EXTRACTION"
)

Write-Host "`nCreation de la structure de dossiers..." -ForegroundColor Cyan
foreach ($folder in $folders) {
    if (-not (Test-Path $folder)) {
        New-Item -ItemType Directory -Path $folder -Force | Out-Null
        Write-Host "  [+] $($folder.Replace($basePath, '.'))" -ForegroundColor DarkGray
    }
}

# ================================================================
# DEPLACEMENT DES FICHIERS D'HISTOIRE/DOCUMENTATION
# ================================================================

Write-Host "`nOrganisation des documents d'histoire..." -ForegroundColor Cyan

$historyFiles = @(
    "HISTOIRE-COMPLETE-GROUPE-LEBOEUF.md",
    "HISTOIRE-GROUPE-LEBOEUF-CHRONOLOGIQUE.md",
    "CEDRIC-ANALYSE-CHRONOLOGIQUE.txt",
    "CEDRIC-EVENEMENTS-CLES.txt"
)

foreach ($file in $historyFiles) {
    $source = "$basePath\$file"
    $dest = "$archivePath\01-HISTOIRE-DOCUMENTATION\$file"
    if (Test-Path $source) {
        Copy-Item $source -Destination $dest -Force
        Write-Host "  [+] $file" -ForegroundColor Green
    }
}

# ================================================================
# DEPLACEMENT DES COURRIELS EXTRAITS
# ================================================================

Write-Host "`nOrganisation des courriels extraits..." -ForegroundColor Cyan

$emailMappings = @{
    "CEDRIC-TOUS-EMAILS.txt" = "02-COURRIELS-EXTRAITS\CEDRIC-LEBOEUF"
    "CEDRIC-LISTE-PIECES-JOINTES.csv" = "02-COURRIELS-EXTRAITS\CEDRIC-LEBOEUF"
    "MARIE-CHRISTINE-PARISIEN-TOUS-EMAILS.txt" = "02-COURRIELS-EXTRAITS\MARIE-CHRISTINE-PARISIEN"
    "MARIE-CHRISTINE-PARISIEN-LISTE-PJ.csv" = "02-COURRIELS-EXTRAITS\MARIE-CHRISTINE-PARISIEN"
    "RHSUPPORT-TOUS-EMAILS.txt" = "02-COURRIELS-EXTRAITS\RH-SUPPORT"
    "RHSUPPORT-LISTE-PIECES-JOINTES.csv" = "02-COURRIELS-EXTRAITS\RH-SUPPORT"
}

foreach ($mapping in $emailMappings.GetEnumerator()) {
    $source = "$basePath\$($mapping.Key)"
    $dest = "$archivePath\$($mapping.Value)\$($mapping.Key)"
    if (Test-Path $source) {
        Copy-Item $source -Destination $dest -Force
        Write-Host "  [+] $($mapping.Key)" -ForegroundColor Green
    }
}

# ================================================================
# ORGANISATION DES PIECES JOINTES PAR SOURCE
# ================================================================

Write-Host "`nOrganisation des pieces jointes par source..." -ForegroundColor Cyan

$attachmentFolders = @{
    "CEDRIC-PIECES-JOINTES" = "03-PIECES-JOINTES\PAR-SOURCE\CEDRIC-LEBOEUF"
    "CEDRIC-ORGANISE" = "03-PIECES-JOINTES\PAR-SOURCE\CEDRIC-ORGANISE"
    "MARIE-CHRISTINE-PARISIEN-PJ" = "03-PIECES-JOINTES\PAR-SOURCE\MARIE-CHRISTINE"
    "RHSUPPORT-PIECES-JOINTES" = "03-PIECES-JOINTES\PAR-SOURCE\RH-SUPPORT"
    "RHSUPPORT-ORGANISE" = "03-PIECES-JOINTES\PAR-SOURCE\RH-SUPPORT-ORGANISE"
}

foreach ($mapping in $attachmentFolders.GetEnumerator()) {
    $source = "$basePath\$($mapping.Key)"
    $dest = "$archivePath\$($mapping.Value)"
    if (Test-Path $source) {
        if (-not (Test-Path $dest)) {
            New-Item -ItemType Directory -Path $dest -Force | Out-Null
        }
        $count = (Get-ChildItem $source -File -ErrorAction SilentlyContinue | Measure-Object).Count
        Write-Host "  [+] $($mapping.Key) ($count fichiers)" -ForegroundColor Green
        # Create symbolic link or copy reference
        "$source" | Out-File "$dest\_SOURCE_LINK.txt" -Encoding UTF8
    }
}

# ================================================================
# COPIE DES SCRIPTS D'EXTRACTION
# ================================================================

Write-Host "`nCopie des scripts d'extraction..." -ForegroundColor Cyan

$scripts = Get-ChildItem $basePath -Filter "*.ps1" | Where-Object {
    $_.Name -match "extract|organize|analyse|analyze"
}

foreach ($script in $scripts) {
    Copy-Item $script.FullName -Destination "$archivePath\06-SCRIPTS-EXTRACTION\" -Force
    Write-Host "  [+] $($script.Name)" -ForegroundColor Green
}

# ================================================================
# CREATION DE L'INDEX PRINCIPAL
# ================================================================

Write-Host "`nCreation de l'index principal..." -ForegroundColor Cyan

$indexContent = @"
# INDEX DES ARCHIVES - GROUPE LEBOEUF

**Date de creation:** $(Get-Date -Format "yyyy-MM-dd HH:mm")
**Periode couverte:** Avril 2021 - Decembre 2025

---

## STRUCTURE DES ARCHIVES

```
ARCHIVES-GROUPE-LEBOEUF/
|
+-- 00-INDEX/
|   +-- INDEX-PRINCIPAL.md (ce fichier)
|   +-- GUIDE-NAVIGATION.md
|
+-- 01-HISTOIRE-DOCUMENTATION/
|   +-- HISTOIRE-COMPLETE-GROUPE-LEBOEUF.md
|   +-- HISTOIRE-GROUPE-LEBOEUF-CHRONOLOGIQUE.md
|   +-- CEDRIC-ANALYSE-CHRONOLOGIQUE.txt
|   +-- CEDRIC-EVENEMENTS-CLES.txt
|
+-- 02-COURRIELS-EXTRAITS/
|   +-- CEDRIC-LEBOEUF/
|   +-- MARIE-CHRISTINE-PARISIEN/
|   +-- RH-SUPPORT/
|   +-- FELIX-HAMEL/
|   +-- JEROME-LEVAC/
|   +-- VALERIE-RAINVILLE/
|
+-- 03-PIECES-JOINTES/
|   +-- PAR-SOURCE/
|   +-- PAR-CATEGORIE/
|
+-- 04-ENTREPRISES/
|   +-- BLOOM-COMPTABILITE/
|   +-- RH-SUPPORT/
|   +-- VETA-CLINIQUE/
|   +-- VALLEYFIELD-ACQUISITION/
|   +-- SOCIETES-HOLDING/
|
+-- 05-DOSSIERS-JURIDIQUES/
|   +-- BLOOM-38827-PARISIEN/
|   +-- ACQUISITION-VALLEYFIELD/
|
+-- 06-SCRIPTS-EXTRACTION/
```

---

## STATISTIQUES

| Source | Emails | Pieces Jointes |
|--------|--------|----------------|
| Cedric Leboeuf | 3,174 | 3,740 |
| RH Support | 2,603 | 1,327 |
| Felix Hamel | 1,925 | ~2,000 |
| Jerome Levac | 317 | ~200 |
| Marie-Christine Parisien | 302 | 500 |
| Valerie Rainville | 241 | ~150 |
| **TOTAL** | **~8,562** | **~8,000** |

---

## ENTREPRISES DU GROUPE

### 1. FINANCES BLOOM INC.
- **Activite:** Services comptables
- **Constitution:** Janvier 2023
- **Actionnaires:** Jean-Samuel, Cedric, Felix Hamel (depuis fev 2024)

### 2. RH SUPPORT INC.
- **Activite:** Recrutement et RH
- **Constitution:** 18 avril 2023
- **Directrice:** Valerie Rainville

### 3. CLINIQUE VETERINAIRE VETA INC.
- **Activite:** Services veterinaires
- **Directrice medicale:** Dre Amanda Cockburn

### 4. 9551-6241 QUEBEC INC.
- **Activite:** Operations CVV
- **Actionnaires:** Jean-Samuel, Cedric

### 5. 9552-5721 QUEBEC INC.
- **Activite:** Immobilier Valleyfield
- **Actionnaires:** Cedric, Felix, Jerome

---

## EVENEMENTS MAJEURS

| Date | Evenement |
|------|-----------|
| Jan 2023 | Constitution FINANCES BLOOM INC. |
| Avril 2023 | Constitution RH SUPPORT INC. |
| Sept 2023 | Crise BLOOM - Depart Marie-Christine |
| Oct 2023 | Ouverture dossier BLOOM-38827 |
| Fev 2024 | Sortie Marie-Christine / Entree Felix |
| Oct 2025 | Constitution 9551-6241 Quebec inc. |
| Dec 2025 | Financement BNC approuve pour Valleyfield |
| 17 Dec 2025 | Cloture prevue acquisition CVV |

---

## DOCUMENTS PRINCIPAUX A CONSULTER

1. **Pour l'histoire complete:**
   ``01-HISTOIRE-DOCUMENTATION/HISTOIRE-GROUPE-LEBOEUF-CHRONOLOGIQUE.md``

2. **Pour les evenements cles:**
   ``01-HISTOIRE-DOCUMENTATION/CEDRIC-EVENEMENTS-CLES.txt``

3. **Pour les courriels par personne:**
   ``02-COURRIELS-EXTRAITS/[NOM]/``

4. **Pour les pieces jointes par categorie:**
   ``03-PIECES-JOINTES/PAR-CATEGORIE/``

---

*Index genere automatiquement le $(Get-Date -Format "yyyy-MM-dd HH:mm")*
"@

$indexContent | Out-File "$archivePath\00-INDEX\INDEX-PRINCIPAL.md" -Encoding UTF8
Write-Host "  [+] INDEX-PRINCIPAL.md" -ForegroundColor Green

# ================================================================
# CREATION DU GUIDE DE NAVIGATION
# ================================================================

$guideContent = @"
# GUIDE DE NAVIGATION DES ARCHIVES

## Comment trouver ce que vous cherchez

### 1. Rechercher un evenement specifique
1. Ouvrir ``01-HISTOIRE-DOCUMENTATION/CEDRIC-EVENEMENTS-CLES.txt``
2. Utiliser Ctrl+F pour rechercher par mot-cle ou date
3. Les evenements sont classes par date [AAAA-MM-JJ]

### 2. Lire l'histoire complete
1. Ouvrir ``01-HISTOIRE-DOCUMENTATION/HISTOIRE-GROUPE-LEBOEUF-CHRONOLOGIQUE.md``
2. Le document est organise par annee puis par mois
3. Chaque evenement majeur est documente avec sa date exacte

### 3. Trouver les courriels d'une personne
1. Aller dans ``02-COURRIELS-EXTRAITS/[NOM]/``
2. Le fichier \`*-TOUS-EMAILS.txt\` contient tous les courriels
3. Le fichier \`*-LISTE-*.csv\` liste les pieces jointes

### 4. Trouver un type de document specifique
1. Aller dans ``03-PIECES-JOINTES/PAR-CATEGORIE/``
2. Choisir la categorie appropriee:
   - CONTRATS-TRAVAIL: Tous les contrats d'emploi
   - CVS-CANDIDATS: CV des candidats recrutes
   - FACTURES-JURIDIQUES: Factures Marois Avocat, Rancourt Legault
   - POLITIQUES-RH: Manuels et politiques
   - DOCUMENTS-CORPORATIFS: Resolutions, statuts, CEA
   - RAPPORTS-KPI: Rapports de performance BLOOM/VETA
   - LOGOS-IMAGES: Logos et visuels

### 5. Consulter un dossier juridique
1. Aller dans ``05-DOSSIERS-JURIDIQUES/``
2. BLOOM-38827-PARISIEN: Transaction Marie-Christine
3. ACQUISITION-VALLEYFIELD: Documents d'acquisition CVV

---

## Raccourcis Utiles

| Pour trouver | Aller a |
|--------------|---------|
| Transaction Marie-Christine | 05-DOSSIERS-JURIDIQUES/BLOOM-38827-PARISIEN |
| Integration Felix | 01-HISTOIRE > rechercher "Integration Felix" |
| KPIs BLOOM | 03-PIECES-JOINTES/PAR-CATEGORIE/RAPPORTS-KPI |
| Contrats VETA | 03-PIECES-JOINTES/PAR-CATEGORIE/CONTRATS-TRAVAIL |
| Acquisition Valleyfield | 05-DOSSIERS-JURIDIQUES/ACQUISITION-VALLEYFIELD |

---

*Guide mis a jour le $(Get-Date -Format "yyyy-MM-dd")*
"@

$guideContent | Out-File "$archivePath\00-INDEX\GUIDE-NAVIGATION.md" -Encoding UTF8
Write-Host "  [+] GUIDE-NAVIGATION.md" -ForegroundColor Green

# ================================================================
# RESUME FINAL
# ================================================================

Write-Host "`n========================================================" -ForegroundColor Green
Write-Host "  ORGANISATION TERMINEE!" -ForegroundColor Green
Write-Host "========================================================" -ForegroundColor Green

$folderCount = (Get-ChildItem $archivePath -Directory -Recurse | Measure-Object).Count
$fileCount = (Get-ChildItem $archivePath -File -Recurse | Measure-Object).Count

Write-Host "`nResume:" -ForegroundColor Cyan
Write-Host "  Dossiers crees: $folderCount" -ForegroundColor White
Write-Host "  Fichiers organises: $fileCount" -ForegroundColor White
Write-Host "  Emplacement: $archivePath" -ForegroundColor White

Write-Host "`nPour naviguer les archives:" -ForegroundColor Yellow
Write-Host "  1. Ouvrir: $archivePath\00-INDEX\INDEX-PRINCIPAL.md" -ForegroundColor White
Write-Host "  2. Consulter le GUIDE-NAVIGATION.md pour l'aide" -ForegroundColor White

Write-Host "`n========================================================`n" -ForegroundColor Green
