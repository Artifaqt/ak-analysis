#!/usr/bin/env python3
"""
Advanced Lua Beautifier
Better formatting for minified Lua code with proper spacing and line breaks
"""

import sys
import re

def beautify_lua_advanced(code):
    """Advanced Lua code beautification with better formatting"""

    # First pass: Add spaces around operators
    code = re.sub(r'([^=<>!])=([^=])', r'\1 = \2', code)  # Assignment
    code = re.sub(r'([^=<>!])==', r'\1 == ', code)  # Equality
    code = re.sub(r'~=', r' ~= ', code)  # Not equal
    code = re.sub(r'<=', r' <= ', code)  # Less than or equal
    code = re.sub(r'>=', r' >= ', code)  # Greater than or equal
    code = re.sub(r'([^<])([<>])([^=])', r'\1 \2 \3', code)  # Less/greater than
    code = re.sub(r'(\w)\+(\w)', r'\1 + \2', code)  # Addition
    code = re.sub(r'(\w)-(\w)', r'\1 - \2', code)  # Subtraction
    code = re.sub(r'(\w)\*(\w)', r'\1 * \2', code)  # Multiplication
    code = re.sub(r'(\w)/(\w)', r'\1 / \2', code)  # Division
    code = re.sub(r'\s+', ' ', code)  # Clean up multiple spaces

    # Split on semicolons
    code = code.replace(';', ';\n')

    # Add newlines before 'local' declarations (but not inside strings)
    code = re.sub(r'([^\n])\s*\blocal\s+', r'\1\nlocal ', code)

    # Add newlines before 'if', 'elseif', 'else'
    code = re.sub(r'([^\n])\s*\bif\s+', r'\1\nif ', code)
    code = re.sub(r'([^\n])\s*\belseif\s+', r'\1\nelseif ', code)

    # Add newlines before 'for', 'while', 'repeat'
    code = re.sub(r'([^\n])\s*\bfor\s+', r'\1\nfor ', code)
    code = re.sub(r'([^\n])\s*\bwhile\s+', r'\1\nwhile ', code)
    code = re.sub(r'([^\n])\s*\brepeat\s*', r'\1\nrepeat\n', code)

    # Add newlines before 'function'
    code = re.sub(r'([^\n])\s*\bfunction\s+', r'\1\nfunction ', code)

    # Add newlines after 'then', 'do'
    code = re.sub(r'\bthen\s+', 'then\n', code)
    code = re.sub(r'\bdo\s+', 'do\n', code)

    # Add newlines before 'end', 'until'
    code = re.sub(r'([^\n])\s*\bend\b', r'\1\nend', code)
    code = re.sub(r'([^\n])\s*\buntil\s+', r'\1\nuntil ', code)

    # Add newlines before 'else'
    code = re.sub(r'([^\n])\s*\belse\s*', r'\1\nelse\n', code)

    # Add newlines before 'return'
    code = re.sub(r'([^\n])\s*\breturn\s+', r'\1\nreturn ', code)

    # Clean up excessive newlines
    code = re.sub(r'\n\s*\n\s*\n+', '\n\n', code)

    # Add proper indentation
    lines = code.split('\n')
    indent_level = 0
    result = []
    indent_char = '    '  # 4 spaces

    indent_increase = ['then', 'do', 'repeat', 'function']
    indent_decrease_before = ['end', 'until', 'else', 'elseif']

    for line in lines:
        stripped = line.strip()
        if not stripped:
            result.append('')
            continue

        # Decrease indent before these keywords
        if any(stripped.startswith(kw) for kw in indent_decrease_before):
            indent_level = max(0, indent_level - 1)

        # Add indented line
        result.append(indent_char * indent_level + stripped)

        # Increase indent after these keywords
        if any(kw in stripped for kw in indent_increase):
            # But not if it's a one-liner (has 'end' on same line)
            if 'end' not in stripped:
                indent_level += 1

        # Check if we need to decrease indent for next line
        if stripped.startswith('end'):
            pass  # Already decreased before
        elif stripped.startswith('until'):
            pass  # Already decreased before
        elif stripped.startswith('else') or stripped.startswith('elseif'):
            # Increase back after else/elseif
            indent_level += 1

    return '\n'.join(result)

def main():
    if len(sys.argv) != 3:
        print("Usage: beautify_lua_advanced.py <input_file> <output_file>")
        sys.exit(1)

    input_file = sys.argv[1]
    output_file = sys.argv[2]

    try:
        with open(input_file, 'r', encoding='utf-8') as f:
            code = f.read()

        print(f"Beautifying {input_file} with advanced formatting...")
        print(f"Original: {len(code)} bytes, {len(code.splitlines())} lines")

        beautified = beautify_lua_advanced(code)

        print(f"Beautified: {len(beautified)} bytes, {len(beautified.splitlines())} lines")

        with open(output_file, 'w', encoding='utf-8') as f:
            f.write(beautified)

        print(f"✓ Saved to {output_file}")

    except Exception as e:
        print(f"Error: {e}")
        import traceback
        traceback.print_exc()
        sys.exit(1)

if __name__ == "__main__":
    main()