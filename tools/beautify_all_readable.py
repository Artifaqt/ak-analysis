#!/usr/bin/env python3
"""
Beautify and rename variables in all readable Lua scripts.
This script analyzes context and renames minified variables to meaningful names.
"""

import os
import re
from pathlib import Path

# Common Roblox service name mappings
SERVICE_MAPPINGS = {
    'game:GetService("Players")': 'Players',
    'game:GetService("TweenService")': 'TweenService',
    'game:GetService("UserInputService")': 'UserInputService',
    'game:GetService("RunService")': 'RunService',
    'game:GetService("Workspace")': 'Workspace',
    'game:GetService("ReplicatedStorage")': 'ReplicatedStorage',
    'game:GetService("HttpService")': 'HttpService',
    'game:GetService("TextChatService")': 'TextChatService',
    'game.Players': 'Players',
    'game.Workspace': 'Workspace',
    'game:GetService\\("Players"\\)': 'Players',
}

# Common property/method name patterns
PROPERTY_PATTERNS = {
    '.LocalPlayer': 'localPlayer',
    ':WaitForChild("PlayerGui")': 'playerGui',
    ':WaitForChild("Humanoid")': 'humanoid',
    ':WaitForChild("Animator")': 'animator',
    '.Character': 'character',
    '.Parent': 'parent',
    '.Name': 'name',
    ':FindFirstChild': 'child',
    'Instance.new("ScreenGui")': 'screenGui',
    'Instance.new("Frame")': 'frame',
    'Instance.new("TextLabel")': 'label',
    'Instance.new("TextButton")': 'button',
    'Instance.new("UICorner")': 'corner',
    'Instance.new("Animation")': 'animation',
}

def analyze_variable_context(code, var_name):
    """Analyze the context where a variable is defined to infer its purpose."""

    # Find the line where the variable is first assigned
    pattern = rf'\b{re.escape(var_name)}\s*=\s*(.+?)(?:\n|$)'
    match = re.search(pattern, code)

    if not match:
        return None

    assignment = match.group(1).strip()

    # Check for service assignments
    if 'game:GetService("Players")' in assignment or 'game.Players' in assignment:
        return 'players'
    if 'game:GetService("TweenService")' in assignment:
        return 'tweenService'
    if 'game:GetService("UserInputService")' in assignment:
        return 'userInputService'
    if 'game:GetService("RunService")' in assignment:
        return 'runService'
    if 'game:GetService("Workspace")' in assignment or 'game.Workspace' in assignment:
        return 'workspace'
    if 'game:GetService("ReplicatedStorage")' in assignment:
        return 'replicatedStorage'
    if 'game:GetService("HttpService")' in assignment:
        return 'httpService'
    if 'game:GetService("TextChatService")' in assignment:
        return 'textChatService'

    # Check for player-related assignments
    if '.LocalPlayer' in assignment:
        return 'localPlayer'
    if 'PlayerGui' in assignment:
        return 'playerGui'
    if 'Character' in assignment:
        return 'character'
    if 'Humanoid' in assignment:
        return 'humanoid'
    if 'Animator' in assignment:
        return 'animator'
    if 'HumanoidRootPart' in assignment:
        return 'rootPart'

    # Check for GUI elements
    if 'Instance.new("ScreenGui")' in assignment:
        return 'screenGui'
    if 'Instance.new("Frame")' in assignment:
        if 'Main' in code[:match.start()]:
            return 'mainFrame'
        if 'Content' in code[:match.start()]:
            return 'contentFrame'
        if 'Title' in code[:match.start()]:
            return 'titleBar'
        return 'frame'
    if 'Instance.new("TextLabel")' in assignment:
        return 'textLabel'
    if 'Instance.new("TextButton")' in assignment:
        return 'button'
    if 'Instance.new("UICorner")' in assignment:
        return 'corner'
    if 'Instance.new("Animation")' in assignment:
        return 'animation'

    # Check for track/animation
    if 'LoadAnimation' in assignment:
        return 'track'

    # Check for boolean flags
    if assignment in ['true', 'false']:
        return 'flag'

    # Check for numeric values
    if assignment.replace('.', '').replace('-', '').isdigit():
        return 'value'

    return None

def find_minified_variables(code):
    """Find all minified variable names (1-3 letters) in the code."""
    # Pattern to find local variable declarations
    pattern = r'\blocal\s+([a-z]{1,3})\s*='
    matches = re.finditer(pattern, code)

    minified_vars = {}
    for match in matches:
        var_name = match.group(1)
        # Skip common Lua variables
        if var_name in ['i', 'j', 'k', 'v', 'x', 'y', 'z']:
            continue

        suggested_name = analyze_variable_context(code, var_name)
        if suggested_name:
            minified_vars[var_name] = suggested_name

    return minified_vars

def rename_variables(code, renamings):
    """Apply variable renamings with word boundary protection."""
    for old_name, new_name in renamings.items():
        # Use word boundary to avoid partial matches
        pattern = rf'\b{re.escape(old_name)}\b'
        code = re.sub(pattern, new_name, code)

    return code

def add_spacing(code):
    """Add proper spacing around operators and keywords."""

    # Add spaces around operators (but not in strings)
    # This is a simplified version - a full implementation would need string detection
    code = re.sub(r'([a-zA-Z0-9_])=([a-zA-Z0-9_])', r'\1 = \2', code)
    code = re.sub(r'([a-zA-Z0-9_])==([a-zA-Z0-9_])', r'\1 == \2', code)
    code = re.sub(r'([a-zA-Z0-9_])~=([a-zA-Z0-9_])', r'\1 ~= \2', code)
    code = re.sub(r'([a-zA-Z0-9_])\+([a-zA-Z0-9_])', r'\1 + \2', code)
    code = re.sub(r'([a-zA-Z0-9_])-([a-zA-Z0-9_])', r'\1 - \2', code)

    return code

def process_file(file_path):
    """Process a single Lua file."""
    print(f"Processing: {file_path.name}")

    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            code = f.read()
    except Exception as e:
        print(f"  Error reading file: {e}")
        return False

    # Find minified variables
    renamings = find_minified_variables(code)

    if not renamings:
        print(f"  No minified variables found")
        return False

    print(f"  Found {len(renamings)} variables to rename:")
    for old, new in sorted(renamings.items()):
        print(f"    {old} -> {new}")

    # Apply renamings
    new_code = rename_variables(code, renamings)

    # Add spacing
    new_code = add_spacing(new_code)

    # Write back
    try:
        with open(file_path, 'w', encoding='utf-8') as f:
            f.write(new_code)
        print(f"  [OK] Successfully processed")
        return True
    except Exception as e:
        print(f"  [ERROR] Error writing file: {e}")
        return False

def main():
    """Process all readable Lua scripts."""

    # Get the readable scripts directory
    script_dir = Path(__file__).parent.parent / 'downloaded_commands' / 'readable'

    if not script_dir.exists():
        print(f"Error: Directory not found: {script_dir}")
        return

    print(f"Processing all Lua files in: {script_dir}")
    print("=" * 60)

    # Get all .lua files
    lua_files = list(script_dir.glob('*.lua'))

    if not lua_files:
        print("No Lua files found")
        return

    print(f"Found {len(lua_files)} Lua files\n")

    # Skip files that have already been manually processed
    skip_files = {'animhub.lua', 'sfly.lua', 'jerk.lua'}

    processed = 0
    skipped = 0

    for lua_file in sorted(lua_files):
        if lua_file.name in skip_files:
            print(f"Skipping (manually processed): {lua_file.name}")
            skipped += 1
            continue

        if process_file(lua_file):
            processed += 1

        print()

    print("=" * 60)
    print(f"Summary:")
    print(f"  Total files: {len(lua_files)}")
    print(f"  Processed: {processed}")
    print(f"  Skipped: {skipped}")
    print(f"  Unchanged: {len(lua_files) - processed - skipped}")

if __name__ == '__main__':
    main()
