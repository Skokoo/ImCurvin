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

Risk mode:
Mode yang lumayan melakukan sesuatu ke server.
1. Scan lebih protektif: Input pengguna jika error, maka tool akan berhenti atau minta konfirmasi pengguna( kecuali kamu pakai opsi -cnf )
2. Lebih cerdas: Scan mu tidak akan di biarkan langsung, scan mu akan di simpan di Targets.log, dimana akan di scan python untuk mendeteksi kemungkinan false positive, dan yang false positive akan di hapus.
3. Terbagi menjadi 3 bagian: ada Risk Default, Risk TimeBased, Risk gentle.
4. Deteksi WAF lebih minim: kombinasi, tool nya akan sleep lebih dari 5 detik. Bahkan ada yang sampe 10 detik, dan ip kamu akan di sembunyikan lewat tor, random agent, dll.
Rincian bagian:
1. Default Risk:
Mode ini akan mengscan dengan "hati hati", dia tidak akan seagresif default mode, dia akan malakukan scan secara hati hati. Dan sekarang dia bukan mengscan tapi seperti menembak.
2. Risk TimeBased:
Ini akan menghitung sebarapa lama server akan merespon, menggunakan sqli. Dan serangan ini di kombinasi kan dengan tamper (charencode,space2comment,dll). (lihat di screenshoot jika pensaran gimana proses nya).
3. Gentle part:
Mode ini akan menargetkan server dengan cara lemah lembut tapi memaksa. Dia akan mengscan secara lemah lembut, tapi dia akam memaksa server menjawab dan meng kasih tau path file asli nya dimana. Dia seperti orang tua, jika server nya nurut( memberi dia http 200 dan file path asli ) maka dia akan memberikan hadiah untuk server nya( sleep 10 detik ), jika tidak dia akan mengabaikan nya selama 6 detik saja.
