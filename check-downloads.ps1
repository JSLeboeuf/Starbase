# Check Downloads folder
$paths = @(
    "C:\Users\Utilisateur\Downloads",
    "C:\Users\Utilisateur\jerome\download",
    "C:\Users\Utilisateur\jerome\downloads",
    "C:\Users\Utilisateur\jerome\Download",
    "$env:USERPROFILE\Downloads"
)

foreach ($path in $paths) {
    if (Test-Path $path) {
        Write-Host "`nContenu de: $path" -ForegroundColor Cyan
        Write-Host "=" * 60 -ForegroundColor DarkGray
        Get-ChildItem $path | Sort-Object LastWriteTime -Descending | Select-Object -First 30 | ForEach-Object {
            $size = if ($_.PSIsContainer) { "[DIR]" } else { "{0:N0} KB" -f ($_.Length / 1KB) }
            Write-Host "  $($_.LastWriteTime.ToString('yyyy-MM-dd HH:mm'))  $($size.PadLeft(12))  $($_.Name)"
        }
    }
}
