#!/usr/bin/env python3
"""
Combine Luraph bypass with Luraph-protected scripts.
This prepends the bypass code to the Luraph script.
"""

import sys
from pathlib import Path

def combine_bypass_with_script(bypass_path, luraph_script_path, output_path):
    """Combine bypass with Luraph script."""

    # Read bypass
    print(f"Reading bypass: {bypass_path}")
    with open(bypass_path, 'r', encoding='utf-8') as f:
        bypass_code = f.read()

    # Read Luraph script
    print(f"Reading Luraph script: {luraph_script_path}")
    with open(luraph_script_path, 'r', encoding='utf-8') as f:
        luraph_code = f.read()

    # Combine
    print(f"Combining...")
    combined = bypass_code + "\n\n-- === LURAPH SCRIPT STARTS HERE ===\n\n" + luraph_code

    # Write output
    print(f"Writing combined script: {output_path}")
    with open(output_path, 'w', encoding='utf-8') as f:
        f.write(combined)

    print(f"[OK] Combined script created successfully!")
    print(f"[INFO] Size: {len(combined)} bytes")
    print(f"[INFO] Bypass: {len(bypass_code)} bytes")
    print(f"[INFO] Luraph: {len(luraph_code)} bytes")

def main():
    if len(sys.argv) != 4:
        print("Usage: python combine_bypass.py <bypass.lua> <luraph_script.lua> <output.lua>")
        print()
        print("Example:")
        print("  python combine_bypass.py luraph_bypass_simplified.lua flip.lua flip_bypassed.lua")
        print()
        print("Bypass options:")
        print("  - luraph_bypass_simplified.lua (recommended)")
        print("  - luraph_bypass_no_increment.lua")
        print("  - luraph_bypass_recursion_limit.lua")
        sys.exit(1)

    bypass_path = Path(sys.argv[1])
    luraph_path = Path(sys.argv[2])
    output_path = Path(sys.argv[3])

    # Verify files exist
    if not bypass_path.exists():
        print(f"[ERROR] Bypass file not found: {bypass_path}")
        sys.exit(1)

    if not luraph_path.exists():
        print(f"[ERROR] Luraph script not found: {luraph_path}")
        sys.exit(1)

    # Combine
    combine_bypass_with_script(bypass_path, luraph_path, output_path)

if __name__ == "__main__":
    main()
