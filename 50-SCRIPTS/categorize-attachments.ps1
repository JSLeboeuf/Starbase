# ================================================================
# CATEGORISATION DES PIECES JOINTES
# Organise les fichiers par type de document
# ================================================================

$basePath = "C:\Users\Utilisateur\jerome"
$archivePath = "$basePath\ARCHIVES-GROUPE-LEBOEUF"
$categoriesPath = "$archivePath\03-PIECES-JOINTES\PAR-CATEGORIE"

Write-Host "`n" -NoNewline
Write-Host "========================================================" -ForegroundColor Magenta
Write-Host "  CATEGORISATION DES PIECES JOINTES" -ForegroundColor Magenta
Write-Host "========================================================" -ForegroundColor Magenta

# Sources de pieces jointes
$sources = @(
    "$basePath\CEDRIC-PIECES-JOINTES",
    "$basePath\RHSUPPORT-PIECES-JOINTES",
    "$basePath\MARIE-CHRISTINE-PARISIEN-PJ"
)

# Compteurs
$stats = @{
    "CONTRATS-TRAVAIL" = 0
    "CVS-CANDIDATS" = 0
    "FACTURES-JURIDIQUES" = 0
    "POLITIQUES-RH" = 0
    "DOCUMENTS-CORPORATIFS" = 0
    "RAPPORTS-KPI" = 0
    "LOGOS-IMAGES" = 0
    "AUTRES" = 0
}

foreach ($source in $sources) {
    if (-not (Test-Path $source)) { continue }

    $sourceName = Split-Path $source -Leaf
    Write-Host "`nAnalyse de $sourceName..." -ForegroundColor Cyan

    $files = Get-ChildItem $source -File -ErrorAction SilentlyContinue

    foreach ($file in $files) {
        $name = $file.Name.ToLower()
        $category = "AUTRES"

        # Contrats de travail
        if ($name -match "contrat|emploi|employment|embauche|offre.*emploi|lettre.*engagement") {
            $category = "CONTRATS-TRAVAIL"
        }
        # CVs et candidatures
        elseif ($name -match "^cv|curriculum|resume|candidat|application") {
            $category = "CVS-CANDIDATS"
        }
        # Factures juridiques
        elseif ($name -match "facture|invoice|rancourt|legault|marois|avocat|honoraire|legal") {
            $category = "FACTURES-JURIDIQUES"
        }
        # Politiques RH
        elseif ($name -match "politique|policy|manuel|handbook|harcelement|diversite|teletravail|sante.*securite") {
            $category = "POLITIQUES-RH"
        }
        # Documents corporatifs
        elseif ($name -match "resolution|statut|constitution|cea|actionnaire|convention|registre|administrateur|bloom.*38827|transaction|quittance|integration.*felix|retrait") {
            $category = "DOCUMENTS-CORPORATIFS"
        }
        # Rapports KPI
        elseif ($name -match "kpi|rapport|report|performance|statistique|hebdo|daily|weekly|board") {
            $category = "RAPPORTS-KPI"
        }
        # Logos et images
        elseif ($name -match "\.(png|jpg|jpeg|gif|svg|bmp|ico)$" -or $name -match "logo|image|photo|banner") {
            $category = "LOGOS-IMAGES"
        }
        # Valleyfield - special
        elseif ($name -match "valleyfield|9551|9552|cvv|grenier|larocque|bail") {
            $category = "DOCUMENTS-CORPORATIFS"
        }

        # Copier vers la categorie
        $destPath = "$categoriesPath\$category"
        $destFile = "$destPath\$($file.Name)"

        if (-not (Test-Path $destFile)) {
            Copy-Item $file.FullName -Destination $destFile -ErrorAction SilentlyContinue
            $stats[$category]++
        }
    }
}

# Affichage des statistiques
Write-Host "`n========================================================" -ForegroundColor Green
Write-Host "  CATEGORISATION TERMINEE!" -ForegroundColor Green
Write-Host "========================================================" -ForegroundColor Green

Write-Host "`nStatistiques par categorie:" -ForegroundColor Cyan
$total = 0
foreach ($cat in $stats.GetEnumerator() | Sort-Object Value -Descending) {
    Write-Host "  $($cat.Key): $($cat.Value) fichiers" -ForegroundColor White
    $total += $cat.Value
}
Write-Host "`n  TOTAL: $total fichiers categorises" -ForegroundColor Yellow

Write-Host "`n========================================================`n" -ForegroundColor Green
