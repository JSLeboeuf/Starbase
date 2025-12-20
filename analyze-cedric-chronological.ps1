# Analyze Cedric emails chronologically
$emailFile = "C:\Users\Utilisateur\jerome\CEDRIC-TOUS-EMAILS.txt"
$outputFile = "C:\Users\Utilisateur\jerome\CEDRIC-ANALYSE-CHRONOLOGIQUE.txt"

Write-Host "Analyzing Cedric emails chronologically..." -ForegroundColor Cyan

$content = Get-Content $emailFile -Raw
$emails = $content -split "============================================================"

$parsed = @()

foreach ($email in $emails) {
    if ($email -match "DATE:\s*(.+)") {
        $dateStr = $Matches[1].Trim()

        $subject = ""
        if ($email -match "SUBJECT:\s*(.+)") {
            $subject = $Matches[1].Trim()
        }

        $from = ""
        if ($email -match "FROM:\s*(.+)") {
            $from = $Matches[1].Trim()
        }

        $to = ""
        if ($email -match "TO:\s*(.+)") {
            $to = $Matches[1].Trim()
        }

        $attachments = ""
        if ($email -match "PIECES JOINTES:\s*(.+)") {
            $attachments = $Matches[1].Trim()
        }

        # Try to parse date
        try {
            $parsedDate = [DateTime]::Parse($dateStr)
            $parsed += [PSCustomObject]@{
                Date = $parsedDate
                DateStr = $dateStr
                From = $from
                To = $to
                Subject = $subject
                Attachments = $attachments
                Body = $email.Substring(0, [Math]::Min(500, $email.Length))
            }
        } catch {
            # Skip unparseable dates
        }
    }
}

# Sort chronologically (oldest first)
$sorted = $parsed | Sort-Object Date

Write-Host "Total emails parsed: $($sorted.Count)" -ForegroundColor Green

# Output summary by year/month
$output = @()
$output += "============================================"
$output += "ANALYSE CHRONOLOGIQUE - CEDRIC LEBOEUF"
$output += "Genere le: $(Get-Date)"
$output += "Total emails: $($sorted.Count)"
$output += "============================================"
$output += ""

# Group by year
$byYear = $sorted | Group-Object { $_.Date.Year }

foreach ($year in $byYear | Sort-Object Name) {
    $output += ""
    $output += "##################################################"
    $output += "# ANNEE $($year.Name) - $($year.Count) emails"
    $output += "##################################################"

    # Group by month
    $byMonth = $year.Group | Group-Object { $_.Date.ToString("yyyy-MM") }

    foreach ($month in $byMonth | Sort-Object Name) {
        $monthName = [DateTime]::ParseExact($month.Name, "yyyy-MM", $null).ToString("MMMM yyyy")
        $output += ""
        $output += "=== $monthName ($($month.Count) emails) ==="

        foreach ($email in $month.Group | Sort-Object Date) {
            $output += ""
            $output += "[$($email.Date.ToString('yyyy-MM-dd HH:mm'))]"
            $output += "  FROM: $($email.From)"
            $output += "  TO: $($email.To)"
            $output += "  SUBJECT: $($email.Subject)"
            if ($email.Attachments) {
                $output += "  PJ: $($email.Attachments)"
            }
        }
    }
}

$output | Out-File $outputFile -Encoding UTF8

Write-Host "Output saved to: $outputFile" -ForegroundColor Green

# Also create summary of key events
$keyTerms = @("BLOOM", "VETA", "RH Support", "Marie-Christine", "Valleyfield", "9551", "9552", "Felix", "Hamel", "transaction", "quittance", "acquisition", "financement", "contrat")

$keyEvents = @()
$keyEvents += ""
$keyEvents += "============================================"
$keyEvents += "EVENEMENTS CLES"
$keyEvents += "============================================"

foreach ($email in $sorted) {
    $fullText = "$($email.Subject) $($email.Attachments)"
    foreach ($term in $keyTerms) {
        if ($fullText -match $term) {
            $keyEvents += "[$($email.Date.ToString('yyyy-MM-dd'))] $($email.Subject)"
            break
        }
    }
}

$keyEvents | Out-File "C:\Users\Utilisateur\jerome\CEDRIC-EVENEMENTS-CLES.txt" -Encoding UTF8
Write-Host "Key events saved to: CEDRIC-EVENEMENTS-CLES.txt" -ForegroundColor Green
