# Organize RH Support attachments

$sourcePath = 'C:\Users\Utilisateur\jerome\RHSUPPORT-PIECES-JOINTES'
$destBase = 'C:\Users\Utilisateur\jerome\RHSUPPORT-ORGANISE'

Write-Host "`n========================================" -ForegroundColor Magenta
Write-Host "  ORGANIZING RH SUPPORT DATA" -ForegroundColor Magenta
Write-Host "========================================" -ForegroundColor Magenta

# Create folders
$folders = @(
    "$destBase",
    "$destBase\01-CONTRATS-TRAVAIL",
    "$destBase\02-CVS-CANDIDATS",
    "$destBase\03-OFFRES-EMPLOI",
    "$destBase\04-FACTURES",
    "$destBase\05-PRESENTATIONS",
    "$destBase\06-POLITIQUES-RH",
    "$destBase\07-PAIE-DOCUMENTS",
    "$destBase\08-FORMATIONS",
    "$destBase\09-EVALUATIONS",
    "$destBase\10-CALENDRIERS-ICS",
    "$destBase\11-IMAGES-LOGOS",
    "$destBase\12-EXCEL-RAPPORTS",
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

    if ($fname -match 'contrat.*travail|contrat.*emploi|offer.*letter|employment.*agreement|lettre.*embauche|termination') {
        $dest = "$destBase\01-CONTRATS-TRAVAIL"
    }
    elseif ($fname -match 'cv|resume|curriculum|candidat|profil.*professionnel') {
        $dest = "$destBase\02-CVS-CANDIDATS"
    }
    elseif ($fname -match 'job.*posting|offre.*emploi|poste|vacancy|posting') {
        $dest = "$destBase\03-OFFRES-EMPLOI"
    }
    elseif ($fname -match 'facture|invoice|receipt|payment') {
        $dest = "$destBase\04-FACTURES"
    }
    elseif ($fname -match '\.pptx?$|presentation|pitch|deck|business.*plan') {
        $dest = "$destBase\05-PRESENTATIONS"
    }
    elseif ($fname -match 'politique|policy|manuel.*employ|handbook|procedure|guide.*rh') {
        $dest = "$destBase\06-POLITIQUES-RH"
    }
    elseif ($fname -match 'paie|payroll|salary|salaire|t4|releve|deduction|cheque') {
        $dest = "$destBase\07-PAIE-DOCUMENTS"
    }
    elseif ($fname -match 'formation|training|certification|course|webinar') {
        $dest = "$destBase\08-FORMATIONS"
    }
    elseif ($fname -match 'evaluation|performance|review|assessment|appraisal') {
        $dest = "$destBase\09-EVALUATIONS"
    }
    elseif ($fname -match '\.ics$|invite|calendar') {
        $dest = "$destBase\10-CALENDRIERS-ICS"
    }
    elseif ($fname -match '\.(png|jpg|jpeg|gif)$') {
        $dest = "$destBase\11-IMAGES-LOGOS"
    }
    elseif ($fname -match '\.xlsx?$|\.csv$|report|rapport|kpi|metrics|stats') {
        $dest = "$destBase\12-EXCEL-RAPPORTS"
    }
    else {
        $dest = "$destBase\13-AUTRES"
    }

    $category = Split-Path $dest -Leaf
    if (-not $stats.ContainsKey($category)) { $stats[$category] = 0 }
    $stats[$category]++

    Copy-Item $file.FullName -Destination $dest -Force -ErrorAction SilentlyContinue
}

Write-Host "`nFichiers organises pour RH SUPPORT:" -ForegroundColor Cyan
$stats.GetEnumerator() | Sort-Object Name | ForEach-Object {
    Write-Host "  $($_.Key): $($_.Value)"
}
Write-Host "Total: $($files.Count) fichiers" -ForegroundColor Green
Write-Host "`n========================================" -ForegroundColor Green
Write-Host "  ORGANISATION RH SUPPORT COMPLETE!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
