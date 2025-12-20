# Show archive structure summary
$archivePath = "C:\Users\Utilisateur\jerome\ARCHIVES-GROUPE-LEBOEUF"

Write-Host "`n========================================================" -ForegroundColor Cyan
Write-Host "  STRUCTURE FINALE DES ARCHIVES" -ForegroundColor Cyan
Write-Host "========================================================`n" -ForegroundColor Cyan

$dirs = Get-ChildItem $archivePath -Directory | Sort-Object Name
foreach ($dir in $dirs) {
    $fileCount = (Get-ChildItem $dir.FullName -Recurse -File -ErrorAction SilentlyContinue | Measure-Object).Count
    Write-Host "  $($dir.Name.PadRight(35)) $fileCount fichiers" -ForegroundColor White
}

$totalFiles = (Get-ChildItem $archivePath -Recurse -File -ErrorAction SilentlyContinue | Measure-Object).Count
$totalDirs = (Get-ChildItem $archivePath -Recurse -Directory -ErrorAction SilentlyContinue | Measure-Object).Count

Write-Host "`n  ----------------------------------------" -ForegroundColor DarkGray
Write-Host "  TOTAL: $totalDirs dossiers, $totalFiles fichiers" -ForegroundColor Yellow
Write-Host "`n========================================================`n" -ForegroundColor Cyan
