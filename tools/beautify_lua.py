#!/usr/bin/env python3
"""
Simple Lua Beautifier
Formats minified Lua code by adding newlines and basic indentation
"""

import sys
import re

def beautify_lua(code):
    """Basic Lua code beautification"""

    # Add newlines after semicolons
    code = code.replace(';', ';\n')

    # Add newlines before and after specific keywords
    keywords = [
        'local ', 'function ', 'if ', 'then', 'else', 'elseif ',
        'end', 'for ', 'while ', 'repeat', 'until ', 'return ',
        'do'
    ]

    # Add newline before keywords (except at start of line)
    for keyword in keywords:
        if keyword in ['then', 'do', 'end']:
            # These should have newline before
            code = re.sub(r'([^\n])(\s*)(' + re.escape(keyword) + r')([^\w])', r'\1\n\3\4', code)

    # Add newline after 'then', 'do', 'else', 'repeat'
    code = re.sub(r'\bthen\b', 'then\n', code)
    code = re.sub(r'\bdo\b', 'do\n', code)
    code = re.sub(r'\belse\b', 'else\n', code)
    code = re.sub(r'\brepeat\b', 'repeat\n', code)

    # Add newline before 'end', 'until', 'elseif', 'else'
    code = re.sub(r'([^\n])\s*\bend\b', r'\1\nend', code)
    code = re.sub(r'([^\n])\s*\buntil\b', r'\1\nuntil', code)
    code = re.sub(r'([^\n])\s*\belseif\b', r'\1\nelseif', code)

    # Clean up multiple newlines
    code = re.sub(r'\n\s*\n\s*\n+', '\n\n', code)

    # Basic indentation
    lines = code.split('\n')
    indent_level = 0
    result = []

    for line in lines:
        stripped = line.strip()
        if not stripped:
            result.append('')
            continue

        # Decrease indent for end, until, else, elseif
        if re.match(r'^(end|until|else|elseif)\b', stripped):
            indent_level = max(0, indent_level - 1)

        # Add indented line
        result.append('    ' * indent_level + stripped)

        # Increase indent after certain keywords
        if re.search(r'\b(function|if|for|while|repeat|do)\b', stripped):
            if not re.search(r'\bend\b', stripped):  # Not a one-liner
                indent_level += 1

        # Increase indent for then
        if re.match(r'^then\s*$', stripped):
            indent_level += 1

        # Decrease indent after end
        if re.match(r'^end\b', stripped):
            indent_level = max(0, indent_level)

    return '\n'.join(result)

def main():
    if len(sys.argv) != 3:
        print("Usage: beautify_lua.py <input_file> <output_file>")
        sys.exit(1)

    input_file = sys.argv[1]
    output_file = sys.argv[2]

    try:
        with open(input_file, 'r', encoding='utf-8') as f:
            code = f.read()

        print(f"Beautifying {input_file}...")
        print(f"Original size: {len(code)} bytes, {len(code.splitlines())} lines")

        beautified = beautify_lua(code)

        print(f"Beautified size: {len(beautified)} bytes, {len(beautified.splitlines())} lines")

        with open(output_file, 'w', encoding='utf-8') as f:
            f.write(beautified)

        print(f"Saved to {output_file}")

    except Exception as e:
        print(f"Error: {e}")
        sys.exit(1)

if __name__ == "__main__":
    main()