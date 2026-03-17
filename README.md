# mcp-tools

MCP server configs and dev tooling scripts.

## Setup

1. Clone this repo
2. Copy `brave-path.example.txt` to `brave-path.txt` and set your Brave executable path
3. Double-click `setup.bat` (or run it from terminal)
4. Restart Claude Code

That's it — `setup.bat` will clone the chrome-devtools MCP server, install dependencies, and register it with Claude Code automatically.

## Usage

Run `brave-debug` from any terminal to kill existing Brave instances and relaunch with remote debugging enabled on port 9222.

Then start Claude Code and ask it to inspect your site.

## Requirements

- [Git](https://git-scm.com/)
- [uv](https://docs.astral.sh/uv/) — install with `pip install uv`
- [Claude Code](https://claude.ai/code)
- Brave Browser
