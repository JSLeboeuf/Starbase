# Organize Cedric attachments

$sourcePath = 'C:\Users\Utilisateur\jerome\CEDRIC-PIECES-JOINTES'
$destBase = 'C:\Users\Utilisateur\jerome\CEDRIC-ORGANISE'

Write-Host "`n========================================" -ForegroundColor Magenta
Write-Host "  ORGANIZING CEDRIC DATA" -ForegroundColor Magenta
Write-Host "========================================" -ForegroundColor Magenta

# Create folders
$folders = @(
    "$destBase",
    "$destBase\01-BAUX-CONTRATS",
    "$destBase\02-FINANCEMENT",
    "$destBase\03-EVALUATIONS-ANALYSES",
    "$destBase\04-PLANS-CONSTRUCTION",
    "$destBase\05-DOCUMENTS-FISCAUX",
    "$destBase\06-ETATS-FINANCIERS",
    "$destBase\07-RH-RECRUTEMENT",
    "$destBase\08-CALENDRIERS-ICS",
    "$destBase\09-IMAGES-LOGOS",
    "$destBase\10-CVS-PROFILS",
    "$destBase\11-CONTRATS-TRAVAIL",
    "$destBase\12-PRESENTATIONS",
    "$destBase\13-AUTRES"
)

foreach ($folder in $folders) {
    if (-not (Test-Path $folder)) {
        New-Item -ItemType Directory -Path $folder -Force | Out-Null
    }
}

$files = Get-ChildItem $sourcePath -File -ErrorAction SilentlyContinue
$stats = @{}

foreach ($file in $files) {
    $fname = $file.Name.ToLower()
    $dest = ''

    if ($fname -match 'bail|contrat.*service|acte.*vente|acte.*hypothe|convention.*achat|entente.*non.*concurr|reso.*caution|caution|hypotheque') {
        $dest = "$destBase\01-BAUX-CONTRATS"
    }
    elseif ($fname -match 'financement|offre.*financement|proposition.*financement|emprunteur|banque|bnc|desjardins') {
        $dest = "$destBase\02-FINANCEMENT"
    }
    elseif ($fname -match 'evaluation|analyse|fiche.*analyse|soumission.*plan|reglementaire|urbaniste|grille|usages|valorisation|projets.*docs') {
        $dest = "$destBase\03-EVALUATIONS-ANALYSES"
    }
    elseif ($fname -match 'plan.*impl|plan.*3d|zone.*imperm') {
        $dest = "$destBase\04-PLANS-CONSTRUCTION"
    }
    elseif ($fname -match 'taxe|compte.*taxe|relev.*taxe|impot|impôt') {
        $dest = "$destBase\05-DOCUMENTS-FISCAUX"
    }
    elseif ($fname -match 'etat.*financ|ef.*20|bilan|flux.*tres|resultat|summary') {
        $dest = "$destBase\06-ETATS-FINANCIERS"
    }
    elseif ($fname -match 'rh.*support|recrutement|politique.*rh|forfait.*rh|manuel.*employe') {
        $dest = "$destBase\07-RH-RECRUTEMENT"
    }
    elseif ($fname -match '\.ics$') {
        $dest = "$destBase\08-CALENDRIERS-ICS"
    }
    elseif ($fname -match '\.(png|jpg|jpeg|gif)$') {
        $dest = "$destBase\09-IMAGES-LOGOS"
    }
    elseif ($fname -match 'cv|resume|profil|fiche.*de|curriculum') {
        $dest = "$destBase\10-CVS-PROFILS"
    }
    elseif ($fname -match 'contrat.*travail|lettre.*employ|offer.*letter|termination|contrat.*emploi') {
        $dest = "$destBase\11-CONTRATS-TRAVAIL"
    }
    elseif ($fname -match '\.pptx?$|presentation|business.*plan|plan.*affaires') {
        $dest = "$destBase\12-PRESENTATIONS"
    }
    else {
        $dest = "$destBase\13-AUTRES"
    }

    $category = Split-Path $dest -Leaf
    if (-not $stats.ContainsKey($category)) { $stats[$category] = 0 }
    $stats[$category]++

    Copy-Item $file.FullName -Destination $dest -Force -ErrorAction SilentlyContinue
}

Write-Host "`nFichiers organises pour CEDRIC:" -ForegroundColor Cyan
$stats.GetEnumerator() | Sort-Object Name | ForEach-Object {
    Write-Host "  $($_.Key): $($_.Value)"
}
Write-Host "Total: $($files.Count) fichiers" -ForegroundColor Green
Write-Host "`n========================================" -ForegroundColor Green
Write-Host "  ORGANISATION CEDRIC COMPLETE!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
