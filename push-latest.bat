@echo off
echo =========================================
echo  Pushing to https://github.com/Waaajid/lumalabstest.git
echo =========================================

REM Add Git to PATH for this session
set PATH=%PATH%;C:\Program Files\Git\bin

echo Checking Git installation...
git --version
if errorlevel 1 (
    echo Git not found! Please restart your terminal or computer after Git installation.
    pause
    exit /b 1
)

echo Initializing repository...
git init

echo Adding all files...
git add .

echo Creating commit...
git commit -m "Updated Luma Labs Playground - Fixed API endpoints, beautiful white UI, ready for deployment"

echo Setting up remote...
git remote remove origin 2>nul
git remote add origin https://github.com/Waaajid/lumalabstest.git

echo Pushing to GitHub...
git branch -M main
git push -u origin main --force

echo.
echo =========================================
echo  SUCCESS! Code pushed to GitHub!
echo  Repository: https://github.com/Waaajid/lumalabstest
echo =========================================
echo.
echo Next step: Deploy to Vercel
echo 1. Go to: https://vercel.com/new
echo 2. Import: Waaajid/lumalabstest
echo 3. Project name: wajid-lumalabs-playground
echo 4. Add environment variable: LUMA_API_KEY
echo 5. Deploy!
echo.
pause
