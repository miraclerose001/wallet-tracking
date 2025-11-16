# Fixing 403 Forbidden Authentication Error

## Quick Fix Steps

### Step 1: Get Your TestPyPI API Token

1. Go to: https://test.pypi.org/manage/account/token/
2. Log in to your TestPyPI account
3. Click **"Add API token"**
4. Name it (e.g., "wallet-tracking")
5. Set scope to **"Entire account"** or **"wallet-tracking"** project
6. Click **"Add token"**
7. **COPY THE TOKEN** - it starts with `pypi-` (e.g., `pypi-AgEIcHJ...`)

### Step 2: Use the Setup Script (Easiest)

Run the PowerShell script:
```powershell
.\setup_auth.ps1
```

Follow the prompts and enter your token when asked.

### Step 3: Upload Again

After setting credentials, try uploading:
```powershell
python -m twine upload --repository testpypi dist/*
```

---

## Alternative: Manual Setup

### Option A: Environment Variables (Current Session Only)

**PowerShell:**
```powershell
$env:TWINE_USERNAME = "__token__"
$env:TWINE_PASSWORD = "pypi-YOUR_ACTUAL_TESTPYPI_TOKEN_HERE"
```

**Then upload:**
```powershell
python -m twine upload --repository testpypi dist/*
```

### Option B: .pypirc File (Permanent)

Create file: `C:\Users\YourUsername\.pypirc`

```ini
[distutils]
index-servers =
    pypi
    testpypi

[pypi]
username = __token__
password = pypi-YOUR_PRODUCTION_TOKEN_HERE

[testpypi]
repository = https://test.pypi.org/legacy/
username = __token__
password = pypi-YOUR_TESTPYPI_TOKEN_HERE
```

**Important Notes:**
- Replace `YOUR_TESTPYPI_TOKEN_HERE` with your actual TestPyPI token
- Replace `YOUR_PRODUCTION_TOKEN_HERE` with your actual PyPI token
- Username must be exactly `__token__` (with two underscores on each side)
- Token must start with `pypi-`

---

## Common Mistakes

❌ **Wrong token**: Using PyPI token for TestPyPI (they're different!)
❌ **Wrong username**: Using your actual username instead of `__token__`
❌ **Token format**: Not including the `pypi-` prefix
❌ **Expired token**: Token was deleted or expired
❌ **Wrong scope**: Token doesn't have permission for the project

---

## Verify Your Token

1. Token should look like: `pypi-AgEIcHJ...` (long string)
2. Username should be: `__token__` (exactly)
3. For TestPyPI, use TestPyPI token (different from PyPI token)

---

## Still Having Issues?

1. **Generate a new token** - old one might be invalid
2. **Check token scope** - make sure it has project permissions
3. **Verify account** - make sure you're logged into the correct TestPyPI account
4. **Try verbose mode**:
   ```powershell
   python -m twine upload --repository testpypi dist/* --verbose
   ```

