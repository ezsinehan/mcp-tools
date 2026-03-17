@echo off
echo Setting up chrome-devtools MCP...

:: Set install path
set INSTALL_DIR=%USERPROFILE%\chrome-devtools-mcp

:: Clone if not already present
if not exist "%INSTALL_DIR%" (
    echo Cloning chrome-devtools-mcp...
    git clone https://github.com/benjaminr/chrome-devtools-mcp.git "%INSTALL_DIR%"
) else (
    echo chrome-devtools-mcp already exists, skipping clone.
)

:: Install dependencies
echo Installing dependencies...
cd "%INSTALL_DIR%"
uv sync

:: Set up brave-path.txt if not present
if not exist "%~dp0brave-path.txt" (
    echo.
    echo brave-path.txt not found.
    echo Copy brave-path.example.txt to brave-path.txt and set your Brave path.
) else (
    echo brave-path.txt already exists.
)

echo.
echo ============================================================
echo  FINAL STEP: Run this command in your terminal, then
echo  restart Claude Code:
echo.
echo  claude mcp add chrome-devtools "%INSTALL_DIR%\.venv\Scripts\python.exe" "%INSTALL_DIR%\server.py" -e CHROME_DEBUG_PORT=9222
echo ============================================================
pause
