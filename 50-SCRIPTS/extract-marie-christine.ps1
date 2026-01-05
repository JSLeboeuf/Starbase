# Extract all emails related to Marie-Christine Parisien

$outputFile = "C:\Users\Utilisateur\jerome\MARIE-CHRISTINE-PARISIEN-EMAILS.txt"
$searchTerms = @("marie-christine", "parisien", "mcparisien")

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "  EXTRACTION EMAILS MARIE-CHRISTINE PARISIEN" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

# Process CEDRIC emails
$cedricFile = "C:\Users\Utilisateur\jerome\CEDRIC-TOUS-EMAILS.txt"
$felixFile = "C:\Users\Utilisateur\jerome\FELIX-TOUS-EMAILS.txt"

$allEmails = @()
$emailCount = 0

function Extract-EmailsWithKeyword($filePath, $source) {
    $content = Get-Content $filePath -Raw -Encoding UTF8
    $emails = $content -split "============================================================"

    $matchingEmails = @()

    foreach ($email in $emails) {
        $matchFound = $false
        foreach ($term in $searchTerms) {
            if ($email -match $term) {
                $matchFound = $true
                break
            }
        }

        if ($matchFound -and $email.Trim().Length -gt 50) {
            $matchingEmails += @{
                Source = $source
                Content = $email.Trim()
            }
        }
    }

    return $matchingEmails
}

Write-Host "`nSearching in CEDRIC emails..." -ForegroundColor Yellow
$cedricMatches = Extract-EmailsWithKeyword $cedricFile "CEDRIC"
Write-Host "  Found: $($cedricMatches.Count) emails" -ForegroundColor Green

Write-Host "Searching in FELIX emails..." -ForegroundColor Yellow
$felixMatches = Extract-EmailsWithKeyword $felixFile "FELIX"
Write-Host "  Found: $($felixMatches.Count) emails" -ForegroundColor Green

$allMatches = $cedricMatches + $felixMatches

# Write output file
$output = @"
============================================
EMAILS MARIE-CHRISTINE PARISIEN
(mcparisien@hotmail.com)
Extracted: $(Get-Date)
Total: $($allMatches.Count) emails
Sources: CEDRIC ($($cedricMatches.Count)), FELIX ($($felixMatches.Count))
============================================

"@

foreach ($match in $allMatches) {
    $output += "`n[SOURCE: $($match.Source)]`n"
    $output += "============================================================`n"
    $output += $match.Content
    $output += "`n"
}

$output | Out-File $outputFile -Encoding UTF8

Write-Host "`n========================================" -ForegroundColor Green
Write-Host "  EXTRACTION COMPLETE!" -ForegroundColor Green
Write-Host "  Total emails: $($allMatches.Count)" -ForegroundColor Green
Write-Host "  Output: $outputFile" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green

# Show summary of subjects
Write-Host "`nSujets des emails:" -ForegroundColor Cyan
foreach ($match in $allMatches) {
    if ($match.Content -match "SUBJECT:\s*(.+)") {
        Write-Host "  - $($Matches[1].Substring(0, [Math]::Min(80, $Matches[1].Length)))" -ForegroundColor White
    }
}
