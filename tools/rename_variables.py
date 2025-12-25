#!/usr/bin/env python3
"""
Variable Renaming Tool for Lua
Renames minified variable names to meaningful ones based on usage analysis
"""

import sys
import re

def rename_variables(code):
    """Rename variables to meaningful names"""

    # Define the renaming map based on code analysis
    # Format: (old_name, new_name, word_boundary_required)
    renamings = [
        # Main variables
        ('\\ba\\b', 'localPlayer', True),
        ('\\bb\\b', 'animateScript', True),
        ('\\bc\\b', 'assetUrlPrefix', True),
        ('\\be\\b', 'workspace', True),
        ('\\bf\\b', 'poseAnimation', True),

        # Functions
        ('\\bg\\(', 'getOriginalAnimation(', False),
        ('\\bh\\b', 'animIndex', True),
        ('\\bi\\b', 'virtualUser', True),
        ('\\bj\\b', 'emoteCount', True),
        ('\\bk\\b', 'animationCount', True),
        ('\\bl\\b', 'httpRequest', True),
        ('\\bm\\b', 'httpService', True),
        ('\\bn\\(', 'teleportToRandomServer(', False),
        ('\\bo\\b', 'serverIds', True),
        ('\\bp\\b', 'response', True),
        ('\\bq\\b', 'serverData', True),

        # Loop variables (context-dependent, be careful)
        ('for r,s in', 'for index, value in', False),
        ('\\bt,u,v =', 'searchName, nameLength, results =', False),
        ('for w,s in', 'for _, player in', False),

        # UI and notification functions
        ('\\bx\\b', 'uiLibrary', True),
        ('\\by\\(', 'showError(', False),
        ('\\bB\\(', 'showSuccess(', False),
        ('\\bC\\(', 'showSuccessWithTime(', False),

        # Data tables
        ('\\bE\\b', 'emoteDatabase', True),
        ('\\bF\\b', 'animationPacks', True),
        ('\\bG\\b', 'defaultEmoteCommands', True),
        ('\\bH\\(', 'isDefaultEmote(', False),
        ('\\bI\\b', 'glitchAnimations', True),
        ('\\bJ\\b', 'glitchNames', True),
        ('\\bK\\b', 'packNames', True),
        ('\\bL\\b', 'emoteNames', True),

        # Sort comparison variables
        ('\\bM,N\\b', 'a, b', True),

        # Animation functions
        ('\\bO\\(', 'stopAllAnimations(', False),
        ('\\bP\\b', 'animator', True),
        ('\\bQ\\(', 'adjustAnimationSpeed(', False),
        ('\\bR\\(', 'replaceAnimations(', False),

        # R function parameters (S through a2)
        ('\\bS\\b', 'idleAnim1', True),
        ('\\bT\\b', 'idleAnim2', True),
        ('\\bU\\b', 'poseAnim', True),
        ('\\bV\\b', 'walkAnim', True),
        ('\\bW\\b', 'runAnim', True),
        ('\\bX\\b', 'jumpAnim', True),
        ('\\bY\\b', 'climbAnim', True),
        ('\\bZ\\b', 'fallAnim', True),
        ('\\b_\\b', 'swimAnim', True),
        ('\\ba0\\b', 'swimIdleAnim', True),
        ('\\ba1\\b', 'idleWeight1', True),
        ('\\ba2\\b', 'idleWeight2', True),
    ]

    # Apply renamings in order
    for old_pattern, new_name, use_word_boundary in renamings:
        if use_word_boundary:
            # Use word boundaries for exact matches
            code = re.sub(old_pattern, new_name, code)
        else:
            # Direct replacement for function calls and special patterns
            code = code.replace(old_pattern.replace('\\b', ''), new_name)

    return code

def main():
    if len(sys.argv) != 3:
        print("Usage: rename_variables.py <input_file> <output_file>")
        sys.exit(1)

    input_file = sys.argv[1]
    output_file = sys.argv[2]

    try:
        with open(input_file, 'r', encoding='utf-8') as f:
            code = f.read()

        print(f"Renaming variables in {input_file}...")
        print(f"Original: {len(code)} bytes")

        renamed = rename_variables(code)

        print(f"Renamed: {len(renamed)} bytes")

        with open(output_file, 'w', encoding='utf-8') as f:
            f.write(renamed)

        print(f"Saved to {output_file}")
        print("\nVariable renamings applied:")
        print("  a -> localPlayer")
        print("  b -> animateScript")
        print("  c -> assetUrlPrefix")
        print("  e -> workspace")
        print("  and 30+ more variables...")

    except Exception as e:
        print(f"Error: {e}")
        import traceback
        traceback.print_exc()
        sys.exit(1)

if __name__ == "__main__":
    main()