#!/usr/bin/env python3
"""
Comprehensive variable renaming for Lua scripts.
Renames ALL short variables including local vars, function params, table keys, and function names.
"""

import os
import re
from pathlib import Path
from collections import defaultdict

# Roblox service mappings
SERVICE_PATTERNS = {
    r'game:GetService\("Players"\)': 'Players',
    r'game:GetService\("TweenService"\)': 'TweenService',
    r'game:GetService\("UserInputService"\)': 'UserInputService',
    r'game:GetService\("RunService"\)': 'RunService',
    r'game:GetService\("Workspace"\)': 'Workspace',
    r'game:GetService\("ReplicatedStorage"\)': 'ReplicatedStorage',
    r'game:GetService\("HttpService"\)': 'HttpService',
    r'game:GetService\("TextChatService"\)': 'TextChatService',
    r'game:GetService\("Chat"\)': 'Chat',
    r'game:GetService\("CoreGui"\)': 'CoreGui',
    r'game\.Players': 'Players',
    r'game\.Workspace': 'Workspace',
}

# Common patterns for variable identification
COMMON_PATTERNS = {
    'LocalPlayer': 'localPlayer',
    'PlayerGui': 'playerGui',
    'Character': 'character',
    'Humanoid': 'humanoid',
    'Animator': 'animator',
    'HumanoidRootPart': 'rootPart',
    'ScreenGui': 'screenGui',
    'Frame': 'frame',
    'TextLabel': 'textLabel',
    'TextButton': 'button',
    'TextBox': 'textBox',
    'ScrollingFrame': 'scrollFrame',
    'UICorner': 'corner',
    'UIListLayout': 'listLayout',
    'UIPadding': 'padding',
    'Animation': 'animation',
    'TweenInfo': 'tweenInfo',
}

class VariableAnalyzer:
    def __init__(self, code):
        self.code = code
        self.renamings = {}
        self.name_counts = defaultdict(int)  # Track name usage for uniqueness
        self.reserved = {'i', 'j', 'k', 'v', 'x', 'y', 'z', '_', 'if', 'then', 'else', 'elseif',
                        'end', 'for', 'while', 'do', 'local', 'function', 'return', 'and', 'or',
                        'not', 'true', 'false', 'nil', 'table', 'string', 'math', 'pairs', 'ipairs',
                        'next', 'pcall', 'print', 'type', 'tonumber', 'tostring', 'select'}

    def analyze_assignment(self, var_name, assignment):
        """Analyze what a variable is assigned to."""
        assignment = assignment.strip()

        # Check for services
        for pattern, name in SERVICE_PATTERNS.items():
            if re.search(pattern, assignment):
                return name.lower() if name != name.lower() else name

        # Check for common Roblox patterns
        for pattern, name in COMMON_PATTERNS.items():
            if pattern in assignment:
                return name

        # Check for Instance.new
        instance_match = re.search(r'Instance\.new\("(\w+)"\)', assignment)
        if instance_match:
            instance_type = instance_match.group(1)
            type_map = {
                'ScreenGui': 'screenGui',
                'Frame': 'frame',
                'TextLabel': 'label',
                'TextButton': 'button',
                'TextBox': 'textBox',
                'ScrollingFrame': 'scrollFrame',
                'UICorner': 'corner',
                'UIListLayout': 'listLayout',
                'UIPadding': 'padding',
                'Animation': 'animation',
            }
            return type_map.get(instance_type, instance_type.lower())

        # Check for boolean
        if assignment in ['true', 'false']:
            return 'flag'

        # Check for numbers
        if re.match(r'^-?\d+\.?\d*$', assignment):
            return 'value'

        # Check for table constructor
        if assignment.startswith('{'):
            return 'config'  # Use 'config' or 'state' instead of reserved 'table'

        # Check for function
        if assignment.startswith('function'):
            return 'func'

        return None

    def make_unique_name(self, base_name):
        """Ensure name is unique by adding numbers if needed."""
        if base_name in self.reserved:
            base_name = base_name + 'Var'

        # Check if this name has been used
        if base_name not in self.name_counts:
            self.name_counts[base_name] = 1
            return base_name

        # Add number suffix to make unique
        self.name_counts[base_name] += 1
        count = self.name_counts[base_name]
        return f"{base_name}{count}"

    def find_local_variables(self):
        """Find all local variable declarations."""
        pattern = r'\blocal\s+([a-zA-Z_][a-zA-Z0-9_]*)\s*=\s*([^\n]+)'
        for match in re.finditer(pattern, self.code):
            var_name = match.group(1)
            assignment = match.group(2)

            # Skip if already renamed or reserved
            if var_name in self.reserved or len(var_name) > 3:
                continue

            suggested = self.analyze_assignment(var_name, assignment)
            if suggested:
                unique_name = self.make_unique_name(suggested)
                self.renamings[var_name] = unique_name

    def find_function_params(self):
        """Find function parameters and rename based on common patterns."""
        # Match function declarations with parameters
        pattern = r'function\s+\w*\s*\(([^)]+)\)'

        for match in re.finditer(pattern, self.code):
            params = match.group(1).strip()
            if not params:
                continue

            # Split by comma
            param_list = [p.strip() for p in params.split(',')]

            for param in param_list:
                if len(param) <= 3 and param not in self.reserved and param not in self.renamings:
                    # Try to infer from usage
                    suggested = self.infer_param_name(param, match.end())
                    if suggested:
                        unique_name = self.make_unique_name(suggested)
                        self.renamings[param] = unique_name

    def infer_param_name(self, param, start_pos):
        """Infer parameter name from its usage."""
        # Look ahead to see how it's used
        search_text = self.code[start_pos:start_pos+500]

        # Common parameter patterns
        if re.search(rf'\b{param}\.UserInputType', search_text):
            return 'input'
        if re.search(rf'\b{param}\.Position', search_text):
            return 'position'
        if re.search(rf'\b{param}\.Text\b', search_text):
            return 'text'
        if re.search(rf'if\s+{param}\s+then', search_text):
            return 'enabled'

        # Generic names based on common patterns
        param_map = {
            'ms': 'message',
            'tx': 'text',
            'en': 'enterPressed',
            'inp': 'input',
            'ch': 'child',
            'ph': 'phrase',
            'wd': 'word',
            'rp': 'replacement',
            'dt': 'data',
            'ok': 'success',
            'rs': 'result',
            'fn': 'finalMessage',
            'nw': 'newWord',
        }

        return param_map.get(param)

    def find_local_functions(self):
        """Find and rename local function declarations."""
        pattern = r'\blocal\s+function\s+([a-z]{1,3})\s*\('

        for match in re.finditer(pattern, self.code):
            func_name = match.group(1)

            if func_name in self.reserved or func_name in self.renamings:
                continue

            # Common function name patterns
            func_map = {
                'gb': 'getTextBox',
                'sd': 'sendMessage',
                'it': 'isTagged',
                'hn': 'handleMessage',
                'lf': 'loadFromFile',
                'sv': 'saveToFile',
                'up': 'updateDisplay',
            }

            suggested = func_map.get(func_name)
            if suggested:
                unique_name = self.make_unique_name(suggested)
                self.renamings[func_name] = unique_name

    def find_table_keys(self):
        """Find short table keys in table constructors."""
        # This is tricky because we need to be careful not to break table keys
        # For now, we'll skip this as it requires more sophisticated parsing
        pass

    def analyze(self):
        """Run all analysis passes."""
        self.find_local_variables()
        self.find_function_params()
        self.find_local_functions()
        return self.renamings

def apply_renamings(code, renamings):
    """Apply variable renamings with word boundary protection."""
    for old_name, new_name in sorted(renamings.items(), key=lambda x: len(x[0]), reverse=True):
        # Use word boundary to avoid partial matches
        pattern = rf'\b{re.escape(old_name)}\b'
        code = re.sub(pattern, new_name, code)

    return code

def add_spacing(code):
    """Add proper spacing around operators."""
    # Add spaces around operators (simplified - doesn't handle strings)
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
        print(f"  [ERROR] Reading file: {e}")
        return False

    # Analyze and find renamings
    analyzer = VariableAnalyzer(code)
    renamings = analyzer.analyze()

    if not renamings:
        print(f"  No variables to rename")
        return False

    print(f"  Found {len(renamings)} variables to rename:")
    for old, new in sorted(renamings.items()):
        print(f"    {old} -> {new}")

    # Apply renamings
    new_code = apply_renamings(code, renamings)

    # Add spacing
    new_code = add_spacing(new_code)

    # Write back
    try:
        with open(file_path, 'w', encoding='utf-8') as f:
            f.write(new_code)
        print(f"  [OK] Successfully processed")
        return True
    except Exception as e:
        print(f"  [ERROR] Writing file: {e}")
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
