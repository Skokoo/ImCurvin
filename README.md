# ImCurvin' 🔥

![License](https://img.shields.io/badge/License-Apache%202.0-4EAA25?logo=apache&logoColor=white)
![Bash](https://img.shields.io/badge/Bash-5.2-4EAA25?logo=gnu-bash&logoColor=white)
![Python](https://img.shields.io/badge/Python-3.12-3776AB?logo=python&logoColor=white)
![Platform](https://img.shields.io/badge/Platform-Termux%20%2F%20Linux-FF6B6B?logo=linux&logoColor=white)

## About ImCurvin'

**ImCurvin'** is an open-source MySQL penetration testing simulator designed for detecting environment misconfigurations, probing backend vulnerabilities, and executing dynamic SQL injection attacks. Built entirely on Termux for maximum accessibility.

The tool features multiple scanning modes—from stealthy baseline reconnaissance to aggressive parallel exploitation—each optimized for different target scenarios. It employs intelligent evasion techniques including UserAgent randomization, IP spoofing, rate-limiting, and payload obfuscation to avoid detection.

### Key Features
- 🎯 **Multi-mode scanning** - Default, Risk, Defiance, and Nerf modes
- 🔐 **Advanced SQLi detection** - Time-based and payload-obfuscated injection testing
- 🥸 **Evasion techniques** - UserAgent randomization, header spoofing, TOR routing
- ⚡ **Aggressive exploitation** - Parallel processing, extreme payload generation
- 🛡️ **Stealth-first approach** - Rate limiting, random delays, proxy support
- 🔧 **Highly customizable** - Custom wordlists, proxy configuration, skip confirmations

> **Built on Termux** - This entire project was engineered and debugged on a smartphone. No PC needed.

**For detailed information about each scanning mode, [click here](MODES.md)** 📖

---

## Installation & Usage

### Prerequisites
- `curl` - For HTTP requests
- `python3` - For payload validation
- `bash` - Shell scripting
- Optional: `tor` - For TOR-routed scanning (Risk/Defiance modes)

### Quick Start

Clone the repository:
```bash
git clone --depth=1 https://github.com/Skokoo/ImCurvin
cd ImCurvin/Imcurvin
```

Run the tool:
```bash
bash imcurvin.sh -u http://target.com -m default
```

View help:
```bash
bash imcurvin.sh -h
```

### Available Options
```
-u <URL>         : Target URL (Required)
-m <MODE>        : Scanning mode (default, risk, defiance, nerf)
-w <FILE>        : Custom wordlist path
-p <PROXY>       : Custom proxy address
-s               : Store all results (don't stop at first find)
-cnf             : Skip all confirmations
-h               : Show help message
```

---

## Scanning Modes Overview

| Mode | Aggression | Stealth | Best For |
|------|-----------|---------|----------|
| **Default** | Low | High | Initial reconnaissance |
| **Risk** | Medium | Medium | Vulnerability probing with TOR |
| **Defiance** | Extreme | Low | Aggressive exploitation |
| **Nerf** | High | Medium | Toned-down Defiance |

> **For comprehensive mode documentation, [see MODES.md](MODES.md)**

---

## Screenshots & Documentation

- **Interface & Output** - [View Screenshots](screenshoots/ScreenShots.md)
- **Full Help Guide** - [Command Reference](UsrM.md)
- **Mode Breakdown** - [Detailed Mode Guide](MODES.md)
- **Legal Disclaimer** - [Warning](Imcurvin/Warning.txt)
- **Guidelines** - [Important Notes](Imcurvin/Note.txt)

---

## Resources & Links

- 📋 [Security Policy](SECURITY.md)
- 📝 [Changelog & Updates](UPDATE_LOG.md)
- ⚖️ [License - Apache 2.0](LICENSE)
- 🤝 [Contributing Guidelines](CONTRIBUTING.md)
- ⚠️ [Legal Disclaimer](Imcurvin/Warning.txt)

---

## Important Notes

⚠️ **Legal Warning**: Running this tool on websites without explicit written permission is **illegal** and violates cybersecurity laws. Always obtain written consent before testing.

✅ **Educational Use Only**: ImCurvin' is designed for authorized penetration testing and security research on systems you own or have permission to test.

---

## Contributing

Want to improve ImCurvin'? Check out [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines on submitting issues, features, and pull requests.

---

## License

ImCurvin' is licensed under the **Apache License 2.0**. See [LICENSE](LICENSE) for details.

---

**Built with ❤️ on Termux by [Skokoo](https://github.com/Skokoo)**
