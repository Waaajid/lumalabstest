@echo off
echo ======================================
echo  Pushing Luma Labs Playground to GitHub
echo ======================================
echo.

echo Setting up Git repository...
git init

echo Adding all files...
git add .

echo Creating first commit...
git commit -m "Initial commit: Luma Labs API Playground - Beautiful white UI with red accents, working API integration"

echo Adding your GitHub repository as origin...
git remote add origin https://github.com/Waaajid/lumalabstest.git

echo Pushing to GitHub...
git branch -M main
git push -u origin main

echo.
echo ======================================
echo  ✅ Successfully pushed to GitHub!
echo  🌐 Repository: https://github.com/Waaajid/lumalabstest
echo ======================================
echo.

echo Now deploying to Vercel...
echo 1. Go to: https://vercel.com/new
echo 2. Import from GitHub: Waaajid/lumalabstest
echo 3. Add environment variable:
echo    Name: LUMA_API_KEY
echo    Value: luma-79f19c8f-5508-4100-8933-4f69c9c54c19-f9a8401b-ce17-4d66-a7c5-cc67334d05fc
echo 4. Click Deploy!
echo.

pause
