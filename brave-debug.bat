@echo off
set /p BRAVE_PATH=<brave-path.txt
start "" "%BRAVE_PATH%" --remote-debugging-port=9222 --new-window
