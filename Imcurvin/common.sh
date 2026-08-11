# ImCurvin 1.3.0
# Copyright 2026 Skokoo
# Licensed under the Apache 2.0

# Sourced to Defiancscan.sh
# This module encapsulates fundamental generic functionalities, including search engine dorking optimization, HTTP Parameter Pollution (HPP) matrices, and the global command-line assistance framework (-h, -tech).
#
# Notwithstanding its rudimentary nature, it remains structurally imperative for the underlying operational pipeline. It is what it is.
# Code starts:

print_defiance_logo(){
  echo -e "    \e[38;5;45m____        \e[38;5;39m______           \e[38;5;27m_                 \e[0m"
  echo -e "   \e[38;5;45m/  _/___ ___ \e[38;5;39m/ ____/_  _______\e[38;5;27m(_)___  ____ _    \e[0m"
  echo -e "   \e[38;5;51m/ // __ \`__ \\\\\e[38;5;45m/ /   / / / / __\e[38;5;39m_/ / __ \\\\/ __ \` /    \e[0m"
  echo -e " \e[38;5;51m_/ // / / / / \e[38;5;45m/ /___/ /_/ / /  \e[38;5;39m/ / / / / /_/ /     \e[0m"
  echo -e "\e[38;5;51m/___/_/ /_/ /_/\e[38;5;51m\\\\____/\\__,_/_/  \e[38;5;45m/_/_/ /_/\\__, /      \e[0m"
  echo -e "                                       \e[38;5;39m/____/       \e[0m"
  echo -e "\n[*] ImCurvin in the curve curing ;]"
 echo -e "[*] \e[1mPLEASE NOTE:\e[0m ImCurvin is optimized ONLY for \e[1mMySQL environments that allow multi-statement execution (Stacked Queries), and requires specific database privileges.\e[0m"
  if termux-am >/dev/null 2>&1; then
    echo -e "\e[38;5;196m[i] SYSTEM NOTICE (TERMUX):\e[0m If you zoom in excessively and experience layout tearing, please zoom out to restore interface alignment.\e[0m"
  fi
}

curl() {
    local args
    args=("$@")
    command curl ${args[@]}
}

braindamage() {
  local choice=$((RANDOM % 3))
  local cf_ray
  cf_ray=$(cat /dev/urandom | tr -dc 'a-f0-9' | fold -w 16 | head -n 1)

  if [ "${REQ_METHOD:-POST}" = "GET" ]; then
    case "$choice" in
      0) echo "-H \"Content-Type:application/json\" -H \"X-Forwarded-For:127.0.0.1\" -H \"CF-Connecting-IP:172.67.$((RANDOM % 254 + 1)).$((RANDOM % 254 + 1))\" -H \"CF-RAY:${cf_ray}-CGK\"" ;;
      1) echo "-H \"Content-Type:application/json\" -H \"CF-Visitor:{\\\"scheme\\\":\\\"https\\\"}\"" ;;
      2) echo "-H \"Content-Type:application/json\" -H \"X-WAF-Bypass:True\" -H \"CF-IPCountry:US\" -H \"True-Client-IP:103.21.244.$((RANDOM % 254 + 1))\"" ;;
    esac
  else
    case "$choice" in
      0) echo "-H \"Content-Type:application/json\" -H \"Authorization:Bearer $cf_ray\" -H \"X-WAF-Bypass:True\" -H \"CF-IPCountry:US\"" ;;
      1) echo "-H \"Content-Type:application/json\" -H \"X-Requested-With:XMLHttpRequest\" -H \"CF-RAY:${cf_ray}-CGK\" -H \"True-Client-IP:103.21.244.$((RANDOM % 254 + 1))\"" ;;
      2) echo "-H \"Content-Type:application/json\" -H \"Cache-Control:no-cache,no-store\" -H \"Pragma:no-cache\" -H \"X-Forwarded-For:127.0.0.1\"" ;;
    esac
  fi
}

dork() {
  local ayamaa
  ayamaa=$(date +%H:%M:%S)
  local dom
  dom="$1"
  echo -e "[\033[34m${ayamaa}\033[0m] [i] Launching Google Dorking..."
  sleep 2

  local gerbang
  gerbang=${TOR_CIRCUITS[$RANDOM % ${#TOR_CIRCUITS[@]}]}

    local prx="--socks5-hostname 127.0.0.1:$gerbang"

    local samaran
    samaran=${DEFIANCE_UA[$RANDOM % ${#DEFIANCE_UA[@]}]}
      local q
      q="site:${dom} (intitle:\"login\" inurl:\"login\") OR inurl:search OR inurl:api OR inurl:v1"

      local enc
      enc=$(python3 -c "import urllib.parse; print(urllib.parse.quote('''$q'''))")

      local raw
      raw=$(curl "$prx" -s -m 10 -A "$samaran" "https://google.com{enc}&gbv=1")

      local -a list
      while read -r line; do
        if [[ -n "$line" ]]; then
          local decoded_line
          decoded_line=$(python3 -c "import urllib.parse; print(urllib.parse.unquote('''$line'''))")
          if [[ "$decoded_line" == *"$dom"* ]]; then list+=("$decoded_line"); fi
        fi
      done < <(echo "$raw" | grep -oP '(?<=url\?q=)[^&]*' | sort -u | head -n 10)

      if [ ${#list[@]} -eq 0 ]; then
        echo -e "[\033[34m${ayamaa}\033[0m] [\033[31m-\033[0m]\e[0m No links found on Google Index." >&2
        exit 1
      fi

      echo -e "\n[\033[34m${ayamaa}\033[0m] [\033[1;34m+\033[0m] Top ${#list[@]} Discovered Targets:"
      for i in "${!list[@]}"; do echo -e "[\e[1;34m$((i+1))\e[0m] ${list[$i]}"; done

      echo -n -e "\n\e[0;32m[?]\e[0m Select target (1-${#list[@]}) or 's' to skip: "
      read -r -n 1 sel
      echo ""

      sel=$(echo "$sel" | tr '[:upper:]' '[:lower:]')

      if [[ "$sel" =~ ^[0-9]+$ ]] && [ "$sel" -le "${#list[@]}" ] && [ "$sel" -gt 0 ]; then
        local idx=$((sel - 1))
        export target_url="${list[$idx]}"
        echo -e "\e[0;32m[+]\e[0m Locked on: \e[1;34m$target_url\e[0m"
        echo -e "[\033[34m${ayamaa}\033[0m] [i] Testing connection to selected target..."

        local test_status
        test_status=$(curl "$prx" -s -o /dev/null -w "%{http_code}" --max-time 10 "$target_url")

        if [ "$test_status" = "000" ]; then
          echo -e "[\033[31m${ayamaa}\033[0m] [->] Selected URL connection timed out." >&2
          exit 1
        elif [ "$test_status" -lt 200 ] || [ "$test_status" -ge 400 ]; then
          echo -e "[\033[31m${ayamaa}\033[0m] [->] Target returned dead status: HTTP $test_status"  >&2
          exit 1
        fi

        echo -e "[\033[32m${ayamaa}\033[0m] [+] Target is alive (HTTP $test_status)."
        return 0
      else
        echo -e "[\033[31m${ayamaa}\033[0m] [x] Google Dorking skipped or invalid selection. Exiting tool."  >&2
        exit 1
      fi
    }                                       
                helping() {
          echo -e "->>\n"
          echo -e "Usage: imcurvin -u <TARGET_URL> [OPTION]\n"
          echo -e "Available Options:"
          echo -e "  -u/--url <URL>           : Specify the target website URL (Required)"
          echo -e "  -tech/--technique        : Display advanced technical methodologies and framework configurations (READ THIS IF YOU HAVE NOT YET, TO PREVENT UNINTENDED ACTIONS)"         
          echo -e "  -shwpld/--show-payload   : Show payloads actively during execution"
          echo -e "  -val/--validate          : Enable post-scan Python validation engine for latency isolation"
          echo -e "  -cookie=<string>         : Ingest custom session cookies (e.g., -cookie=\"PHPSESSID=123\")"
          echo -e "  -valnow/--validate-now   : Validate the log file now"
          echo -e "  -skip                    : Skipping \"Testing connection to target url\" (TESTING)"
          echo -e "  -h/--help                : Display this help guide"
          echo -e "\n->>"
          exit 0
        }
                show_tech() {

          echo -e "\n\e[34m1. Reconnaissance & Structural Parameter Extraction\e[0m"
          echo -e "   • \e[1mHybrid URL Parsing\e[0m     : PreFlight HTTP Redirection tracking & destination lock."
          echo -e "   • \e[1mGoogle Dorking Recon\e[0m   : Automated target attack surface expansion."
          echo -e "   • \e[1mMulti-Matrix Parser\e[0m    : RFC-compliant Query, Inline Path (;), & Heuristic Fallback extraction."
          echo -e "   • \e[1mRaw POST Interceptor\e[0m   : Automated detection of raw payload strings via TTY interactive hooks."
          echo -e "   • \e[1mHTML DOM Footprinting\e[0m  : Server-side token exclusion engine targeting form elements & data-* attributes.\n"

          echo -e "\e[34m2. Network Evasion & Tor Routing\e[0m"
          echo -e "   • \e[1mMulti-Port Tor Export\e[0m  : Eliminates bottleneck via multi-port arrays (9050, 9052+)."
          echo -e "   • \e[1mLoad-Balanced Request\e[0m  : Parallel threads distribution across 6 distinct Tor circuits."
          echo -e "   • \e[1mContinuous Mutation\e[0m    : Dynamic Multi-IP rotation & automated thread-level UserAgent mutation."
          echo -e "   • \e[1mJitter Insertion\e[0m     : Non-linear time delays to bypass behavioral AI traffic filters.\n"

          echo -e "\e[34m3. Advanced WAF Bypass & Obfuscation (Synchronized Dual-Vector Engine)\e[0m"
                    echo -e "   • \e[1mStacked Queries\e[0m      : In-memory dynamic statement compilation and execution via [;] delimiter."
          echo -e "   • \e[1mHPP Splitting\e[0m        : HTTP Parameter Pollution masking to exploit parser discrepancies."
          echo -e "   • \e[1mJSON-Header Tunneling\e[0m: Encapsulates Base64 payloads inside custom headers."
          echo -e "   • \e[1mPayload Masking\e[0m      : space2comment, randomized case, XOR, & Base64 matrix encoding."
          echo -e "   • \e[1mHeader Spoofing\e[0m      : Spoofed IP headers & Cloudflare bypass chain injection."
          echo -e "   • \e[1mCipher Suite Hardening\e[0m: Enforces strict TLS 1.3 & custom cipher negotiation matrices."
          echo -e "   • \e[1mProtocol Exploitation\e[0m: JA3/JA4 TLS Fingerprint Spoofing & HTTP/2 Rapid Reset vectors.\n"

          echo -e "\e[34m4. Automated IP Re-Birth (Defensive Evasion Loop)\e[0m"
          echo -e "   • \e[1mBlock Detection\e[0m      : Monitors HTTP 403/429 mitigation triggers."
          echo -e "   • \e[1mInstant Rotation\e[0m     : Automated 'SIGNAL NEWNYM' circuit rebuild within milliseconds.\n"

          echo -e "\e[34m5. Post-Scan Validation & Benchmarking\e[0m"
          echo -e "   • \e[1mMicrosecond Telemetry\e[0m: Granular time_total auditing via low-level curl write-out bindings."
          echo -e "   • \e[1mLatency Isolation\e[0m    : Python-backed filter to isolate network jitter from true SQL delays."
          echo -e "   • \e[1mEnvironment Safeguard\e[0m: Non-MySQL footprint detection & automated thread abortion.\n"

          exit 0
        }                                       