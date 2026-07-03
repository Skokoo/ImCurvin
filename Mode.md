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
Except for Defiance Mode, which acts as an aggressive, nonserver friendly engine executing full timebased injection operations specifically optimized for MySQL environments. Users must know that this mode is strictly 100% timebased, relying entirely on monitoring database latency responses rather than error outputs. It achieves extreme parallel evasion not through mass network bandwidth flooding or a traditional hardware DDoS match, but by exploiting core database thread execution logic flaws, synchronizing a targeted, scoped currently 40 payload matrix across two asymmetric requests every 5 seconds.

The architecture is driven by an advanced Hybrid URL Parsing that dynamically traces PreFlight HTTP Redirections, securing the absolute destination URL before passing it to a localized Singapore-menu analyzer script. This allows the core scanner to automatically adapt its injection paths between traditional PHP query strings and modern NonPHP path parameters without structural syntax wreckage. 

During this synchronized cycle, evasion is pushed to its absolute limits through dynamic multi IP TOR circuit rotations per request and automated UserAgent mutations on every concurrent thread. The engine enforces an 8 stage layered obfuscation (tamper) stack to mutate the payload via cryptographic and comment block techniques, backed by an adaptive HTTP header pollution system that morphs content types to match the target's underlying framework environment. 

Every time based anomaly generated during the attack is filtered out by a specialized post scan Python validation engine designed to isolate baseline network latency from genuine database thread delays. Despite traffic restrictions and a swift execution window under 3 minutes, the underlying database calculation workload can still trigger extreme server CPU stress and temporary hardware latency.

You can view the execution interface in the screenshot gallery.