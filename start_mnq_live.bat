@echo off
REM ============================================================
REM  Live MNQ trading via Rithmic (Tradesea/Lucid)
REM
REM  Run this FROM the cloned bot folder (or double-click it in Explorer).
REM  If C:\Users\shawa\Ai-bot does not exist, clone first:
REM    cd C:\Users\shawa
REM    git clone https://github.com/paraflix246-pixel/Ai-bot.git
REM    cd Ai-bot
REM    .\setup_windows.bat
REM    .\start_mnq_live.bat
REM ============================================================

title AI Trading Bot - MNQ LIVE

cd /d "%~dp0"

set PYTHONUNBUFFERED=1

if not exist logs mkdir logs

if exist "venv\Scripts\python.exe" (
    set "PY=venv\Scripts\python.exe"
) else (
    set "PY=python"
)

echo.
echo ====================================
echo   MNQ Live - Starting...
echo ====================================
echo.
echo Project: %cd%
echo Python:  %PY%
echo.
echo This places REAL orders on MNQ. Press Ctrl+C to stop.
echo.

"%PY%" -u start_live_rithmic.py --symbol MNQ %*

if errorlevel 1 (
    echo.
    echo [ERROR] Bot exited with an error.
    echo Make sure you ran this from the Ai-bot folder and that
    echo .env has RITHMIC_USER_ID, RITHMIC_PASSWORD, RITHMIC_SYSTEM.
    echo.
    pause
)
