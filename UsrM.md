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
Tool ini punya 2 mode berbeda, yaitu default dan risk. Dan ini sudah jelas pasti beda.
Berikut perbedaan risk dan default mode:

Default mode:
1. Hanya mengscan biasa saja tanpa fitur tambahan.
2. Scan ini hanya mengandalkan agent acak agar tidak mudah terdeteksi, dan sedikit jeda waktu. (hanya jeda 2-5 detik saja)
3. Proses scan nya lebih cepat dari pada risk mode.
Keuntungan default mode:
• Tidak terlalu harmful karna hanya scan biasa.
• Jeda waktu sedikit, jadi cepat scan nya.
Kekurangan:
• Kemungkinan false positive besar.
• Sangat mudah di blokir waf jika wad nya pintar.
• ip anda tidak tersembunyi.