@echo off
REM Publishing script for wallet-tracking package
echo ========================================
echo Publishing wallet-tracking to PyPI
echo ========================================
echo.

REM Step 1: Clean previous builds
echo [1/5] Cleaning previous builds...
if exist dist rmdir /s /q dist
if exist build rmdir /s /q build
if exist *.egg-info rmdir /s /q *.egg-info
echo Done.
echo.

REM Step 2: Install build tools
echo [2/5] Installing build tools...
pip install build twine --upgrade
echo Done.
echo.

REM Step 3: Build package
echo [3/5] Building package...
python -m build
if errorlevel 1 (
    echo ERROR: Build failed!
    pause
    exit /b 1
)
echo Done.
echo.

REM Step 4: Check package
echo [4/5] Checking package...
python -m twine check dist/*
if errorlevel 1 (
    echo ERROR: Package check failed!
    pause
    exit /b 1
)
echo Done.
echo.

REM Step 5: Upload to PyPI
echo [5/5] Uploading to PyPI...
echo.
echo Choose upload destination:
echo 1. TestPyPI (for testing)
echo 2. PyPI (production)
set /p choice="Enter choice (1 or 2): "

if "%choice%"=="1" (
    echo Uploading to TestPyPI...
    python -m twine upload --repository testpypi dist/*
) else if "%choice%"=="2" (
    echo Uploading to PyPI...
    python -m twine upload dist/*
) else (
    echo Invalid choice!
    pause
    exit /b 1
)

if errorlevel 1 (
    echo ERROR: Upload failed!
    pause
    exit /b 1
)

echo.
echo ========================================
echo SUCCESS! Package published!
echo ========================================
echo.
echo Test installation with:
echo pip install wallet-tracking
echo.
pause

