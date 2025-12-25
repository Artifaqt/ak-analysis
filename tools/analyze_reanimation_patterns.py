#!/usr/bin/env python3
"""
Reanimation Pattern Analyzer

Analyzes the minified deobfuscated code to identify reanimation techniques
even without full deobfuscation.
"""

import re
import sys
from collections import Counter

class ReanimationAnalyzer:
    def __init__(self, file_path):
        self.file_path = file_path
        self.code = self._read_file()
        self.findings = {
            'cframe_operations': [],
            'character_parts': [],
            'physics_properties': [],
            'network_ownership': [],
            'welds_attachments': [],
            'input_handling': [],
            'service_calls': [],
            'suspicious_patterns': []
        }

    def _read_file(self):
        """Read the deobfuscated file"""
        with open(self.file_path, 'r', encoding='utf-8', errors='ignore') as f:
            return f.read()

    def analyze_cframe_operations(self):
        """Find CFrame operations (character positioning)"""
        print("[*] Analyzing CFrame operations...")

        patterns = {
            'CFrame.new': r'CFrame\.new',
            'CFrame.Angles': r'CFrame\.Angles',
            'CFrame.fromEulerAnglesXYZ': r'CFrame\.fromEulerAnglesXYZ',
            'CFrame.fromMatrix': r'CFrame\.fromMatrix',
            'CFrame.lookAt': r'CFrame\.lookAt',
            'CFrame multiplication': r'\*\s*CFrame',
            'CFrame addition': r'\+\s*CFrame',
        }

        for name, pattern in patterns.items():
            matches = re.findall(pattern, self.code, re.IGNORECASE)
            if matches:
                self.findings['cframe_operations'].append(f"{name}: {len(matches)} occurrences")

        print(f"[+] Found {len(self.findings['cframe_operations'])} CFrame patterns")

    def analyze_character_parts(self):
        """Find character part references"""
        print("[*] Analyzing character part references...")

        parts = [
            'HumanoidRootPart', 'Head', 'Torso', 'UpperTorso', 'LowerTorso',
            'LeftArm', 'RightArm', 'LeftLeg', 'RightLeg',
            'LeftHand', 'RightHand', 'LeftFoot', 'RightFoot',
            'Humanoid', 'Character'
        ]

        for part in parts:
            count = len(re.findall(rf'\b{part}\b', self.code))
            if count > 0:
                self.findings['character_parts'].append(f"{part}: {count} references")

        print(f"[+] Found {len(self.findings['character_parts'])} character part types")

    def analyze_physics_properties(self):
        """Find physics/reanimation properties"""
        print("[*] Analyzing physics properties...")

        properties = {
            'Anchored': r'\.Anchored\s*=',
            'Velocity': r'\.Velocity\s*=',
            'AssemblyLinearVelocity': r'\.AssemblyLinearVelocity',
            'AssemblyAngularVelocity': r'\.AssemblyAngularVelocity',
            'CFrame': r'\.CFrame\s*=',
            'Position': r'\.Position\s*=',
            'CanCollide': r'\.CanCollide\s*=',
            'Massless': r'\.Massless\s*=',
        }

        for name, pattern in properties.items():
            matches = re.findall(pattern, self.code, re.IGNORECASE)
            if matches:
                self.findings['physics_properties'].append(f"{name}: {len(matches)} modifications")

        print(f"[+] Found {len(self.findings['physics_properties'])} physics property patterns")

    def analyze_network_ownership(self):
        """Find network ownership operations (KEY for reanimation!)"""
        print("[*] Analyzing network ownership...")

        patterns = {
            'SetNetworkOwner': r'SetNetworkOwner',
            'NetworkOwner': r'NetworkOwner',
            'GetNetworkOwner': r'GetNetworkOwner',
        }

        for name, pattern in patterns.items():
            matches = re.findall(pattern, self.code, re.IGNORECASE)
            if matches:
                self.findings['network_ownership'].append(f"{name}: {len(matches)} calls")
                print(f"  [!] FOUND: {name} - This is a REANIMATION TECHNIQUE!")

        print(f"[+] Found {len(self.findings['network_ownership'])} network ownership patterns")

    def analyze_welds_attachments(self):
        """Find weld/motor6d operations"""
        print("[*] Analyzing welds and attachments...")

        patterns = {
            'Motor6D': r'Motor6D',
            'Weld': r'\bWeld\b',
            'WeldConstraint': r'WeldConstraint',
            'Attachment': r'Attachment',
            'Part0': r'\.Part0\s*=',
            'Part1': r'\.Part1\s*=',
            'C0': r'\.C0\s*=',
            'C1': r'\.C1\s*=',
        }

        for name, pattern in patterns.items():
            matches = re.findall(pattern, self.code)
            if matches:
                self.findings['welds_attachments'].append(f"{name}: {len(matches)} occurrences")

        print(f"[+] Found {len(self.findings['welds_attachments'])} weld/attachment patterns")

    def analyze_input_handling(self):
        """Find input handling code"""
        print("[*] Analyzing input handling...")

        patterns = {
            'UserInputService': r'UserInputService',
            'InputBegan': r'InputBegan',
            'InputEnded': r'InputEnded',
            'KeyCode': r'KeyCode\.',
            'UserInputType': r'UserInputType\.',
            'Mouse': r'\bMouse\b',
            'Hit': r'\.Hit',
            'Target': r'\.Target',
        }

        for name, pattern in patterns.items():
            matches = re.findall(pattern, self.code)
            if matches:
                self.findings['input_handling'].append(f"{name}: {len(matches)} references")

        print(f"[+] Found {len(self.findings['input_handling'])} input handling patterns")

    def analyze_services(self):
        """Find Roblox service usage"""
        print("[*] Analyzing service calls...")

        services = [
            'Players', 'Workspace', 'RunService', 'UserInputService',
            'TweenService', 'ReplicatedStorage', 'StarterGui',
            'HttpService', 'TeleportService'
        ]

        for service in services:
            pattern = rf'GetService\s*\(\s*["\']({service})["\']'
            matches = re.findall(pattern, self.code)
            if matches or service in self.code:
                count = len(re.findall(rf'\b{service}\b', self.code))
                self.findings['service_calls'].append(f"{service}: {count} references")

        print(f"[+] Found {len(self.findings['service_calls'])} service types")

    def find_suspicious_patterns(self):
        """Find potentially interesting patterns"""
        print("[*] Looking for interesting patterns...")

        patterns = {
            'loadstring calls': r'loadstring\s*\(',
            'Invisible parts': r'Transparency\s*=\s*1',
            'Part creation': r'Instance\.new\s*\(\s*["\']Part["\']',
            'Clone operations': r':Clone\s*\(',
            'Destroy calls': r':Destroy\s*\(',
            'Wait/delay': r'wait\s*\(|task\.wait\s*\(',
            'Loops': r'\bwhile\s+.*\bdo\b|\bfor\s+',
            'LocalPlayer access': r'LocalPlayer',
        }

        for name, pattern in patterns.items():
            matches = re.findall(pattern, self.code, re.IGNORECASE)
            if matches:
                self.findings['suspicious_patterns'].append(f"{name}: {len(matches)} found")

        print(f"[+] Found {len(self.findings['suspicious_patterns'])} interesting patterns")

    def identify_reanimation_type(self):
        """Try to identify what type of reanimation this uses"""
        print("\n[*] Identifying reanimation technique...")

        reanim_types = []

        # Check for network ownership based reanimation
        if any('SetNetworkOwner' in f for f in self.findings['network_ownership']):
            reanim_types.append("Network Ownership Reanimation")
            print("  [!] Uses SetNetworkOwner - CLASSIC REANIMATION METHOD")

        # Check for CFrame manipulation
        if len(self.findings['cframe_operations']) > 0:
            reanim_types.append("CFrame-based Movement")
            print("  [!] Heavy CFrame usage - Direct positioning")

        # Check for physics manipulation
        if any('Anchored' in f for f in self.findings['physics_properties']):
            reanim_types.append("Physics Manipulation")
            print("  [!] Modifies Anchored property - Physics bypass")

        # Check for velocity-based movement
        if any('Velocity' in f for f in self.findings['physics_properties']):
            reanim_types.append("Velocity-based Movement")
            print("  [!] Uses Velocity - Physics-based control")

        # Check for weld manipulation
        if len(self.findings['welds_attachments']) > 5:
            reanim_types.append("Weld/Motor6D Manipulation")
            print("  [!] Heavy weld usage - Joint control")

        return reanim_types

    def generate_report(self, output_file="reanimation_analysis.txt"):
        """Generate analysis report"""
        print(f"\n[*] Generating report: {output_file}")

        with open(output_file, 'w', encoding='utf-8') as f:
            f.write("="*80 + "\n")
            f.write("REANIMATION PATTERN ANALYSIS REPORT\n")
            f.write("="*80 + "\n\n")

            f.write(f"File analyzed: {self.file_path}\n")
            f.write(f"File size: {len(self.code)} characters\n\n")

            # Reanimation type
            reanim_types = self.identify_reanimation_type()
            f.write("REANIMATION TECHNIQUES DETECTED\n")
            f.write("-"*80 + "\n")
            if reanim_types:
                for rt in reanim_types:
                    f.write(f"  ✓ {rt}\n")
            else:
                f.write("  ? Could not determine specific technique\n")
            f.write("\n")

            # Write all findings
            sections = [
                ("NETWORK OWNERSHIP (Critical for Reanimation)", 'network_ownership'),
                ("CFRAME OPERATIONS (Character Positioning)", 'cframe_operations'),
                ("CHARACTER PARTS ACCESSED", 'character_parts'),
                ("PHYSICS PROPERTIES MODIFIED", 'physics_properties'),
                ("WELDS AND ATTACHMENTS", 'welds_attachments'),
                ("INPUT HANDLING", 'input_handling'),
                ("ROBLOX SERVICES USED", 'service_calls'),
                ("INTERESTING PATTERNS", 'suspicious_patterns'),
            ]

            for section_name, key in sections:
                f.write(section_name + "\n")
                f.write("-"*80 + "\n")
                if self.findings[key]:
                    for item in self.findings[key]:
                        f.write(f"  • {item}\n")
                else:
                    f.write("  (none found)\n")
                f.write("\n")

            # Summary
            f.write("="*80 + "\n")
            f.write("SUMMARY\n")
            f.write("="*80 + "\n\n")

            total_patterns = sum(len(v) for v in self.findings.values())
            f.write(f"Total patterns identified: {total_patterns}\n\n")

            if self.findings['network_ownership'] and any('SetNetworkOwner' in str(f) for f in self.findings['network_ownership']):
                f.write("✓✓✓ CONFIRMED: This is a REANIMATION script!\n\n")
                f.write("How it likely works:\n")
                f.write("  1. Takes network ownership of character parts\n")
                f.write("  2. Manipulates CFrames/Physics directly\n")
                f.write("  3. Handles user input for movement\n")
                f.write("  4. Bypasses normal character controller\n")
            else:
                f.write("This appears to be a character manipulation script.\n")
                f.write("May or may not be full reanimation.\n")

            f.write("\n" + "="*80 + "\n")
            f.write("To see the ACTUAL code, try Layer 2 deobfuscation:\n")
            f.write("Run: run_layer2_deobfuscation.lua\n")
            f.write("="*80 + "\n")

        print(f"[+] Report saved to {output_file}")

    def run_full_analysis(self):
        """Run all analysis steps"""
        print("="*80)
        print("REANIMATION PATTERN ANALYZER")
        print("="*80)
        print()

        self.analyze_network_ownership()  # Most important for reanimation
        self.analyze_cframe_operations()
        self.analyze_character_parts()
        self.analyze_physics_properties()
        self.analyze_welds_attachments()
        self.analyze_input_handling()
        self.analyze_services()
        self.find_suspicious_patterns()

        self.generate_report()

        print("\n" + "="*80)
        print("ANALYSIS COMPLETE")
        print("="*80)
        print("\nCheck 'reanimation_analysis.txt' for full results!")

def main():
    # Try to find deobfuscated code in current directory or workspace
    import os

    possible_paths = [
        r'c:\Users\Artifaqt\AppData\Local\Potassium\workspace\deobfuscated_code.lua',
        r'c:\Users\Artifaqt\Downloads\ak\deobfuscated_code.lua',
        'deobfuscated_code.lua',
    ]

    file_path = None
    for path in possible_paths:
        if os.path.exists(path):
            file_path = path
            break

    if not file_path:
        print("Error: Could not find deobfuscated_code.lua")
        print("Please specify the path:")
        print("  python analyze_reanimation_patterns.py <path_to_file>")
        sys.exit(1)

    if len(sys.argv) > 1:
        file_path = sys.argv[1]

    print(f"Analyzing: {file_path}\n")

    analyzer = ReanimationAnalyzer(file_path)
    analyzer.run_full_analysis()

if __name__ == '__main__':
    main()
