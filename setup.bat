
@echo off
setlocal DisableDelayedExpansion
title Music Visualizer Setup

echo ========================================
echo        MUSIC VISUALIZER SETUP
echo ========================================
echo.

where python >nul 2>nul
if not errorlevel 1 goto python_found

echo Python is not installed or not on PATH.
echo Install Python from:
echo https://www.python.org/downloads/
echo.
pause
exit /b 1

:python_found
echo Python found.
echo.

where poetry >nul 2>nul
if not errorlevel 1 goto poetry_found

echo Poetry was not found. Installing Poetry...
echo.

powershell -NoProfile -ExecutionPolicy Bypass -Command "Invoke-WebRequest 'https://install.python-poetry.org' -OutFile '%TEMP%\install-poetry.py'; if ($?) { python '%TEMP%\install-poetry.py' }; Remove-Item '%TEMP%\install-poetry.py' -ErrorAction SilentlyContinue"

if errorlevel 1 goto poetry_failed

set "PATH=%APPDATA%\Python\Scripts;%USERPROFILE%\.local\bin;%USERPROFILE%\AppData\Roaming\Python\Scripts;%PATH%"

where poetry >nul 2>nul
if not errorlevel 1 goto poetry_found

if exist "%APPDATA%\Python\Scripts\poetry.exe" (
    set "POETRY_EXE=%APPDATA%\Python\Scripts\poetry.exe"
    goto poetry_path_found
)

if exist "%USERPROFILE%\.local\bin\poetry.exe" (
    set "POETRY_EXE=%USERPROFILE%\.local\bin\poetry.exe"
    goto poetry_path_found
)

goto poetry_failed

:poetry_path_found
echo Poetry installed.
echo.
goto install_dependencies

:poetry_found
echo Poetry found.
echo.

:install_dependencies
if not exist "pyproject.toml" goto missing_project

echo Installing project dependencies...
echo.

if defined POETRY_EXE (
    "%POETRY_EXE%" install
) else (
    poetry install
)

if errorlevel 1 goto install_failed

echo.
echo ========================================
echo          SETUP COMPLETE!
echo ========================================
echo.
echo To launch your music visualizer, run:
echo poetry run python main.py
echo.
pause
exit /b 0

:poetry_failed
echo.
echo ERROR: Poetry installation failed or Poetry could not be found.
echo Install it manually from:
echo https://python-poetry.org/docs/#installation
echo.
pause
exit /b 1

:missing_project
echo ERROR: pyproject.toml was not found.
echo Place this setup.bat in your project folder.
echo.
pause
exit /b 1

:install_failed
echo.
echo ERROR: Dependency installation failed.
echo Check your pyproject.toml and poetry.lock.
echo.
pause
exit /b 1
