# Chrome DevTools MCP — How It Was Set Up

A complete walkthrough of everything done to get this working, so you can set up any MCP from scratch.

---

## What Is MCP?

MCP (Model Context Protocol) is Anthropic's standard for giving Claude Code external tools. Instead of Claude only knowing what's in the conversation, MCP lets Claude spawn a local process and call it like a tool — getting back real data from outside the chat.

When you register an MCP server, Claude Code knows: *"there's a process I can run and send requests to."* Claude calls a tool, Claude Code spawns the server, the server does work, Claude reads the result.

---

## What Is the Chrome DevTools Protocol (CDP)?

Every Chromium browser (Brave, Chrome, Edge) has a built-in debugging interface — the same one powering F12 devtools. Normally it's internal. When you launch the browser with:

```
--remote-debugging-port=9222
```

...it exposes that interface over a local HTTP/WebSocket port. Any tool that speaks CDP can now read console logs, network requests, DOM, performance metrics, etc.

---

## What This MCP Does

`chrome-devtools-mcp` is a Python server that:
1. Connects to the browser on `localhost:9222` via WebSocket
2. Sends CDP commands ("get console logs", "get network requests", etc.)
3. Returns the results in a format Claude can read

Full chain:
```
Claude asks something
       ↓
Claude Code calls an MCP tool
       ↓
Spawns server.py
       ↓
server.py sends CDP commands to browser on port 9222
       ↓
Browser responds with live data
       ↓
Claude reads it and answers
```

---

## Prerequisites

- **Git** — to clone the MCP server repo
- **Python 3.10+** — the server is Python
- **uv** — fast Python package manager (`pip install uv`)
- **Claude Code** — the CLI

---

## Step-by-Step Setup

### 1. Clone the MCP server

```bash
git clone https://github.com/benjaminr/chrome-devtools-mcp.git %USERPROFILE%\chrome-devtools-mcp
```

This puts the server at `C:\Users\yourname\chrome-devtools-mcp`.

### 2. Install dependencies

```bash
cd %USERPROFILE%\chrome-devtools-mcp
uv sync
```

`uv sync` reads `pyproject.toml` and installs everything into a `.venv` folder inside the repo.

### 3. Register with Claude Code

```bash
claude mcp add chrome-devtools "%USERPROFILE%\chrome-devtools-mcp\.venv\Scripts\python.exe" "%USERPROFILE%\chrome-devtools-mcp\server.py" -e CHROME_DEBUG_PORT=9222
```

Breaking this down:
- `claude mcp add` — registers a new MCP server
- `chrome-devtools` — the name Claude will use to reference it
- `"...\python.exe"` — the executable to run (use the venv's Python, not system Python)
- `"...\server.py"` — the script to execute
- `-e CHROME_DEBUG_PORT=9222` — environment variable passed to the server

This writes to `~/.claude.json` under the current project.

### 4. Restart Claude Code

MCP servers are only loaded on startup. Always restart after adding one.

### 5. Launch the browser with debugging enabled

```bash
brave-debug   # using the bat file in this repo
```

Or manually:
```
"C:\Path\To\brave.exe" --remote-debugging-port=9222 --new-window
```

**Important:** Close all existing browser windows first. The debug flag only applies to a fresh launch — if the browser is already running, the flag is ignored.

---

## How `brave-debug.bat` Works

```bat
@echo off
taskkill /f /im brave.exe >nul 2>&1   # kill all Brave processes silently
taskkill /f /im chrome.exe >nul 2>&1  # kill Chrome too if open
timeout /t 1 >nul                      # wait 1 second for processes to close
for /f "eol=# tokens=*" %%i in ("%~dp0brave-path.txt") do set BROWSER_PATH=%%i
                                       # read path from file, skip lines starting with #
start "" "%BROWSER_PATH%" --remote-debugging-port=9222 --new-window
```

`brave-path.txt` is gitignored — each user sets their own path. `brave-path.example.txt` is committed as a template.

---

## Security Considerations

- Port 9222 is **local only** — it's not exposed to the network
- Never commit `brave-path.txt` — it contains your local file path
- Never commit `.env` files or API keys
- Use `%USERPROFILE%` in scripts instead of hardcoded paths so nothing is user-specific in the repo
- The `.gitignore` should always list any file that contains local paths or secrets

---

## Applying This to Any MCP

The pattern is always the same:

1. Find the MCP server repo (GitHub, npm, pip, etc.)
2. Clone/install it somewhere under `%USERPROFILE%`
3. Install its dependencies (uv, npm, pip — whatever it uses)
4. Run `claude mcp add <name> <executable> <entry-point> -e KEY=VALUE`
5. Restart Claude Code

For the `claude mcp add` command:
- The executable is whatever runtime the server uses (Python, Node, etc.) — always point to the **venv/local version**, not the system one
- The entry point is the main script or index file
- `-e` flags set environment variables the server needs (ports, API keys, etc.)

---

## Useful Commands

```bash
claude mcp list                        # see all registered MCP servers
claude mcp remove <name>               # unregister an MCP server
claude mcp add <name> <cmd> <args>     # register a new one
```
