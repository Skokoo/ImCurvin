from setuptools import setup, find_packages
# ImCurvin' v1.2.0
# Copyright 2026 Skokoo
# Licensed under the Apache License, Version 2.0

setup(
    name="imcurvin",
    version="1.3.2",
    license="Apache 2.0",
    author="Skokoo",
    author_email="Skokoo@proton.me",
    description="Web security auditing tool with advanced evasion modes",
    
        long_description="""
## ImCurvin

![License](https://img.shields.io/badge/License-Apache%202.0-4EAA25?logo=apache&logoColor=white) ![Bash](https://img.shields.io/badge/Bash-5.2-4EAA25?logo=gnu-bash&logoColor=white) ![Python](https://img.shields.io/badge/Python-3.12-3776AB?logo=python&logoColor=white) ![Platform](https://img.shields.io/badge/Platform-Termux%20%2F%20Linux-FF6B6B?logo=linux&logoColor=white)

***ImCurvin*** is an open-source, server-friendly web security auditing tool built with Termux for Linux environments to detect misconfigurations, probe backend vulnerabilities, and discover hidden endpoints. Powered by a flexible Bash core integrated with analytical Python engines.

The framework explanation:

### Reconnaissance
* **Hybrid URL Parsing:** Dynamically traces PreFlight HTTP Redirections to secure the absolute destination URL before passing it to localized multi-vector attack sequences.
* **Google Dorking Reconnaissance:** Automatically discovers additional vulnerable endpoints within the target domain to expand the attack surface.

### Network Evasion & Multi-Port TOR Routing
* **Multi-Port TOR Exporting:** Completely eliminates the typical single circuit TOR bottleneck by exporting multiple active TOR ports simultaneously (such as 9050, 9052, and more).
* **Load-Balanced Requests:** The Bash architecture randomly distributes parallel MySQL attack threads across 6 distinct TOR circuits to balance outbound network traffic.
* **Continuous Identity Mutation:** Pushes evasion to its "limits" through dynamic multi-IP TOR circuit rotations per request combined with automated UserAgent mutations on every concurrent thread.
* **Randomized Delay Insertion (Jitter):** Introduces unpredictable, non-linear time intervals between concurrent requests to destroy the traffic-pattern baselines of behavioral AI filters.

### Advanced WAF Bypass & Obfuscation
The engine deploys a **synchronized dual-vector parallel attack** that simultaneously probes MySQL time-based anomalies using multi-layered payload obfuscation and intelligent header injection, featuring:
* **Stacked Queries Injection:** Utilizes the stacked query technique (`;`) to terminate the application's original database query and force the independent execution of injected dynamic SQL statements.
* **HTTP Parameter Pollution (HPP) Splitting:** Injects duplicated query parameters with identical names (`param_name=999&param_name=payload`) to exploit parsing discrepancies between the front-end WAF and the back-end application server, effectively masking malicious database payloads behind benign values.
* **Payload Pen-Testing Masking:** Conceals detection signatures through randomized case conversion, space2comment encoding, XOR encryption, and Base64 encoding matrices.
* **Intelligent Header Injection:** Injects spoofed IP headers, Cloudflare bypass chains, and cache-control directives tailored specifically to complex URL parameter structures.
* **Protocol Exploitation:** Executes synchronized JA3/JA4 TLS Fingerprint Spoofing, HTTP/2 Rapid Reset Protocol Exploitation via a customizable high-concurrency window (defaulted to 50 concurrent streams), HTTP Chunked Transfer Encoding Mismatch, and Automated Control Loop Shadowban Evasion.

### Automated IP Re-Birth via TOR NEWNYM
To ensure uninterrupted execution against active threat mitigation systems, imcurvin integrates an automated defensive evasion loop:
* **Block Detection:** If the target infrastructure responds with a block status (such as HTTP 403 Forbidden or 429 Too Many Requests), the engine dynamically triggers a "SIGNAL NEWNYM" instruction across the active port array.
* **Instant Rotation:** Instantiates an immediate circuit teardown and rebuild, rotating the outbound exit node mapping within milliseconds without interrupting the primary multi-threaded attack vector.

### Post-Scan Validation Engine
* **Latency Isolation:** Every time-based anomaly generated during the attack is filtered by a specialized post-scan Python validation engine designed to isolate baseline network latency from genuine database thread delays.
* **Environment Safeguard:** The framework detects non-MySQL environments and aborts execution to prevent "resource wastage".

### Requirements:
* tor
* xxd
* curl
* coreutils
* python3 (for Git installation)

Detailed information can be found in the main repository

### Source: 
[https://github.com/Skokoo/ImCurvin](https://github.com/Skokoo/ImCurvin)

### Legal Disclaimer
This tool is developed for educational purposes and authorized penetration testing only. 
The developer assumes no liability and is not responsible for any misuse, damage, or legal consequences caused by this tool. 
Usage on unauthorized targets is strictly illegal.
    """,
    long_description_content_type="text/markdown",
    url="https://github.com/Skokoo/ImCurvin",
    project_urls={
        "Homepage": "https://github.com/Skokoo/ImCurvin",
    },
    packages=find_packages(),
    include_package_data=True,
    package_data={
        "Imcurvin": ["*.sh", "*.txt", "*.py"],
        "data": ["*.txt"],
        "tamper": ["*.sh"],
        "validators": ["*.py"],
    },
    entry_points={
        "console_scripts": [
            "imcurvin=Imcurvin.cli:main", 
        ],
    },
    classifiers=[
        "Development Status :: 4 - Beta",
        "Intended Audience :: Information Technology",
        "License :: OSI Approved :: Apache Software License",
        "Operating System :: POSIX :: Linux",
        "Programming Language :: Unix Shell",
        "Programming Language :: Python :: 3",
        "Topic :: Security",
    ],
    zip_safe=False,
)
