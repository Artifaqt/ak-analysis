#!/usr/bin/env python3
"""
Automatically combine bypass with all 18 Luraph scripts.
Creates three versions of each script (simplified, no_increment, recursion_limit).
"""

from pathlib import Path

def combine_bypass_with_script(bypass_code, luraph_script_path):
    """Combine bypass with Luraph script."""

    # Read Luraph script
    with open(luraph_script_path, 'r', encoding='utf-8') as f:
        luraph_code = f.read()

    # Combine
    combined = bypass_code + "\n\n-- === LURAPH SCRIPT STARTS HERE ===\n\n" + luraph_code

    return combined

def main():
    # Paths
    tools_dir = Path(__file__).parent
    vm_dir = tools_dir.parent / 'downloaded_commands' / 'vm_obfuscated'
    output_dir = tools_dir.parent / 'downloaded_commands' / 'luraph_bypassed'

    # Create output directory
    output_dir.mkdir(exist_ok=True)

    # Bypass files (removed simplified - triggers anti-tamper)
    bypasses = {
        'no_increment': tools_dir / 'luraph_bypass_no_increment.lua',
        'recursion_limit': tools_dir / 'luraph_bypass_recursion_limit.lua',
        'high_limit': tools_dir / 'luraph_bypass_high_limit.lua',
        'no_debuginfo': tools_dir / 'luraph_bypass_no_debuginfo.lua',
    }

    # Read all bypass codes
    bypass_codes = {}
    for name, path in bypasses.items():
        if not path.exists():
            print(f"[ERROR] Bypass not found: {path}")
            return

        with open(path, 'r', encoding='utf-8') as f:
            bypass_codes[name] = f.read()
        print(f"[OK] Loaded bypass: {name}")

    # Find all Luraph scripts
    luraph_scripts = list(vm_dir.glob('*.lua'))

    # Filter to only Luraph (check signature)
    luraph_only = []
    for script in luraph_scripts:
        with open(script, 'r', encoding='utf-8') as f:
            content = f.read(200)  # Read first 200 chars
            # Luraph signature: return(function(XX,YY,ZZ,...)
            if content.startswith('return(function('):
                luraph_only.append(script)

    print(f"\n[INFO] Found {len(luraph_only)} Luraph-protected scripts")

    # Combine each script with each bypass
    total = 0
    for script_path in luraph_only:
        script_name = script_path.stem  # filename without extension

        print(f"\nProcessing: {script_name}.lua")

        for bypass_name, bypass_code in bypass_codes.items():
            # Combine
            combined = combine_bypass_with_script(bypass_code, script_path)

            # Output filename
            output_file = output_dir / f"{script_name}_{bypass_name}.lua"

            # Write
            with open(output_file, 'w', encoding='utf-8') as f:
                f.write(combined)

            print(f"  [OK] Created: {output_file.name} ({len(combined)} bytes)")
            total += 1

    print(f"\n[SUCCESS] Created {total} bypassed scripts in:")
    print(f"  {output_dir}")
    print()
    print("Next steps:")
    print("  1. Test the _simplified versions first")
    print("  2. If anti-tamper fails, try _no_increment")
    print("  3. If stack overflow, try _recursion_limit")
    print()
    print("Example test:")
    print(f"  loadfile('{output_dir}/flip_simplified.lua')()")

if __name__ == "__main__":
    main()
