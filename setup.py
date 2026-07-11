from setuptools import setup, find_packages

setup(
    name="imcurvin",
    version="1.2.0",
    license='Apache 2.0',
    author="Skokoo",
    author_email="Skokoo@proton.me",
    description="Web security auditing tool with advanced evasion modes",
    
        long_description="""
## ImCurvin

***ImCurvin*** is an open-source, server-friendly web security auditing tool built for Termux and Linux environments to detect misconfigurations, probe backend vulnerabilities, and discover hidden endpoints. Powered by a flexible Bash core integrated with analytical Python engines, it features advanced multi-vector evasion techniques and adaptive scanning modes.

The framework offers three distinct operational modes:
* **Default Mode:** Performs baseline endpoint scanning using wordlist-driven reconnaissance. It randomizes User-Agents and utilizes built-in rate limiting to evade initial detection, making it ideal for target assessment.
* **Risk Mode:** Escalates reconnaissance by routing traffic through TOR circuits. It operates in a 3-stage sequence: Endpoint Discovery, Time-Based SQL Injection with custom tampering, and Gentle Probing via HTTP OPTIONS requests to harvest server metadata. Includes a Python post-scan validator to eliminate network-induced false positives.
* **Defiance Mode:** An aggressive, high-throughput engine optimized for MySQL time-based injection attacks. It features dual-vector parallel attacks with multi-port TOR circuit load-balancing, achieving true multi-IP rotation per request. Evasion is pushed to its limits using multi-layered tampers (XOR, Base64, and 2 advanced encodings) coupled with adaptive header injection for advanced WAF/CDN bypass. This mode implements an enhanced, highly accurate Python validation engine to isolate genuine database delays from baseline network latency.

> For a detailed breakdown of each operational mode and its technical implementation, please visit the repository and check the Mode.md file.

### Requirements:
* tor
* xxd
* curl
* coreutils
* python3 (for Git installation)

### Source: [https://github.com/Skokoo/ImCurvin](https://github.com/Skokoo/ImCurvin)
    """,
    long_description_content_type="text/markdown",
    url="https://github.com/Skokoo/ImCurvin",
    project_urls={
        "Homepage": "https://github.com/Skokoo/ImCurvin",
    },
    packages=find_packages(),
    include_package_data=True,
    package_data={
        "": ["data/*.txt", "Imcurvin/*.sh", "Imcurvin/*.txt", "tamper/*.sh", "validators/*.py"],
    },
    scripts=["Imcurvin/imcurvin.sh"],
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
