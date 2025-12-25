#!/usr/bin/env python3
"""
AK Admin Command Downloader
Downloads all command scripts from the registry and sorts them by obfuscation type
"""

import re
import requests
import os
from pathlib import Path
import time

# Read the command registry file
REGISTRY_FILE = r"c:\Users\Artifaqt\Downloads\ak\payloads\actual_payload_17.lua"
OUTPUT_DIR = r"c:\Users\Artifaqt\Downloads\ak\downloaded_commands"

# Create output directories
os.makedirs(OUTPUT_DIR, exist_ok=True)
os.makedirs(os.path.join(OUTPUT_DIR, "readable"), exist_ok=True)
os.makedirs(os.path.join(OUTPUT_DIR, "vm_obfuscated"), exist_ok=True)
os.makedirs(os.path.join(OUTPUT_DIR, "other"), exist_ok=True)

def is_vm_obfuscated(code):
    """
    Detect if code is VM-obfuscated
    """
    vm_patterns = [
        r'return\s*\(\s*function\s*\(',  # Common VM pattern
        r'loadstring\s*\(',  # Nested loadstring
        r'string\.char\s*\(\s*\d+',  # String.char obfuscation
        r'MoonSec',  # MoonSec obfuscator
        r'Luraph',  # Luraph obfuscator
        r'PSU',  # PSU obfuscator
        r'VMProtect',  # VMProtect
        r'Ironbrew',  # Ironbrew
    ]

    for pattern in vm_patterns:
        if re.search(pattern, code[:1000]):  # Check first 1000 chars
            return True

    # Check for very long single lines (common in minified/obfuscated code)
    lines = code.split('\n')
    if any(len(line) > 5000 for line in lines[:10]):
        return True

    return False

def extract_urls_from_registry(registry_path):
    """
    Extract all URLs from the command registry file
    """
    with open(registry_path, 'r', encoding='utf-8') as f:
        content = f.read()

    # Pattern to match URLs in the registry
    # Looks for: ["!command"] = {"url"}
    pattern = r'\["(![\w]+)"\]\s*=\s*\{\s*"([^"]+)"\s*\}'

    matches = re.findall(pattern, content)

    commands = {}
    for command, url in matches:
        commands[command] = url

    return commands

def download_command(command, url):
    """
    Download a command script from URL
    """
    try:
        print(f"[>>] Downloading {command}...")
        response = requests.get(url, timeout=10)
        response.raise_for_status()

        code = response.text
        size = len(code)

        # Determine obfuscation type
        if is_vm_obfuscated(code):
            category = "vm_obfuscated"
            status = "[VM]"
        else:
            category = "readable"
            status = "[OK]"

        # Save to appropriate folder
        filename = f"{command.replace('!', '')}.lua"
        filepath = os.path.join(OUTPUT_DIR, category, filename)

        with open(filepath, 'w', encoding='utf-8') as f:
            f.write(code)

        print(f"    {status} {size:,} bytes -> {category}/{filename}")

        return {
            'command': command,
            'url': url,
            'size': size,
            'category': category,
            'filepath': filepath
        }

    except requests.exceptions.RequestException as e:
        print(f"    [ERROR] Failed to download: {e}")
        return None
    except Exception as e:
        print(f"    [ERROR] {e}")
        return None

def main():
    print("=" * 70)
    print("AK ADMIN COMMAND DOWNLOADER")
    print("=" * 70)
    print()

    # Extract URLs from registry
    print("[1] Reading command registry...")
    commands = extract_urls_from_registry(REGISTRY_FILE)
    print(f"    Found {len(commands)} commands")
    print()

    # Download all commands
    print("[2] Downloading command scripts...")
    results = []

    for i, (command, url) in enumerate(commands.items(), 1):
        print(f"\n[{i}/{len(commands)}] {command}")
        result = download_command(command, url)
        if result:
            results.append(result)

        # Be nice to the server
        time.sleep(0.5)

    print()
    print("=" * 70)
    print("DOWNLOAD SUMMARY")
    print("=" * 70)

    # Count by category
    readable = [r for r in results if r['category'] == 'readable']
    vm_obf = [r for r in results if r['category'] == 'vm_obfuscated']

    print(f"\nTotal Commands: {len(results)}/{len(commands)}")
    print(f"  [OK] Readable:      {len(readable)}")
    print(f"  [VM] VM Obfuscated: {len(vm_obf)}")
    print(f"  [X]  Failed:        {len(commands) - len(results)}")

    # Save summary report
    report_path = os.path.join(OUTPUT_DIR, "DOWNLOAD_REPORT.txt")
    with open(report_path, 'w', encoding='utf-8') as f:
        f.write("AK ADMIN COMMAND DOWNLOAD REPORT\n")
        f.write("=" * 70 + "\n\n")

        f.write(f"Total Commands: {len(results)}/{len(commands)}\n")
        f.write(f"  Readable:      {len(readable)}\n")
        f.write(f"  VM Obfuscated: {len(vm_obf)}\n")
        f.write(f"  Failed:        {len(commands) - len(results)}\n\n")

        f.write("=" * 70 + "\n")
        f.write("READABLE COMMANDS\n")
        f.write("=" * 70 + "\n\n")
        for r in readable:
            f.write(f"{r['command']:<20} {r['size']:>10,} bytes\n")
            f.write(f"  URL: {r['url']}\n")
            f.write(f"  File: {r['filepath']}\n\n")

        f.write("=" * 70 + "\n")
        f.write("VM-OBFUSCATED COMMANDS\n")
        f.write("=" * 70 + "\n\n")
        for r in vm_obf:
            f.write(f"{r['command']:<20} {r['size']:>10,} bytes\n")
            f.write(f"  URL: {r['url']}\n")
            f.write(f"  File: {r['filepath']}\n\n")

    print(f"\n[*] Report saved: {report_path}")
    print(f"[*] Commands saved to: {OUTPUT_DIR}")
    print("\nFolder structure:")
    print(f"  {OUTPUT_DIR}/")
    print(f"    |-- readable/        ({len(readable)} scripts)")
    print(f"    |-- vm_obfuscated/   ({len(vm_obf)} scripts)")
    print(f"    +-- DOWNLOAD_REPORT.txt")
    print()
    print("=" * 70)
    print("[DONE] DOWNLOAD COMPLETE!")
    print("=" * 70)

if __name__ == "__main__":
    main()
