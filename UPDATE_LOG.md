# ImCurvin' Update Log & Changelog

This document tracks all version history, database optimizations, and system maintenance notes for the ImCurvin'.

Next version would be 1.1.5.

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
