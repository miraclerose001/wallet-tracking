"""
Test script for Wallet Tracking package.
Run this to verify the Discord webhook connection.
"""

import sys
import io
from wallet_tracking import WalletTracker

# Fix encoding for Windows console
if sys.platform == 'win32':
    sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8')

def main():
    print("=" * 50)
    print("Wallet Tracking Package - Connection Test")
    print("=" * 50)
    print()
    
    # Initialize tracker
    print("Initializing WalletTracker...")
    tracker = WalletTracker(enabled=True)
    
    if not tracker.enabled:
        print("[X] Wallet tracking is disabled!")
        return
    
    print("[OK] WalletTracker initialized")
    print(f"[*] Webhook URL: {tracker.webhook_url[:50]}...")
    print()
    
    # Test connection
    print("Testing Discord webhook connection...")
    print("Sending test message to Discord...")
    print()
    
    if tracker.test_connection():
        print("[OK] Connection test successful!")
        print("[*] Check your Discord channel for the test message.")
    else:
        print("[X] Connection test failed!")
        print("[!] Check the webhook URL and Discord server settings.")
    
    print()
    print("=" * 50)

if __name__ == "__main__":
    main()

