@echo off
echo.
echo   ================================================
echo      CHAOS ENGINEERING PLATFORM - LAUNCHER
echo   ================================================
echo.

:: Check Node.js
node --version >nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    echo  ERROR: Node.js not found!
    echo  Please install from: https://nodejs.org/en/download
    pause
    exit /b 1
)

echo  Node.js found: 
node --version

:: Install dependencies if needed
IF NOT EXIST "node_modules\" (
    echo.
    echo  Installing dependencies...
    npm install
    IF %ERRORLEVEL% NEQ 0 (
        echo  ERROR: npm install failed!
        pause
        exit /b 1
    )
)

echo.
echo  Starting Chaos Engineering Platform...
echo  Open http://localhost:3000 in your browser
echo.
echo  Press Ctrl+C to stop
echo.

:: Open browser after a short delay
start "" /min cmd /c "timeout /t 2 /nobreak >nul && start http://localhost:3000"

:: Start server
node server.js
pause
