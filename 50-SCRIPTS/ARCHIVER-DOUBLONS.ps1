# Script d'archivage des doublons
# Les fichiers dans ARCHIVES-GROUPE-LEBOEUF qui existent aussi dans 40-ANALYSES seront archives

$repoPath = "C:\Users\Utilisateur\jerome_repo"
$archivePath = Join-Path $repoPath "_ARCHIVES\DOUBLONS"

# Fichiers en double identifies (existent dans 40-ANALYSES et dans ARCHIVES-GROUPE-LEBOEUF)
$doublons = @(
    "ARCHIVES-GROUPE-LEBOEUF\07-ANALYSES-STRATEGIQUES\ANALYSE-ULTRA-PROFONDE-JEROME.md",
    "ARCHIVES-GROUPE-LEBOEUF\07-ANALYSES-STRATEGIQUES\ANALYSE-VRAI-PROBLEME-JEROME.md",
    "ARCHIVES-GROUPE-LEBOEUF\07-ANALYSES-STRATEGIQUES\INJUSTICE-SALAIRE-JEROME-VS-JEAN-SAMUEL.md",
    "ARCHIVES-GROUPE-LEBOEUF\07-ANALYSES-STRATEGIQUES\PROCHAINES-ETAPES-PROBABLES-JEROME.md",
    "ARCHIVES-GROUPE-LEBOEUF\07-ANALYSES-STRATEGIQUES\VALEUR-GENEREE-JEROME-6POURCENT.md"
)

Write-Host "=== ARCHIVAGE DES DOUBLONS ===" -ForegroundColor Yellow

foreach ($doublon in $doublons) {
    $sourcePath = Join-Path $repoPath $doublon
    if (Test-Path $sourcePath) {
        $fileName = Split-Path $doublon -Leaf
        $destPath = Join-Path $archivePath $fileName
        Move-Item -Path $sourcePath -Destination $destPath -Force
        Write-Host "Archive: $fileName" -ForegroundColor Cyan
    }
}

# Archiver aussi les scripts en double dans ARCHIVES-GROUPE-LEBOEUF\06-SCRIPTS-EXTRACTION
$scriptsDoublons = Get-ChildItem -Path "$repoPath\ARCHIVES-GROUPE-LEBOEUF\06-SCRIPTS-EXTRACTION\*.ps1" -ErrorAction SilentlyContinue
foreach ($script in $scriptsDoublons) {
    $existeInScripts = Test-Path (Join-Path "$repoPath\50-SCRIPTS" $script.Name)
    if ($existeInScripts) {
        Move-Item -Path $script.FullName -Destination $archivePath -Force
        Write-Host "Archive script doublon: $($script.Name)" -ForegroundColor Magenta
    }
}

Write-Host "`n=== ARCHIVAGE TERMINE ===" -ForegroundColor Green
Write-Host "Doublons deplaces vers: _ARCHIVES\DOUBLONS" -ForegroundColor Green
