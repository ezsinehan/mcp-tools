# mcp-tools

MCP server configs and dev tooling scripts.

## brave-debug

Launches Brave with remote debugging enabled on port 9222 for use with the [chrome-devtools MCP server](https://github.com/benjaminr/chrome-devtools-mcp).

### Setup

1. Copy `brave-path.example.txt` to `brave-path.txt`
2. Edit `brave-path.txt` with your Brave executable path
3. Run `brave-debug.bat`

### Chrome DevTools MCP

Install the MCP server:

```bash
git clone https://github.com/benjaminr/chrome-devtools-mcp.git
cd chrome-devtools-mcp
uv sync
claude mcp add chrome-devtools "$(pwd)/.venv/Scripts/python.exe" "$(pwd)/server.py" -e CHROME_DEBUG_PORT=9222
```

Then launch `brave-debug.bat` before starting Claude Code.
