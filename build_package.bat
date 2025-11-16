@echo off
echo Building Wallet Tracking Package...
echo.

REM Install build tools if not already installed
pip install build wheel --quiet

REM Build the package
python -m build

echo.
echo Build complete! Files are in the dist/ directory.
echo.
echo To install, run:
echo   pip install dist\wallet_tracking-1.0.0-py3-none-any.whl
echo.
pause

