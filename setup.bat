
@echo off
title Music Visualizer Setup

echo Installing Poetry dependencies...

where poetry >nul 2>nul
if errorlevel 1 (
    echo Poetry is not installed.
    echo Install it from https://python-poetry.org/docs/#installation
    pause
    exit /b 1
)

poetry install

if errorlevel 1 (
    echo Installation failed.
    pause
    exit /b 1
)

echo Setup complete!
pause
