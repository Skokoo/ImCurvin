# ImCurvin'

![License](https://img.shields.io/badge/License-Apache%202.0-4EAA25?logo=apache&logoColor=white)
![Bash](https://img.shields.io/badge/Bash-5.2-4EAA25?logo=gnu-bash&logoColor=white)
![Python](https://img.shields.io/badge/Python-3.12-3776AB?logo=python&logoColor=white)

ImCurvin' is an open source web security auditing and penetration testing tool that automates the process of detecting environment misconfigurations, tracking exposed configuration blueprints, and probing backend infrastructures. It comes with a server friendly auditing engine designed to gracefully inspect target systems with a low impact approach that avoids crashing or disruption ("soft and gentle"), a broad range of custom time latency validation metrics to accurately pinpoint time based application flaw. ImCurvin' currently only have 3 mode: Default mode, risk mode, defiance mode. Default and Risk mode share the same thing, it is gentle but risk mode is more stealth and not that gentle.

Except for Defiance Mode, which acts as an aggressive, non server friendly engine executing MySQL specific time based operations. It achieves extreme parallel evasion strictly not through mass bandwidth flooding or a hardware DDoS match, but by exploiting core database thread execution logic flaws synchronizing a targeted, scoped 40 payload matrix across two asymmetric requests every 5 seconds (payload might be updated). This includes dynamic multi IP TOR rotations, automated User Agent mutations, 6 stage layered obfuscation, and continuous HTTP header pollution, all verified by a post scan Python validation engine to filter out network false positives. Despite traffic restrictions and a fast execution window under 2 minutes, the underlying database calculation load can still trigger extreme server CPU stress and temporary hardware latency. Dont forgot that defiance mode use time based, and targetting MySQL.

This project was engineered and debugged entirely on a smartphone using Termux. My pc is... I cant describe it.

# ScreenShot.
You can catch a full breakdown of the interface, outputs, and more. Check out the [Screenshots Gallery](screenshoots/ScreenShots.md).

# Installation & how to use.

You can download ImCurlin' by cloning the Git repository:
```bash
git clone --depth=1 https://github.com/Skokoo/ImCurvin
cd ImCurvin/Imcurvin
```
**Usage:**

Don't forget that you also need to download Python and curl (if not already installed) before using the tool. Before executing, make sure to grant the necessary execution rights first: 
```bash
chmod +x imcurvin.sh
```

To get a list of basic options 
```bash
./imcurvin.sh -h
```
If you want to explore all available options without running the help flag, head straight to the [Help Guide](UsrM.md) for a complete breakdown.

## Links

• [Legal Disclaimer](Imcurvin/Warning.txt)

• [Security Policy](SECURITY.md)

• [Guidelines & NOTE](Imcurvin/Note.txt)

• [Changelog & Updates](UPDATE_LOG.md)

• [License](LICENSE)

• [Contribution](CONTRIBUTING.md)
