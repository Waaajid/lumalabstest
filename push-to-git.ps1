$ErrorActionPreference = "Stop"

Write-Host "=========================================" -ForegroundColor Cyan
Write-Host " Pushing to GitHub: Waaajid/lumalabstest" -ForegroundColor Cyan
Write-Host "=========================================" -ForegroundColor Cyan

# Try to find Git
$gitPaths = @(
    "C:\Program Files\Git\bin\git.exe",
    "C:\Program Files (x86)\Git\bin\git.exe",
    "$env:LOCALAPPDATA\Programs\Git\bin\git.exe"
)

$git = $null
foreach ($path in $gitPaths) {
    if (Test-Path $path) {
        $git = $path
        Write-Host "Found Git at: $path" -ForegroundColor Green
        break
    }
}

if (-not $git) {
    Write-Host "Git not found! Please:" -ForegroundColor Red
    Write-Host "1. Restart your PowerShell/terminal" -ForegroundColor Yellow
    Write-Host "2. Or restart your computer" -ForegroundColor Yellow
    Write-Host "3. Then run this script again" -ForegroundColor Yellow
    Read-Host "Press Enter to exit"
    exit 1
}

try {
    Write-Host "Initializing repository..." -ForegroundColor Yellow
    & $git init
    
    Write-Host "Adding all files..." -ForegroundColor Yellow
    & $git add .
    
    Write-Host "Creating commit..." -ForegroundColor Yellow
    & $git commit -m "Updated Luma Labs Playground - Fixed API endpoints, beautiful white UI, ready for deployment"
    
    Write-Host "Setting up remote..." -ForegroundColor Yellow
    & $git remote remove origin 2>$null
    & $git remote add origin https://github.com/Waaajid/lumalabstest.git
    
    Write-Host "Pushing to GitHub..." -ForegroundColor Yellow
    & $git branch -M main
    & $git push -u origin main --force
    
    Write-Host ""
    Write-Host "=========================================" -ForegroundColor Green
    Write-Host " SUCCESS! Code pushed to GitHub!" -ForegroundColor Green
    Write-Host " Repository: https://github.com/Waaajid/lumalabstest" -ForegroundColor Green
    Write-Host "=========================================" -ForegroundColor Green
    Write-Host ""
    
    Write-Host "Next: Deploy to Vercel" -ForegroundColor Cyan
    Write-Host "1. Go to: https://vercel.com/new" -ForegroundColor White
    Write-Host "2. Import: Waaajid/lumalabstest" -ForegroundColor White
    Write-Host "3. Project name: wajid-lumalabs-playground" -ForegroundColor White
    Write-Host "4. Add environment variable: LUMA_API_KEY" -ForegroundColor White
    Write-Host "5. Deploy!" -ForegroundColor White
    
} catch {
    Write-Host "Error occurred: $_" -ForegroundColor Red
    Write-Host "You may need to authenticate with GitHub or restart your terminal." -ForegroundColor Yellow
}

Read-Host "Press Enter to continue"
