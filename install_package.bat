@echo off
echo Installing Wallet Tracking Package...
echo.

REM Install the wheel
pip install dist\wallet_tracking-1.0.0-py3-none-any.whl

echo.
echo Installation complete!
echo.
echo To verify, run:
echo   python -c "from wallet_tracking import WalletTracker; print('OK')"
echo.
pause

