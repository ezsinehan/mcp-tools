# chrome-devtools MCP

Connects Claude Code to your browser via the Chrome DevTools Protocol — giving Claude live access to console logs, network requests, DOM, and performance metrics.

Works with any Chromium-based browser: Brave, Chrome, Edge.

## Requirements

- [Git](https://git-scm.com/)
- [Python 3.10+](https://www.python.org/)
- [uv](https://docs.astral.sh/uv/) — `pip install uv`
- [Claude Code](https://claude.ai/code)
- Brave, Chrome, or Edge

## Setup

1. Clone this repo
2. Copy `brave-path.example.txt` to `brave-path.txt`
3. Open `brave-path.txt` and replace `YOUR_PATH_HERE` with your browser executable path:

   **Windows (Brave)**
   ```
   C:\Program Files\BraveSoftware\Brave-Browser\Application\brave.exe
   ```
   **Windows (Chrome)**
   ```
   C:\Program Files\Google\Chrome\Application\chrome.exe
   ```
   **macOS (Brave)**
   ```
   /Applications/Brave Browser.app/Contents/MacOS/Brave Browser
   ```
   **macOS (Chrome)**
   ```
   /Applications/Google Chrome.app/Contents/MacOS/Google Chrome
   ```

4. Run `setup.bat` (Windows) — installs dependencies and prints the `claude mcp add` command to run
5. Run the printed `claude mcp add` command in your terminal
6. Restart Claude Code

## Usage

**Windows:** Run `brave-debug.bat` (or type `brave-debug` if you added the folder to PATH)

**macOS:** Run the browser manually:
```bash
"/Applications/Brave Browser.app/Contents/MacOS/Brave Browser" --remote-debugging-port=9222 --new-window
```

Then open your site in that browser window and ask Claude to inspect it.

## Notes

- Close all existing browser windows before launching with the debug flag — it only applies to a fresh launch
- Port 9222 is local only and not exposed to the network
- `brave-path.txt` is gitignored — never commit it
