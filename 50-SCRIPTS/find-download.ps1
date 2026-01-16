# Find any download folder
Write-Host "Recherche de dossiers download..." -ForegroundColor Cyan

# Check standard Downloads
$standardDownloads = [Environment]::GetFolderPath('UserProfile') + "\Downloads"
Write-Host "`nDossier standard: $standardDownloads" -ForegroundColor Yellow

if (Test-Path $standardDownloads) {
    Write-Host "  EXISTE - Contenu recent:" -ForegroundColor Green
    Get-ChildItem $standardDownloads -ErrorAction SilentlyContinue | Sort-Object LastWriteTime -Descending | Select-Object -First 25 | ForEach-Object {
        $size = if ($_.PSIsContainer) { "[DIR]" } else { "{0:N0} KB" -f ($_.Length / 1KB) }
        Write-Host "    $($_.LastWriteTime.ToString('yyyy-MM-dd HH:mm'))  $($size.PadLeft(12))  $($_.Name)"
    }
} else {
    Write-Host "  N'existe pas" -ForegroundColor Red
}

# Search in jerome folder
Write-Host "`nRecherche dans jerome..." -ForegroundColor Yellow
$found = Get-ChildItem "C:\Users\Utilisateur\jerome" -Directory -ErrorAction SilentlyContinue | Where-Object { $_.Name -match "download" }
if ($found) {
    foreach ($f in $found) {
        Write-Host "  Trouve: $($f.FullName)" -ForegroundColor Green
        Get-ChildItem $f.FullName | ForEach-Object { Write-Host "    - $($_.Name)" }
    }
} else {
    Write-Host "  Aucun dossier 'download' trouve" -ForegroundColor Red
}

# List recent folders created in jerome
Write-Host "`nDossiers recents dans jerome (derniere heure):" -ForegroundColor Yellow
Get-ChildItem "C:\Users\Utilisateur\jerome" -Directory | Where-Object { $_.LastWriteTime -gt (Get-Date).AddHours(-1) } | ForEach-Object {
    Write-Host "  $($_.LastWriteTime.ToString('HH:mm:ss')) - $($_.Name)" -ForegroundColor Cyan
}
