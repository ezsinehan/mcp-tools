@echo off
taskkill /f /im brave.exe >nul 2>&1
taskkill /f /im chrome.exe >nul 2>&1
timeout /t 1 >nul
for /f "eol=# tokens=*" %%i in ("%~dp0brave-path.txt") do set BROWSER_PATH=%%i
start "" "%BROWSER_PATH%" --remote-debugging-port=9222 --new-window
