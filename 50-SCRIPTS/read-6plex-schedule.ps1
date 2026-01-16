# Read 6Plex Master Schedule Excel file
$filePath = "c:\Users\Utilisateur\OneDrive - Veta Veterinaire\Downloads\Master schedule de chantier 6Plex (2).xlsx"

$excel = New-Object -ComObject Excel.Application
$excel.Visible = $false
$excel.DisplayAlerts = $false

try {
    $workbook = $excel.Workbooks.Open($filePath)

    foreach ($sheet in $workbook.Sheets) {
        Write-Host "========================================" -ForegroundColor Cyan
        Write-Host "FEUILLE: $($sheet.Name)" -ForegroundColor Yellow
        Write-Host "========================================" -ForegroundColor Cyan

        $usedRange = $sheet.UsedRange
        $rows = $usedRange.Rows.Count
        $cols = $usedRange.Columns.Count
        Write-Host "Lignes: $rows, Colonnes: $cols" -ForegroundColor Gray
        Write-Host ""

        for ($r = 1; $r -le [Math]::Min($rows, 150); $r++) {
            $rowData = @()
            for ($c = 1; $c -le [Math]::Min($cols, 20); $c++) {
                $val = $sheet.Cells.Item($r, $c).Text
                if ($val -and $val.Trim() -ne "") {
                    $rowData += $val
                }
            }
            if ($rowData.Count -gt 0) {
                Write-Host ($rowData -join " | ")
            }
        }
        Write-Host ""
    }

    $workbook.Close($false)
} catch {
    Write-Host "Erreur: $_" -ForegroundColor Red
} finally {
    $excel.Quit()
    [System.Runtime.Interopservices.Marshal]::ReleaseComObject($excel) | Out-Null
}
