# ImCurvin' Update Log & Changelog

This document tracks all version history, database optimizations, and system maintenance notes for the ImCurvin'.

---

## Version 1.0.5

### Added
- **Dynamic Database Decoupling**: Moved all target vectors from core scripts into the root "data" directory for instant scaling.
- **Random random**: randomize the order of communication target loops.
- **Extended Static Targets**: Expanded "targets.txt" to exactly 40 baseline entries.
- **Time based**: Expanded "sqli.txt" to 20 universal "low impact" delay test strings.
- **"Gentle" Probe Expansion**: Expanded "gentle.txt" to 20 targeted options routes.

### Fixed & Maintained
- Adjusted time evaluation check in "risk_scan.sh" to align with the new low impact 2 sec sleep baseline.
- Maintained backward compatibility with "validators/fp_analyzer.py" due to consistent data bridge format.

---

## Version 1.0.0 (NewGen)
Focusing on bug fixing, but not tool buffing.

### Added
- Core hybrid connection structure (Bash as frontend controller, Python as verification analyst).
- Local TOR SOCKS5 network process verification via "pgrep" execution tracking.
- Static target detection loops with basic user-agent identity masking.
- Post scan verification engine to identify firewall custom response templates.
