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
set ASSET_CLASS=futures
set BROKER_TYPE=rithmic
set TRADING_PAIRS=MNQ
set TF_ENABLE_ONEDNN_OPTS=0
set TF_CPP_MIN_LOG_LEVEL=2

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
if not exist ".env" (
    echo [ERROR] No .env file. Run setup_windows.bat first, then fill Rithmic fields.
    pause
    exit /b 1
)

findstr /r /c:"^RITHMIC_USER_ID=." .env >nul
if errorlevel 1 (
    echo [ERROR] RITHMIC_USER_ID is empty in .env
    echo         Open .env and set RITHMIC_USER_ID, RITHMIC_PASSWORD, RITHMIC_SYSTEM.
    echo         Example: RITHMIC_SYSTEM=LucidTrading
    echo.
    notepad .env
    pause
    exit /b 1
)

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
