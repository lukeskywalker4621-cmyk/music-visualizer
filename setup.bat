@echo off
title Music Visualizer Setup
echo ================================
echo     Music Visualizer Setup
echo ================================

where python >nul 2>nul
if errorlevel 1 (
    echo Python is not installed or not on PATH.
    echo Install Python from https://www.python.org/downloads/
    pause
    exit /b 1
)

where poetry >nul 2>nul
if errorlevel 1 (
    echo Installing Poetry...
    python -m pip install --user poetry
    if errorlevel 1 (
        echo Failed to install Poetry.
        pause
        exit /b 1
    )
    set "PATH=%APPDATA%\Python\Scripts;%PATH%"
)

where poetry >nul 2>nul
if errorlevel 1 (
    echo Poetry was installed but is not on PATH.
    echo Restart your terminal or add Poetry to PATH.
    pause
    exit /b 1
)

echo Installing project dependencies...
poetry install
if errorlevel 1 (
    echo Dependency installation failed.
    pause
    exit /b 1
)

echo.
echo Setup complete!
pause
