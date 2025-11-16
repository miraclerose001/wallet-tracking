# PowerShell script to set up PyPI authentication
# This sets environment variables for twine

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "PyPI Authentication Setup" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

Write-Host "Choose which repository to configure:" -ForegroundColor Yellow
Write-Host "1. TestPyPI (for testing)"
Write-Host "2. Production PyPI"
Write-Host "3. Both"
Write-Host ""
$choice = Read-Host "Enter choice (1, 2, or 3)"

if ($choice -eq "1" -or $choice -eq "3") {
    Write-Host ""
    Write-Host "TestPyPI Configuration:" -ForegroundColor Green
    Write-Host "Your TestPyPI API token should start with 'pypi-'" -ForegroundColor Yellow
    Write-Host "Get it from: https://test.pypi.org/manage/account/token/" -ForegroundColor Yellow
    $testToken = Read-Host "Enter your TestPyPI API token (pypi-...)"
    
    if ($testToken -notmatch "^pypi-") {
        Write-Host "WARNING: Token should start with 'pypi-'" -ForegroundColor Red
    }
    
    $env:TWINE_USERNAME = "__token__"
    $env:TWINE_PASSWORD = $testToken
    Write-Host "TestPyPI credentials set!" -ForegroundColor Green
    Write-Host ""
}

if ($choice -eq "2" -or $choice -eq "3") {
    Write-Host ""
    Write-Host "Production PyPI Configuration:" -ForegroundColor Green
    Write-Host "Your PyPI API token should start with 'pypi-'" -ForegroundColor Yellow
    Write-Host "Get it from: https://pypi.org/manage/account/token/" -ForegroundColor Yellow
    $prodToken = Read-Host "Enter your PyPI API token (pypi-...)"
    
    if ($prodToken -notmatch "^pypi-") {
        Write-Host "WARNING: Token should start with 'pypi-'" -ForegroundColor Red
    }
    
    if ($choice -eq "2") {
        $env:TWINE_USERNAME = "__token__"
        $env:TWINE_PASSWORD = $prodToken
    }
    Write-Host "Production PyPI credentials set!" -ForegroundColor Green
    Write-Host ""
}

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Authentication configured!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "NOTE: These credentials are only set for this PowerShell session." -ForegroundColor Yellow
Write-Host "To make them permanent, create a .pypirc file (see DEPLOYMENT_GUIDE.md)" -ForegroundColor Yellow
Write-Host ""
Write-Host "Now you can run:" -ForegroundColor Cyan
if ($choice -eq "1" -or $choice -eq "3") {
    Write-Host "  python -m twine upload --repository testpypi dist/*" -ForegroundColor White
}
if ($choice -eq "2" -or $choice -eq "3") {
    Write-Host "  python -m twine upload dist/*" -ForegroundColor White
}
Write-Host ""

