# ImCurvin' Update Log & Changelog

This document tracks all version history, database optimizations, and system maintenance notes for the ImCurvin'.

---

## v1.3.0
The Core "Revolution" & Defiance Absorption Update.

### Added
- **Official Debian Package Distribution:** Introduced native Debian packaging (`.deb`) utilizing `dpkg-buildpackage` for standardized system deployment, encompassing automatic binary routing, strict file permissions handling, and automated post-installation configuration.
- **System Integration and Execution Wrappers:** Implemented a global wrapper script for seamless command-line execution alongside optimized `PYTHONPATH` configurations to ensure reliable module imports.
- **Resource Package Bundling:** Integrated comprehensive tamper modules, payload validators, desktop application environment entries, and dedicated wordlists directly into the system installation path.
- **Pre-Flight Target Connectivity Verification:** Added an automated connection testing mechanism to verify target availability prior to execution. This routine prevents blind exploitation attempts on dead hosts and can be disabled via the `--skip` flag for isolated environments.
- **Extended Command-Line Interface Parameters:** Introduced new arguments including `--valnow` for immediate validation, `--skip` for connection check bypasses, and additional diagnostic flags to enhance runtime flexibility.
- **Enhanced Target Parameter Detection:** Upgraded the parsing engine to accurately detect and differentiate between both HTTP POST and GET request parameters.
- **Dynamic Legacy Environment Adaptation:** Implemented an automated tamper fallback mechanism for older, non-modern web architectures. The framework dynamically downgrades active tamper vectors from complex methods (Base64, XOR, space2comment, randomcase) to a compatible subset (space2comment and randomcase only) to maximize delivery success.
- **Core Engine Transformation:** Fully deprecated "Risk Mode" and "Default Mode" to merge the entire framework architecture exclusively under the unified **Defiance Mode**.
- **Defiance Mode Overhaul (Buffed):** Maximized concurrent threading efficiency, optimized parallel MySQL timing sequences, and locked execution boundaries into an ~12.2 MB peak memory footprint.
- **Advanced WAF Bypass:** Integrated evasion vectors including native JA3/JA4 TLS Fingerprint Spoofing, dynamic HTTP Parameter Pollution (HPP) splitting, and automated HTTP/2 Rapid Reset protocol exploitation.

### Fixed
- **Time-Based Stopwatch Logic Overhaul:** Rectified a legacy flaw where a 3-second sleep payload incorrectly triggered response measurements exceeding 4 seconds, eliminating systemic false positives.
- **Payload Execution Calibration:** Synchronized time-based payloads with the measurement engine to ensure precise execution tracking and data integrity.
- **Sed and Curl Integration Stabilization:** Removed unpredictable `sed` manipulation logic that previously corrupted tamper functions. Stabilized `curl_output` parsing to correctly handle ambiguous target URL directions.
- **Codebase Modularization for Mobile Debugging:** Refactored and decoupled two vector functions into a standalone `vector.sh` file. This architecture optimization drastically reduces codebase bloat below the 800+ line threshold, significantly easing single-developer debugging on mobile environments.
- **UI/UX Brand Footprint Optimization:** Replaced the oversized, screen-blocking legacy logo with a minimal and lightweight ANSI text header to maximize terminal screen real estate.

## v1.2.0
The defiance mode update.

### Added
- **"Defiance mode:"** a mode that's no longer ImCurvin'.

---

## v1.0.9
Bug fixing and tool buffing update.

### Added
- **"Sweet" Tactic:** Upgraded the ```"Gentle"``` part in risk_scan.sh with a dynamic sleep reward system. If it encounters a successful HTTP 200 OK, it hits the brakes and gives the server a 10 second sweet reward. If not, it defaults to a slow 6 second crawl.
- **Information Disclosure Extraction:** Enhanced curl packet parsing to force sloppy target servers into leaking hidden absolute backend blueprints from metadata headers like Location, Content Location, URI, and X Original-URL.
- **Parameter Checking Rescue (Time Based part):** Engineered an interactive confirmation prompt inside Risk Mode that triggers when no parameter markers (like ?id=1) are detected in the URL. It lets users manually input a custom login pathway or blindly proceed with default scanning execution.
- **Risk Mode Data Synergy:** Integrated the Gentle part success paths straight into the global Target.log tracking file using the original FOUND_200 data layout so the Python analyst can review it automatically at the end of the session.
- **Selective Tamper Engine:** Fully deployed the hungry.sh core module, allowing dynamic obfuscation of SQL payloads to bypass modern WAF rule-sets without breaking standard database query schemas.

### Fixed & Maintained.

- **Fixing Tamper Logic:** Patched a critical regex flaw inside between_engine (=[A-Z]) that previously broke native database functions like BENCHMARK and SLEEP. 
- **Cross-Script Data Link:** Standardized internal string delimiters inside risk_scan.sh into a unified FOUND_200 and SQLI_ALERT data structure so the python validator reads all indicator lines flawlessly without breaking the original lightweight architecture.

## Version 1.0.5
Tool buffing update.

### Added
- **Easy easy target**: Moved all target vectors from core scripts into the root "data" directory for instant scaling.
- **Random random**: randomize the order of communication target loops.
- **Extended Static Targets**: Expanded "targets.txt" to exactly 40 baseline entries.
- **Time based**: Expanded "sqli.txt" to 20 universal "low impact" delay test strings.
- **"Gentle" Probe Expansion**: Expanded "gentle.txt" to 20 targeted options routes.
- **"Verification"**: Core hybrid connection structure (Bash as frontend controller, Python as verification analyst).
- **New Argument Flags:** Introduced dynamic command line options including auto pilot mode (`-cnf`), persistent storage loops (`-str=risk`), and more.

### Fixed & Maintained
- Adjusted time evaluation check in "risk_scan.sh" to align with the new low impact 2 sec sleep baseline.
- Maintained backward compatibility with "validators/fp_analyzer.py" due to consistent data bridge format.

---

## Version 1.0.0 (NewGen)
Focusing on bug fixing, but not tool buffing.

### Added
- Local TOR SOCKS5 network process verification via "pgrep" execution tracking.
- Static target detection loops with basic user-agent identity masking.
- Post scan verification engine to identify firewall custom response templates.
- Python verification.