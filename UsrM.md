## Usage

```
[ImCurvin']

->>

Usage: ./imcurvin.sh -u <TARGET_URL> [OPTION]

Option:
-u <URL>    : Specify the target website URL (Required)
-risk       : Enable 'Risk' mode
-cnf        : Automode (Skip all confirmation prompts)
-str=risk   : Keep scanning files even after acquiring HTTP 200 (Risk Mode only)
-cmb        : Combined mode (Automatically execute Default Scan then Risk Scan)
-h          : Display this help guide
-proxy=<addr> : Route traffic through a custom proxy (e.g., http://127.0.0.1:8080)
-add=<path>   : Load a custom external wordlist path for the scan

->>
```

## Modes
This tool features two distinct operational profiles: **Default** and **Risk** modes. As expected, their behaviors and impacts differ significantly. Here is the breakdown of the differences between the two modes:

### Default Mode
The standard profile designed for basic, fast inspection without advanced features.

* **Behavior:** It relies entirely on a randomized user agent to avoid basic detection, combined with a minimal time throttling delay (only 2 to 5 seconds between requests).
* **Speed:** The scanning process is considerably faster than Risk Mode.

#### Pros:
* **Low Impact:** Less harmful and safer to run since it only performs a standard scan.
* **Fast Execution:** The minimal time delay ensures quick scan results.

#### Cons:
* **A chance of False Positives:** Increased likelihood of reporting inaccurate or inaccurate findings.
* **Easy to Block:** Easily detected and blocked if the target system utilizes an intelligent Web Application Firewall (WAF).
* **Exposed Identity:** Your actual IP address remains fully visible and is not hidden or proxied.

#### Best Suited For:
* Initial scouting and quick asset discovery.
* Auditing local staging environments or development servers without WAF restrictions.
* Fast scanning scenarios where speed is prioritized over high accuracy.

