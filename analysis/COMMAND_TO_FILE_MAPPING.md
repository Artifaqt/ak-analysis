# Command Registry to Downloaded File Mapping

This document maps the !commands from the registry (actual_payload_17.lua) to the actual downloaded files.

## Executive Summary

- **Total Commands in Registry:** 76+
- **Total Downloaded Scripts:** 58
- **Readable Scripts:** 36 (62%)
  - Already readable: 33 scripts
  - Manually processed: 3 scripts (animhub, sfly, jerk)
- **VM-Protected Scripts:** 22 (38%)

---

## Complete Mapping Table

| Command | Registry URL | Downloaded File | Folder | Status |
|---------|-------------|-----------------|--------|---------|
| !ad | akadmin-bzk.pages.dev/Ad.lua | ad.lua | readable | ✅ Readable |
| !akbypasser | akadmin-bzk.pages.dev/AKbypasser.lua | akbypasser.lua | readable | ✅ Readable |
| !animcopy | akadmin-bzk.pages.dev/Animcopy.lua | animcopy.lua | vm_obfuscated | ❌ VM-protected |
| !animhub | GitHub external URL | animhub.lua | readable | ✅ Beautified + renamed |
| !animlogger | akadmin-bzk.pages.dev/Animlogger.lua | animlogger.lua | readable | ✅ Readable |
| !antiafk | akadmin-bzk.pages.dev/antiafk.lua | antiafk.lua | vm_obfuscated | ❌ VM-protected |
| !antiall | akadmin-bzk.pages.dev/Antiall.lua | antiall.lua | readable | ✅ Readable |
| !antibang | akadmin-bzk.pages.dev/antibang.lua | antibang.lua | readable | ✅ Readable |
| !antifling | akadmin-bzk.pages.dev/Antifling.lua | antifling.lua | readable | ✅ Readable |
| !antiheadsit | akadmin-bzk.pages.dev/Anti%20Headsit.lua | antiheadsit.lua | readable | ✅ Readable |
| !antikidnap | akadmin-bzk.pages.dev/antikidnap.lua | antikidnap.lua | readable | ✅ Readable |
| !antislide | akadmin-bzk.pages.dev/stopglide.lua | antislide.lua | readable | ✅ Readable |
| !antivcban | akadmin-bzk.pages.dev/antivcban.lua | antivcban.lua | vm_obfuscated | ❌ VM-protected |
| !antivoid | akadmin-bzk.pages.dev/Antivoid.lua | antivoid.lua | readable | ✅ Readable |
| !call | akadmin-bzk.pages.dev/call.lua | call.lua | vm_obfuscated | ❌ VM-protected |
| !caranims | akadmin-bzk.pages.dev/caranimations.lua | caranims.lua | vm_obfuscated | ❌ VM-protected |
| !chateditor | akadmin-bzk.pages.dev/chateditor.lua | chateditor.lua | vm_obfuscated | ❌ VM-protected |
| !chatlogs | akadmin-bzk.pages.dev/Chatlogs.lua | chatlogs.lua | readable | ✅ Readable |
| !coloredbaseplate | akadmin-bzk.pages.dev/coloredbaseplate.lua | coloredbaseplate.lua | vm_obfuscated | ❌ VM-protected |
| !domainexpansion | akadmin-bzk.pages.dev/domainexpansion.lua | domainexpansion.lua | readable | ✅ Readable |
| !emotes | akadmin-bzk.pages.dev/Emotes.lua | emotes.lua | readable | ✅ Readable |
| !facebang | akadmin-bzk.pages.dev/facefuck.lua | facebang.lua | readable | ✅ Readable |
| !fastre | akadmin-bzk.pages.dev/instantRE.lua | fastre.lua | readable | ✅ Readable |
| !flip | akadmin-bzk.pages.dev/flip.lua | flip.lua | vm_obfuscated | ❌ VM-protected |
| !fling | akadmin-bzk.pages.dev/fling.lua | fling.lua | readable | ✅ Readable |
| !fpsboost | GitHub external URL | fpsboost.lua | readable | ✅ Readable |
| !friendcheck | akadmin-bzk.pages.dev/Friendchecker.lua | friendcheck.lua | readable | ✅ Readable |
| !ftp | akadmin-bzk.pages.dev/ftp.lua | ftp.lua | vm_obfuscated | ❌ VM-protected |
| !gokutp | akadmin-bzk.pages.dev/Gokutp.lua | gokutp.lua | vm_obfuscated | ❌ VM-protected |
| !hug | akadmin-bzk.pages.dev/Hug.lua | hug.lua | readable | ✅ Readable |
| !infbaseplate | akadmin-bzk.pages.dev/Baseplate.lua | infbaseplate.lua | vm_obfuscated | ❌ VM-protected |
| !invis | akadmin-bzk.pages.dev/Invis.lua | invis.lua | readable | ✅ Readable |
| !iy | GitHub external URL | iy.lua | readable | ✅ Readable (486KB) |
| !jerk | akadmin-bzk.pages.dev/Jerk.lua | jerk.lua | readable | ✅ Loader documented |
| !kidnap | akadmin-bzk.pages.dev/kidnap.lua | kidnap.lua | vm_obfuscated | ❌ VM-protected |
| !limborbit | akadmin-bzk.pages.dev/limborbit.lua | limborbit.lua | vm_obfuscated | ❌ VM-protected |
| !naturaldisastergodmode | akadmin-bzk.pages.dev/Ndsgodmode.lua | naturaldisastergodmode.lua | readable | ✅ Readable |
| !pianoplayer | akadmin-bzk.pages.dev/Pianoplayer.lua | pianoplayer.lua | readable | ✅ Readable |
| !r15 | akadmin-bzk.pages.dev/R15.lua | r15.lua | readable | ✅ Readable |
| !r6 | akadmin-bzk.pages.dev/R6.lua | r6.lua | readable | ✅ Readable |
| !re | akadmin-bzk.pages.dev/oof.lua | re.lua | readable | ✅ Readable |
| !reanim | akadmin-bzk.pages.dev/sizechanger.lua | reanim.lua | vm_obfuscated | ❌ VM-protected |
| !reverse | akadmin-bzk.pages.dev/Reversee.lua | reverse.lua | vm_obfuscated | ❌ VM-protected |
| !rizzlines | akadmin-bzk.pages.dev/rizzlines.lua | N/A | - | Not downloaded |
| !sfly | akadmin-bzk.pages.dev/Sfly.lua | sfly.lua | readable | ✅ Merged versions |
| !shaders | akadmin-bzk.pages.dev/Shaders.lua | shaders.lua | vm_obfuscated | ❌ VM-protected |
| !shiftlock | akadmin-bzk.pages.dev/Shiftlock.lua | shiftlock.lua | readable | ✅ Readable |
| !shmost | akadmin-bzk.pages.dev/shmost.lua | shmost.lua | readable | ✅ Readable |
| !skymaster | akadmin-bzk.pages.dev/skymaster.lua | skymaster.lua | readable | ✅ Readable |
| !speed | akadmin-bzk.pages.dev/speed.lua | speed.lua | vm_obfuscated | ❌ VM-protected |
| !spotify | akadmin-bzk.pages.dev/spotify.lua | spotify.lua | vm_obfuscated | ❌ VM-protected |
| !stalk | akadmin-bzk.pages.dev/Stalk.lua | stalk.lua | vm_obfuscated | ❌ VM-protected |
| !swordreach | akadmin-bzk.pages.dev/swordreach.lua | swordreach.lua | vm_obfuscated | ❌ VM-protected |
| !touchfling | akadmin-bzk.pages.dev/touchfling.lua | touchfling.lua | readable | ✅ Readable |
| !trip | akadmin-bzk.pages.dev/trip.lua | trip.lua | vm_obfuscated | ❌ VM-protected |
| !uafling | akadmin-bzk.pages.dev/uafling.lua | uafling.lua | readable | ✅ Readable |
| !ugcemotes | akadmin-bzk.pages.dev/Ugcemotes.lua | ugcemotes.lua | vm_obfuscated | ❌ VM-protected |
| !voidre | akadmin-bzk.pages.dev/voidoof.lua | voidre.lua | readable | ✅ Readable |
| !walkonair | akadmin-bzk.pages.dev/Walkonair.lua | walkonair.lua | readable | ✅ Readable |

---

## Readable Scripts (36 files, 62%)

### Manually Processed (3)
1. **animhub.lua** - GitHub source, beautified + variable renamed + syntax fixed (269KB)
2. **jerk.lua** - Loader documented, remote scripts use MoonSec V3 protection
3. **sfly.lua** - Mobile + desktop versions fetched and merged (32KB)

### Already Readable (33)
Scripts downloaded without VM protection, immediately usable for analysis:

**Anti-Protection (7):**
- antiall.lua, antibang.lua, antifling.lua, antiheadsit.lua, antikidnap.lua, antislide.lua, antivoid.lua

**Interaction (4):**
- facebang.lua, fling.lua, hug.lua, touchfling.lua

**Utility (11):**
- ad.lua, akbypasser.lua, animlogger.lua, chatlogs.lua, friendcheck.lua, fpsboost.lua, naturaldisastergodmode.lua, pianoplayer.lua, shiftlock.lua, shmost.lua, walkonair.lua

**Movement (3):**
- fastre.lua, uafling.lua, voidre.lua

**Visual/World (3):**
- domainexpansion.lua, emotes.lua, skymaster.lua

**Character (3):**
- invis.lua, r6.lua, r15.lua

**Other (2):**
- iy.lua (486KB - Infinite Yield admin script), re.lua

---

## VM-Protected Scripts (22 files, 38%)

Scripts using Luraph VM obfuscation that cannot be deobfuscated:

1. animcopy.lua - Animation copier
2. antiafk.lua - Anti-AFK
3. antivcban.lua - Anti voice chat ban
4. call.lua - Phone call UI
5. caranims.lua - Car animations
6. chateditor.lua - Chat editor
7. coloredbaseplate.lua - Colored baseplate
8. flip.lua - Flip character
9. ftp.lua - Fast teleport
10. gokutp.lua - Goku-style teleport
11. infbaseplate.lua - Infinite baseplate
12. kidnap.lua - Player interaction
13. limborbit.lua - Limbo orbit
14. reanim.lua - Reanimation/size changer
15. reverse.lua - Reverse controls
16. shaders.lua - Graphics shaders
17. speed.lua - Speed modification
18. spotify.lua - Spotify UI
19. stalk.lua - Player tracking
20. swordreach.lua - Sword reach modification
21. trip.lua - Trip animation
22. ugcemotes.lua - UGC emotes

---

## Protection Analysis

### VM-Protected Pattern
- **Source:** All scripts from `akadmin-bzk.pages.dev` domain
- **Protection:** Luraph VM obfuscation + anti-tamper
- **Characteristics:**
  - Custom bytecode compilation
  - No standard loadstring() calls
  - Environment validation checks
  - Crash on standalone execution

### Readable Pattern
- **External Sources:** GitHub-hosted scripts (animhub, fpsboost, iy)
- **Simple Loaders:** Scripts that fetch remote content (jerk, sfly)
- **Unprotected Scripts:** Some akadmin-bzk.pages.dev scripts downloaded without VM protection

### Protection Distribution
- **VM-Protected:** 22/58 scripts (38%)
- **Readable:** 36/58 scripts (62%)

This indicates selective protection - critical or premium features are VM-protected, while utility and common features remain readable.

---

## Command Categories

### Movement & Physics (7 commands)
- speed, sfly, flip, gokutp, ftp, walkonair, antislide

### Animations & Emotes (7 commands)
- ugcemotes, caranims, animhub, animcopy, animlogger, emotes, jerk

### Character Modification (3 commands)
- reanim, r6, r15

### Anti-Protection Features (8 commands)
- antiafk, antivcban, antikidnap, antiall, antibang, antiheadsit, antifling, antivoid

### Social & Interaction (5 commands)
- kidnap, call, stalk, hug, facebang, touchfling, uafling

### Utilities (11 commands)
- chateditor, chatlogs, coloredbaseplate, infbaseplate, shaders, spotify, rizzlines, akbypasser, shiftlock, ad, pianoplayer

### Combat & Game-Specific (2 commands)
- swordreach, naturaldisastergodmode

### Other (9 commands)
- reverse, friendcheck, invis, trip, re, voidre, fastre, shmost, domainexpansion, skymaster

---

## Download Statistics

### Total Commands vs Downloaded
- **Registry Total:** 76+ commands
- **Downloaded:** 58 scripts (76%)
- **Not Downloaded:** ~18 commands (24%)

### Why These Were Downloaded
The 58 downloaded scripts likely represent:
1. Commands executed during analysis
2. Commonly used features
3. Commands tested for functionality

The remaining ~18 commands were never executed, so their scripts were never downloaded from the remote server.

---

## Key Insights

### Script Distribution by Source
- **akadmin-bzk.pages.dev:** Primary source (~95% of scripts)
- **GitHub:** External scripts (animhub, fpsboost, iy)
- **pastefy.app:** MoonSec V3 protected remotes (jerk.lua dependencies)

### Protection Strategy
The script authors use selective VM protection:
- **High-value features:** VM-protected (speed, reanim, kidnap, etc.)
- **Utility features:** Often readable (anti-protection, chat tools, etc.)
- **External scripts:** No protection (GitHub sources)

### Success Rate
- **62% readable** (36/58) - Excellent success for analysis
- **38% VM-protected** (22/58) - Remains as black boxes
- **5% manual processing** (3/58) - Required special handling

---

## Conclusion

The command system operates on a download-on-demand model. Commands download their scripts when first executed, which is why we have 58 of the 76+ registered commands.

**Protection Assessment:**
- Selective VM protection indicates the authors prioritize protecting core features
- 62% readable rate provides substantial insight into system functionality
- Remaining 38% VM-protected scripts contain critical or premium features

**Analysis Status:**
- ✅ Complete mapping of all downloaded scripts
- ✅ Categorization by functionality and protection level
- ✅ 36 scripts available for detailed code analysis
- ❌ 22 scripts remain protected (behavior analysis only)

---

**Last Updated:** December 25, 2025
**Total Scripts Analyzed:** 58
**Documentation Status:** ✅ Complete
