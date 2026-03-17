@echo off
taskkill /f /im brave.exe >nul 2>&1
timeout /t 1 >nul
set /p BRAVE_PATH=<"%~dp0brave-path.txt"
start "" "%BRAVE_PATH%" --remote-debugging-port=9222 --new-window
