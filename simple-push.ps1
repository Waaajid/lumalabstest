Write-Host "Pushing Luma Labs Playground to GitHub..." -ForegroundColor Cyan

# Try to find Git
$gitPaths = @(
    "git",
    "C:\Program Files\Git\bin\git.exe",
    "C:\Program Files (x86)\Git\bin\git.exe"
)

$git = $null
foreach ($path in $gitPaths) {
    try {
        if ($path -eq "git") {
            & git --version 2>$null
            $git = "git"
            break
        } elseif (Test-Path $path) {
            $git = $path
            break
        }
    } catch {}
}

if (-not $git) {
    Write-Host "Git not found. Please restart your terminal and run:" -ForegroundColor Red
    Write-Host "git init" -ForegroundColor White
    Write-Host "git add ." -ForegroundColor White
    Write-Host "git commit -m 'Initial commit'" -ForegroundColor White
    Write-Host "git remote add origin https://github.com/Waaajid/lumalabstest.git" -ForegroundColor White
    Write-Host "git branch -M main" -ForegroundColor White
    Write-Host "git push -u origin main" -ForegroundColor White
    return
}

Write-Host "Git found! Pushing to repository..." -ForegroundColor Green

& $git init
& $git add .
& $git commit -m "Initial commit: Luma Labs API Playground"
& $git remote add origin https://github.com/Waaajid/lumalabstest.git
& $git branch -M main
& $git push -u origin main

Write-Host "Done! Check https://github.com/Waaajid/lumalabstest" -ForegroundColor Green
