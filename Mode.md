# ImCurvin Details
In this section, I will explain the detailed operational explanation integrated within ImCurvin. 

---

ImCurvin is a WAF Stress-Testing/Evasion Proof-of-Concept Tool, executing full time-based injection operations specifically optimized for MySQL environments.

### Reconnaissance & Parameter Footprinting
* **Hybrid URL Parsing:** Dynamically traces PreFlight HTTP Redirections to secure the absolute destination URL before passing it to localized multi-vector attack sequences.
* **Google Dorking Reconnaissance:** Automatically discovers additional vulnerable endpoints within the target domain to expand the attack surface.
* **RFC-Compliant Multi-Matrix Extraction:** Simultaneously processes raw query matrices, semi-colon path matrices (`/path;param=val`), and fallback heuristic patterns using regex to ensure zero parameter omission.
* **Interactive Raw POST Interception:** Connects directly via TTY stream endpoints to detect, parse, and handle raw multi-parameter request strings natively without reliance on heavy frameworks.
* **Anti-Noise Token Filtration:** Intelligently identifies and excludes non-injectable application metadata (such as `csrf`, `_token`, `captcha`, and `nonce`) from the active testing matrix to avoid redundant network overhead.

### Network Evasion & Multi-Port TOR Routing
* **Multi-Port TOR Exporting:** Completely eliminates the typical single circuit TOR bottleneck by exporting multiple active TOR ports simultaneously (such as 9050, 9052, and more).
* **Load-Balanced Requests:** The Bash architecture randomly distributes parallel MySQL attack threads across 6 distinct TOR circuits to balance outbound network traffic.
* **Continuous Identity Mutation:** Pushes evasion to its "limits" through dynamic multi-IP TOR circuit rotations per request combined with automated UserAgent mutations on every concurrent thread.
* **Randomized Delay Insertion (Jitter):** Introduces unpredictable, non-linear time intervals between concurrent requests to destroy the traffic-pattern baselines of behavioral AI filters.

### Advanced WAF Bypass & Obfuscation
The engine deploys a **synchronized dual-vector parallel attack** that simultaneously probes MySQL time-based anomalies using multi-layered payload obfuscation and intelligent header injection, featuring:
* **Stacked Queries Injection:** Utilizes semicolon (;) delimiters to terminate the application's native database execution context, allowing the compilation and subsequent execution of independent, dynamic in-memory SQL instructions.
* **HTTP Parameter Pollution (HPP) Splitting:** Injects duplicated query parameters with identical names (`param_name=999&param_name=payload`) to exploit parsing discrepancies between the front-end WAF and the back-end application server, effectively masking malicious database payloads behind benign values.
* **JSON-Header Tunneling:** Serializes database exploitation vectors into clean `application/json` strings hidden behind custom HTTP headers, blindfolding WAF engines that exclusively inspect query strings and request bodies.
* **Payload Pen-Testing Masking:** Conceals detection signatures through randomized case conversion, space2comment encoding, XOR encryption, and Base64 encoding matrices.
* **Intelligent Header Injection:** Injects spoofed IP headers, Cloudflare bypass chains, and cache-control directives tailored specifically to complex URL parameter structures.
* **Cipher Suite Hardening:** Enforces explicit TLS 1.3 protocol handshakes paired with custom cipher negotiation string matrices, forcing target load balancers into precise cryptographic layouts to match benign modern browser signatures.
* **Protocol Exploitation:** Executes synchronized JA3/JA4 TLS Fingerprint Spoofing, HTTP/2 Rapid Reset Protocol Exploitation via a customizable high-concurrency window (defaulted to 50 concurrent streams), HTTP Chunked Transfer Encoding Mismatch, and Automated Control Loop Shadowban Evasion.

### Automated IP Re-Birth via TOR NEWNYM
To ensure uninterrupted execution against active threat mitigation systems, imcurvin integrates an automated defensive evasion loop:
* **Block Detection:** If the target infrastructure responds with a block status (such as HTTP 403 Forbidden or 429 Too Many Requests), the engine dynamically triggers a "SIGNAL NEWNYM" instruction across the active port array.
* **Instant Rotation:** Instantiates an immediate circuit teardown and rebuild, rotating the outbound exit node mapping within milliseconds without interrupting the primary multi-threaded attack vector.

### Post-Scan Validation Engine
* **Microsecond Telemetry:** Leverages low-level `curl` write-out bindings (`time_total`) to audit response latency down to microsecond intervals, feeding precision telemetry directly into the evaluation loop.
* **Latency Isolation:** Every time-based anomaly generated during the attack is filtered by a specialized post-scan Python validation engine designed to isolate baseline network latency from genuine database thread delays.
* **Environment Safeguard:** The framework detects non-MySQL environments and aborts execution to prevent "resource wastage".

---
*You can view the execution interface in the screenshot gallery.*