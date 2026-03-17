# Adding a New MCP Setup

Each MCP gets its own folder. Follow this structure:

```
mcp-tools/
└── your-mcp-name/
    └── setup.bat
```

## setup.bat conventions

- Install/clone the MCP server if not already present
- Install dependencies
- Print the `claude mcp add` command at the end for the user to run manually
- Use `%USERPROFILE%` for paths so it works on any machine
- End with `pause` so the window stays open

## Template

```bat
@echo off
echo Setting up [your-mcp-name]...

set INSTALL_DIR=%USERPROFILE%\your-mcp-name

if not exist "%INSTALL_DIR%" (
    echo Cloning...
    git clone https://github.com/author/repo.git "%INSTALL_DIR%"
) else (
    echo Already exists, skipping clone.
)

echo Installing dependencies...
cd "%INSTALL_DIR%"
:: uv sync / npm install / pip install etc.

echo.
echo ============================================================
echo  FINAL STEP: Run this command in your terminal, then
echo  restart Claude Code:
echo.
echo  claude mcp add your-mcp-name "%%USERPROFILE%%\your-mcp-name\..." -e KEY=VALUE
echo ============================================================
pause
```
