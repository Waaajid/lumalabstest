# PowerShell script to push Luma Labs Playground to GitHub
Write-Host "======================================" -ForegroundColor Cyan
Write-Host " Pushing Luma Labs Playground to GitHub" -ForegroundColor Cyan
Write-Host "======================================" -ForegroundColor Cyan
Write-Host ""

# Check if Git is available
try {
    $gitVersion = & git --version 2>$null
    Write-Host "✅ Git found: $gitVersion" -ForegroundColor Green
} catch {
    Write-Host "❌ Git not found in PATH. Trying alternative locations..." -ForegroundColor Yellow
    
    # Try common Git installation paths
    $gitPaths = @(
        "C:\Program Files\Git\bin\git.exe",
        "C:\Program Files (x86)\Git\bin\git.exe",
        "$env:LOCALAPPDATA\Programs\Git\bin\git.exe"
    )
    
    $gitFound = $false
    foreach ($path in $gitPaths) {
        if (Test-Path $path) {
            Set-Alias -Name git -Value $path -Scope Script
            Write-Host "✅ Found Git at: $path" -ForegroundColor Green
            $gitFound = $true
            break
        }
    }
    
    if (-not $gitFound) {
        Write-Host "❌ Git not found. Please restart PowerShell after Git installation." -ForegroundColor Red
        Write-Host "Or manually run these commands after restarting:" -ForegroundColor Yellow
        Write-Host "git init" -ForegroundColor White
        Write-Host "git add ." -ForegroundColor White
        Write-Host "git commit -m `"Initial commit: Luma Labs API Playground`"" -ForegroundColor White
        Write-Host "git remote add origin https://github.com/Waaajid/lumalabstest.git" -ForegroundColor White
        Write-Host "git branch -M main" -ForegroundColor White
        Write-Host "git push -u origin main" -ForegroundColor White
        pause
        exit
    }
}

Write-Host ""
Write-Host "🔧 Setting up Git repository..." -ForegroundColor Yellow
git init

Write-Host "📦 Adding all files..." -ForegroundColor Yellow
git add .

Write-Host "💾 Creating first commit..." -ForegroundColor Yellow
git commit -m "Initial commit: Luma Labs API Playground - Beautiful white UI with red accents, working API integration"

Write-Host "🔗 Adding your GitHub repository as origin..." -ForegroundColor Yellow
git remote add origin https://github.com/Waaajid/lumalabstest.git

Write-Host "🚀 Pushing to GitHub..." -ForegroundColor Yellow
git branch -M main
git push -u origin main

Write-Host ""
Write-Host "======================================" -ForegroundColor Green
Write-Host " ✅ Successfully pushed to GitHub!" -ForegroundColor Green
Write-Host " 🌐 Repository: https://github.com/Waaajid/lumalabstest" -ForegroundColor Green
Write-Host "======================================" -ForegroundColor Green
Write-Host ""

Write-Host "🚀 Next Steps - Deploy to Vercel:" -ForegroundColor Cyan
Write-Host "1. Go to: https://vercel.com/new" -ForegroundColor White
Write-Host "2. Import from GitHub: Waaajid/lumalabstest" -ForegroundColor White
Write-Host "3. Add environment variable:" -ForegroundColor White
Write-Host "   Name: LUMA_API_KEY" -ForegroundColor White
Write-Host "   Value: luma-79f19c8f-5508-4100-8933-4f69c9c54c19-f9a8401b-ce17-4d66-a7c5-cc67334d05fc" -ForegroundColor White
Write-Host "4. Click Deploy!" -ForegroundColor White
Write-Host ""

# Open GitHub repository
Write-Host "Opening GitHub repository..." -ForegroundColor Yellow
Start-Process "https://github.com/Waaajid/lumalabstest"

# Open Vercel for deployment
Start-Process "https://vercel.com/new"

Read-Host "Press Enter to continue"
