## Mode Details in ImCurlin

In this section, I will explain the detailed operational modes integrated within ImCurlin. Currently, the framework features 3 distinct modes: Default, Risk, and Defiance Mode. While ImCurlin strictly adheres to a minimalist and server friendly philosophy by default, Defiance Mode acts as a highly aggressive and unconventional engine.

Here are the detailed breakdown of each mode in ImCurlin:

### Default Mode
This is the most fundamental mode in ImCurlin, designed to execute baseline structural scans. It utilizes basic network camouflage by deploying randomized UserAgents and maintaining a dynamic request delay ranging between 2 to 5 seconds. Additionally, to ensure a lowprofile footprint, the tool automatically enforces a 5 seconds cooldown safety window after every 5 consecutive scans. 

You can view the execution interface in the screenshot gallery.

### Risk Mode
This is the time for ImCurlin to show its "fangs." In this mode, ImCurlin no longer performs standard scanning. Risk Mode is divided into 3 parts: Default Risk Mode, Time-Based Risk Mode, and Gentle Risk Mode.

Here are the details for each part of Risk Mode:

*   **Default Risk Mode:** Performs standard scanning, but remember that the camouflage in Risk Mode is much better. In Risk Mode, you MUST activate TOR in your terminal, otherwise, the tool will reject your request. Additionally, randomized UserAgents and longer delays are added. In Risk Mode, every mode is wrapped in SOCKS5.
*   **Time-Based Risk Mode:** In this mode, ImCurlin will perform timebased SQLi on the website you submitted. However, it operates on numbers that are not too dangerous (usually 2 to 3 seconds). In this mode, the payload will use a 4 stage tamper stack. Do not forget that the Risk Mode camouflage tactics are also added.
*   **Gentle Risk Mode:** This mode is unusual, it performs scanning gently, but the server is forced to respond and provide its real address. If the server complies and responds, this mode will reward it with a 10 second tool delay so the server can "breathe". If it does not comply, why should you care? It will just proceed with the default 6 second delay. Do not forget that the Risk Mode camouflage is also added here.

All of this will be scanned in Python to validate false positives (SQLI RISK MODE validation is still WIP).
You can view the execution interface in the screenshot gallery.

### Defiance mode
Defiance Mode acts as an aggressive, nonserver friendly engine executing full time based injection operations specifically optimized for MySQL environments.

The architecture is driven by an advanced Hybrid URL Parsing that dynamically traces PreFlight HTTP Redirections, securing the absolute destination URL before passing it to localized multivector attack sequences. It incorporates Google Dorking reconnaissance to discover additional vulnerable endpoints within the target domain.

During this synchronized cycle, evasion is pushed to its absolute limits through dynamic multiIP TOR circuit rotations per request and automated UserAgent mutations on every concurrent thread. The dualvector parallel attack simultaneously probes MySQL specific time based anomalies using multi layered payload obfuscation (randomized case conversion, space2comment encoding, XOR encryption, and base64 encoding).
Advanced WAF bypass techniques are deployed through intelligent header injection that adapts based on URL parameter structure, injecting spoofed IP headers, CloudFlare bypass chains, and cache control directives to evade detection mechanisms.

Every time based anomaly generated during the attack is filtered by a specialized post scan Python validation engine designed to isolate baseline network latency from genuine database thread delays. The framework intelligently detects non MySQL environments and aborts execution to prevent resource wastage.

You can see the screenshoot at the screens hoot gallery.
