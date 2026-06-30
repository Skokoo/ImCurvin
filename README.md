# ImCurvin'
![GitHub release (latest by date)](https://.img.shields.io/Skokoo/ImCurvin)
![GitHub license](https://shields.io)
![Static Badge](https://shields.io)
![Python](https://shields.io/Skokoo/ImCurvin)

ImCurvin' is an open source web security auditing and penetration testing tool that automates the process of detecting environment misconfigurations, tracking exposed configuration blueprints, and probing backend infrastructures. It comes with a server friendly auditing engine designed to gracefully inspect target systems with a low impact approach that avoids crashing or disruption ("soft and gentle"), a broad range of custom time latency validation metrics to accurately pinpoint time based application flaws, and a dual stage post scan verification architecture backed by Python intelligence to fully neutralize false positive honeypots.

# ScreenShot.
<p align="center">
  <img src="screenshoots/ImCurlinSS.jpg" alt="ImCurvin' RISK Mode v1.0.0 Dynamic Probing" width="400">
</p>
The showcase screenshot above is captured from the initial Version 1.0.0, and this is just a test. Running a TOR proxy mode just to curl a local server running on your own localhost (127.0.0.1:8080) makes no sense.

# Installation & how to use.

You can also download ImCurlin' by cloning the Git repository:
```bash
git clone --depth=1 https://github.com/Skokoo/ImCurvin
cd ImCurvin/Imcurvin
```

**Usage:**

Don't forget that you also need to download Python and curl (if not already installed) before using the tool. Before executing, make sure to grant the necessary execution rights first: 
```bash
chmod +x imcurvin.sh
```

To run default mode scan, use:
```bash
./imcurvin.sh -u "TARGET_URL"
```
To run risk mode scan, use:
```bash
./imcurvin.sh -u "TARGET_URL" -risk
```

## Links

• [Legal Disclaimer](Imcurvin/Warning.txt)

• [Security Policy](SECURITY.md)

• [Guidelines & NOTE](Imcurvin/Note.txt)

• [Changelog & Updates](UPDATE_LOG.md)

• [License](LICENSE)

