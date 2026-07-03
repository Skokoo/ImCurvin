# Mode Details in ImCurvin

In this section, I will explain the detailed operational modes integrated within ImCurvin. Currently, the framework features 3 distinct modes: Default, Risk, and Defiance Mode. While ImCurlin strictly adheres to a minimalist and server friendly philosophy by default, Defiance Mode acts as a highly aggressive and unconventional engine.

### Default Mode
![Default mode](https://img.shields.io/badge/Mode-Default%20mode-2ECC71)

Default Mode performs baseline endpoint scanning using wordlist driven reconnaissance. It randomizes UserAgents and injects spoofed IP headers to appear as legitimate traffic. Built-in rate limiting (1-3 second delays, 5 second pauses every 5 requests) avoids triggering detection. Perfect for initial target assessment before escalating to aggressive modes.
And this mode is the fundamental of ImCurvin.

You can view the execution interface in the screenshot gallery.

### Risk Mode
![Risk mode](https://img.shields.io/badge/Mode-Risk%20mode-E74C3C)

Risk Mode escalates reconnaissance with TOR circuit routing to mask scanning source. It operates in three stages:

* Stage 1: Endpoint Discovery: Probes target endpoints via wordlist using TOR proxy, logging successful 200 responses.
* Stage 2: TimeBased SQLi: If no endpoints found, deploys time-based SQL injection payloads with dynamic obfuscation (space to comment conversion, character encoding, null byte masking). Detects genuine vulnerabilities by analyzing response latency patterns confirms if delays are consistent across multiple checks.
* Stage 3 - Gentle Probing: Extracts server metadata via HTTP OPTIONS requests, harvesting headers like Server, X-Powered-By, and real file paths from Location headers.

Post Validation: Runs Python validators to eliminate false positives from log files.

Ideal for deeper target assessment when basic reconnaissance suggests potential weaknesses.

### Defiance mode
[Defiance mode](https://img.shields.io/badge/Defiance%20mode-%E2%9A%A1%EF%B8%8F%20ACTIVE-0B1D3A?logo=probot&logoColor=00D9FF)

Defiance Mode acts as an aggressive, nonserver friendly engine executing full time based injection operations specifically optimized for MySQL environments.

The architecture is driven by an advanced Hybrid URL Parsing that dynamically traces PreFlight HTTP Redirections, securing the absolute destination URL before passing it to localized multivector attack sequences. It incorporates Google Dorking reconnaissance to discover additional vulnerable endpoints within the target domain.

During this synchronized cycle, evasion is pushed to its absolute limits through dynamic multiIP TOR circuit rotations per request and automated UserAgent mutations on every concurrent thread. The dualvector parallel attack simultaneously probes MySQL specific time based anomalies using multi layered payload obfuscation (randomized case conversion, space2comment encoding, XOR encryption, and base64 encoding).
Advanced WAF bypass techniques are deployed through intelligent header injection that adapts based on URL parameter structure, injecting spoofed IP headers, CloudFlare bypass chains, and cache control directives to evade detection mechanisms.

Every time based anomaly generated during the attack is filtered by a specialized post scan Python validation engine designed to isolate baseline network latency from genuine database thread delays. The framework intelligently detects non MySQL environments and aborts execution to prevent resource wastage.

You can see the screenshoot at the screens hoot gallery.
