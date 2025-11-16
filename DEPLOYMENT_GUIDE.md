# Deployment Guide - Publishing to PyPI

This guide will walk you through deploying the `wallet-tracking` package to PyPI (Python Package Index) step by step.

## Prerequisites

Before you begin, you need:

1. **PyPI Account**: Create an account at [https://pypi.org/account/register/](https://pypi.org/account/register/)
2. **TestPyPI Account**: Create a test account at [https://test.pypi.org/account/register/](https://test.pypi.org/account/register/)
3. **API Token**: Generate an API token for authentication (recommended over password)

---

## Step 1: Create PyPI Accounts

### 1.1 Create Production PyPI Account
1. Go to [https://pypi.org/account/register/](https://pypi.org/account/register/)
2. Fill in your username, password, and email
3. Verify your email address
4. Log in to your account

### 1.2 Create TestPyPI Account
1. Go to [https://test.pypi.org/account/register/](https://test.pypi.org/account/register/)
2. Create a separate account (can use same email)
3. Verify your email address

---

## Step 2: Generate API Token (Recommended)

Using an API token is more secure than using your password.

### 2.1 Generate Token for PyPI
1. Log in to [https://pypi.org](https://pypi.org)
2. Go to **Account settings** → **API tokens**
3. Click **Add API token**
4. Give it a name (e.g., "wallet-tracking-package")
5. Set scope to **Entire account** (or specific project)
6. Click **Add token**
7. **IMPORTANT**: Copy the token immediately (format: `pypi-...`). You won't see it again!

### 2.2 Generate Token for TestPyPI
1. Log in to [https://test.pypi.org](https://test.pypi.org)
2. Follow the same steps as above
3. Copy the TestPyPI token

---

## Step 3: Configure Authentication

You have two options for authentication:

### Option A: Using API Token (Recommended)

Create a `.pypirc` file in your home directory:

**Windows**: `C:\Users\YourUsername\.pypirc`
**Linux/Mac**: `~/.pypirc`

```ini
[distutils]
index-servers =
    pypi
    testpypi

[pypi]
username = __token__
password = pypi-YOUR_ACTUAL_TOKEN_HERE

[testpypi]
repository = https://test.pypi.org/legacy/
username = __token__
password = pypi-YOUR_TESTPYPI_TOKEN_HERE
```

Replace `YOUR_ACTUAL_TOKEN_HERE` and `YOUR_TESTPYPI_TOKEN_HERE` with your actual tokens.

### Option B: Using Environment Variables

Set these in your terminal:

**Windows (PowerShell):**
```powershell
$env:TWINE_USERNAME = "__token__"
$env:TWINE_PASSWORD = "pypi-YOUR_ACTUAL_TOKEN_HERE"
```

**Windows (CMD):**
```cmd
set TWINE_USERNAME=__token__
set TWINE_PASSWORD=pypi-YOUR_ACTUAL_TOKEN_HERE
```

**Linux/Mac:**
```bash
export TWINE_USERNAME="__token__"
export TWINE_PASSWORD="pypi-YOUR_ACTUAL_TOKEN_HERE"
```

---

## Step 4: Prepare Your Package

### 4.1 Update Version Number (if needed)

Edit `setup.py` and update the version:
```python
version="1.0.3",  # Increment version for each release
```

### 4.2 Verify Package Information

Check that `setup.py` has correct:
- Package name
- Version number
- Description
- Author information
- Dependencies

### 4.3 Clean Previous Builds

Delete old build artifacts:
```bash
# Windows
rmdir /s /q dist build *.egg-info

# Linux/Mac
rm -rf dist build *.egg-info
```

---

## Step 5: Install Build Tools

Install required tools for building and uploading:

```bash
pip install build twine --upgrade
```

---

## Step 6: Build the Package

Build both source distribution and wheel:

```bash
python -m build
```

This creates:
- `dist/wallet_tracking-X.X.X.tar.gz` (source distribution)
- `dist/wallet_tracking-X.X.X-py3-none-any.whl` (wheel)

---

## Step 7: Check the Package

Before uploading, verify the package is valid:

```bash
python -m twine check dist/*
```

Fix any errors before proceeding.

---

## Step 8: Test on TestPyPI (Recommended)

Always test on TestPyPI first to catch issues:

### 8.1 Upload to TestPyPI

```bash
python -m twine upload --repository testpypi dist/*
```

If using environment variables for TestPyPI:
```bash
# Set TestPyPI credentials
$env:TWINE_USERNAME = "__token__"
$env:TWINE_PASSWORD = "pypi-YOUR_TESTPYPI_TOKEN_HERE"
python -m twine upload --repository testpypi dist/*
```

### 8.2 Test Installation from TestPyPI

```bash
pip install --index-url https://test.pypi.org/simple/ wallet-tracking
```

Or install with dependencies:
```bash
pip install --index-url https://test.pypi.org/simple/ --extra-index-url https://pypi.org/simple/ wallet-tracking
```

### 8.3 Verify It Works

```python
from wallet_tracking import WalletTracker
tracker = WalletTracker()
tracker.test_connection()
```

If everything works, proceed to production PyPI.

---

## Step 9: Publish to Production PyPI

Once tested on TestPyPI, publish to production:

### 9.1 Upload to PyPI

```bash
python -m twine upload dist/*
```

You'll be prompted for credentials (or use your configured token).

### 9.2 Verify Upload

1. Go to [https://pypi.org/project/wallet-tracking/](https://pypi.org/project/wallet-tracking/)
2. Check that your package appears with the correct version

---

## Step 10: Test Installation from PyPI

Test that others can install your package:

```bash
# Uninstall local version first
pip uninstall wallet-tracking -y

# Install from PyPI
pip install wallet-tracking

# Verify it works
python -c "from wallet_tracking import WalletTracker; print('Success!')"
```

---

## Step 11: Update README (Optional)

Update your README.md to include PyPI installation instructions:

```markdown
### Install from PyPI

```bash
pip install wallet-tracking
```
```

---

## Quick Reference: Using the Batch Script

If you're on Windows, you can use the provided `publish.bat` script:

1. Make sure you have `.pypirc` configured or environment variables set
2. Run:
   ```cmd
   publish.bat
   ```
3. Follow the prompts

---

## Troubleshooting

### Error: "HTTPError: 400 Bad Request"
- Package name might already exist (PyPI doesn't allow overwriting)
- Increment version number in `setup.py`

### Error: "HTTPError: 403 Forbidden"
- Check your API token is correct
- Ensure token has proper permissions
- Verify username is `__token__` (with underscores)

### Error: "Package already exists"
- You can't overwrite existing versions
- Always increment version number for new releases

### Error: "Invalid distribution"
- Run `python -m twine check dist/*` to see specific errors
- Check `setup.py` for syntax errors

---

## Best Practices

1. **Always test on TestPyPI first** before production
2. **Increment version** for each release (use semantic versioning: MAJOR.MINOR.PATCH)
3. **Use API tokens** instead of passwords
4. **Keep `.pypirc` secure** - don't commit it to git
5. **Add `.pypirc` to `.gitignore`** to avoid accidental commits
6. **Test installation** after publishing
7. **Update README** with installation instructions

---

## Next Steps After Deployment

1. Share your package: `pip install wallet-tracking`
2. Monitor downloads on PyPI
3. Handle user issues and feedback
4. Plan next version updates

---

## Summary Checklist

- [ ] Created PyPI account
- [ ] Created TestPyPI account
- [ ] Generated API tokens
- [ ] Configured authentication (.pypirc or environment variables)
- [ ] Updated version in setup.py
- [ ] Cleaned previous builds
- [ ] Installed build tools (build, twine)
- [ ] Built package (`python -m build`)
- [ ] Checked package (`python -m twine check dist/*`)
- [ ] Tested on TestPyPI
- [ ] Verified TestPyPI installation works
- [ ] Published to production PyPI
- [ ] Verified PyPI installation works
- [ ] Updated README with installation instructions

---

**Congratulations! Your package is now live on PyPI! 🎉**

