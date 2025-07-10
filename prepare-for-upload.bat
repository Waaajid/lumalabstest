@echo off
echo 🚀 Preparing files for GitHub upload...

echo.
echo 📁 Creating deployment package...

:: Create a temporary directory for clean files
if exist "github-upload" rmdir /s /q "github-upload"
mkdir "github-upload"

:: Copy main files
copy "package.json" "github-upload\"
copy "server.js" "github-upload\"
copy "vercel.json" "github-upload\"
copy "README.md" "github-upload\"
copy ".env.example" "github-upload\"
copy ".gitignore" "github-upload\"

:: Copy public folder
xcopy "public" "github-upload\public\" /e /i

echo.
echo ✅ Files prepared in 'github-upload' folder!
echo.
echo 📋 Next steps:
echo 1. Go to https://github.com/Waaajid/lumalabstest
echo 2. Upload all files from the 'github-upload' folder
echo 3. Commit with message: "Add timing features - real-time elapsed timer"
echo 4. Deploy to Vercel using the uploaded repo
echo.
echo 🌐 Your local app is running at: http://localhost:3000
echo.
pause
