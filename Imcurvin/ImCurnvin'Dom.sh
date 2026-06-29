#!/bin/bash

terminate_script() {
    echo -e "\e[0;33m[\e[0m-\e[0;33m]\e[0m Execution failed for an unknown reason."
    exit 1
}

if ! command -v curl &> /dev/null; then
    echo -e "\e[0;33m[\e[0m-\e[0;33m]\e[0m WARNING: 'curl' is not installed on your terminal."
    echo -e "\e[0;33m[\e[0m-\e[0;33m]\e[0m Please install curl first before running imCurvin'."
    terminate_script
fi

clear
echo -e "\e[0;34m[ImCurvin'] Version 1.0.0\e[0m"
echo ""
echo -e "\e[0;33m[\e[0m!\e[0;33m]\e[0m LEGAL WARNING: Running this scan on a website"
echo -e "without written permission is an ILLEGAL act and a violation of cyber law."
echo -n "[?] Do you understand this risk and wish to proceed? (y/n) "
echo ""
read -r user_agreement

if [[ "$user_agreement" != "y" && "$user_agreement" != "Y" ]]; then
    terminate_script
fi
# Welp, gimme cookie. Me hungry.
target_url=""
risk_mode="false"

while [[ "$#" -gt 0 ]]; do
    case "$1" in
        -u) target_url="$2"; shift 2 ;;
        -risk) risk_mode="true"; shift 1 ;;
        *) shift ;;
    esac
done

if [ -z "$target_url" ]; then
    echo -e "\e[0;33m[\e[0m-\e[0;33m]\e[0m URL not found. Input the url using the flag -u 'URL_NAME'"
    exit 1
fi
if [ "$risk_mode" = "true" ]; then
    echo -e "\e[0;33m[\e[0m!\e[0;33m]\e[0m Checking for TOR."
    
    tor_port="9050"
        if pgrep -x "tor" >/dev/null 2>&1; then
        echo -e "\e[0;32m[\e[0m=\e[0;32m]\e[0m Tor terminal service detected as active (Port $tor_port). Please note that this tool performs a default scan before risk mode."
    else
        echo -e "\e[0;33m[\e[0m-\e[0;33m]\e[0m WARNING: Tor terminal service is not detected/running."
        echo -e "\e[0;33m[\e[0m-\e[0;33m]\e[0m Run the command 'sudo systemctl start tor' or 'tor' in a new terminal."
        terminate_script
    fi
fi
echo ""
echo -e "\e[0;34m[\e[0m+\e[0;34m]\e[0m Starting standard scanning.."
echo ""

target_file_00="$target_url/.env"
echo -e "\e[0;34m[\e[0m+\e[0;34m]\e[0m Scanning $target_file_00"
curl -m 3 -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36" -H "X-Forwarded-For: 127.0.0.1" -Iv "$target_file_00" --stderr - | grep "< HTTP"
sleep $((1 + RANDOM % 3))

target_file_01="$target_url/.git/config"
echo -e "\e[0;34m[\e[0m+\e[0;34m]\e[0m Scanning $target_file_01"
curl -m 3 -A "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36" -H "X-Forwarded-For: 127.0.0.1" -Iv "$target_file_01" --stderr - | grep "< HTTP"
sleep $((1 + RANDOM % 3))

target_file_02="$target_url/config.json"
echo -e "\e[0;34m[\e[0m+\e[0;34m]\e[0m Scanning $target_file_02"
curl -m 3 -A "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36" -H "X-Forwarded-For: 127.0.0.1" -Iv "$target_file_02" --stderr - | grep "< HTTP"
sleep $((1 + RANDOM % 3))

target_file_03="$target_url/wp-config.php"
echo -e "\e[0;34m[\e[0m+\e[0;34m]\e[0m Scanning $target_file_03"
curl -m 3 -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:109.0) Gecko/20100101 Firefox/115.0" -H "X-Forwarded-For: 127.0.0.1" -Iv "$target_file_03" --stderr - | grep "< HTTP"
sleep $((1 + RANDOM % 3))

target_file_04="$target_url/configuration.yml"
echo -e "\e[0;34m[\e[0m+\e[0;34m]\e[0m Scanning $target_file_04"
curl -m 3 -A "Mozilla/5.0 (iPhone; CPU iPhone OS 16_5 like Mac OS X) AppleWebKit/605.1.15" -H "X-Forwarded-For: 127.0.0.1" -Iv "$target_file_04" --stderr - | grep "< HTTP"

echo -e "\e[0;33m[\e[0m?\e[0;33m]\e[0m Sleep selama 5 detik, untuk menghindari kecurigaan"
sleep 5
target_file_05="$target_url/appsettings.json"
echo -e "\e[0;34m[\e[0m+\e[0;34m]\e[0m Scanning $target_file_05"
curl -m 3 -A "Mozilla/5.0 (iPad; CPU OS 16_5 like Mac OS X) AppleWebKit/605.1.15" -H "X-Forwarded-For: 127.0.0.1" -Iv "$target_file_05" --stderr - | grep  "< HTTP"
sleep $((1 + RANDOM % 3))

target_file_06="$target_url/secret.txt"
echo -e "\e[0;34m[\e[0m+\e[0;34m]\e[0m Scanning $target_file_06"
curl -m 3 -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36 Edg/114.0.1823.67" -H "X-Forwarded-For: 127.0.0.1" -Iv "$target_file_06" --stderr - | grep "< HTTP"
sleep $((1 + RANDOM % 3))

target_file_07="$target_url/backup.sql"
echo -e "\e[0;34m[\e[0m+\e[0;34m]\e[0m Scanning $target_file_07"
curl -m 3 -A "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.5 Safari/605.1.15" -H "X-Forwarded-For: 127.0.0.1" -Iv "$target_file_07" --stderr - | grep "< HTTP"
sleep $((1 + RANDOM % 3))

target_file_08="$target_url/.env.production"
echo -e "\e[0;34m[\e[0m+\e[0;34m]\e[0m Scanning $target_file_08"
curl -m 3 -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36" -H "X-Forwarded-For: 127.0.0.1" -Iv "$target_file_08" --stderr - | grep "< HTTP"
sleep $((1 + RANDOM % 3))

target_file_09="$target_url/.git/HEAD"
echo -e "\e[0;34m[\e[0m+\e[0;34m]\e[0m Scanning $target_file_09"
curl -m 3 -A "Mozilla/5.0 (Windows NT 10.0; WOW64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/113.0.5672.127 Safari/537.36" -H "X-Forwarded-For: 127.0.0.1" -Iv "$target_file_09" --stderr - | grep "< HTTP"

echo -e "\e[0;33m[\e[0m?\e[0;33m]\e[0m Sleep for 5 seconds, to avoid suspicion"
sleep 5

target_file_10="$target_url/composer.json"
echo -e "\e[0;34m[\e[0m+\e[0;34m]\e[0m Scanning $target_file_10"
curl -m 3 -A "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:109.0) Gecko/20100101 Firefox/113.0" -H "X-Forwarded-For: 127.0.0.1" -Iv "$target_file_10" --stderr - | grep "< HTTP"
sleep $((1 + RANDOM % 3))
target_file_11="$target_url/config/database.php"
echo -e "\e[0;34m[\e[0m+\e[0;34m]\e[0m Scanning $target_file_11"
curl -m 3 -A "Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Mobile Safari/537.36" -H "X-Forwarded-For: 127.0.0.1" -Iv "$target_file_11" --stderr - | grep "< HTTP"
sleep $((1 + RANDOM % 3))

target_file_12="$target_url/package.json"
echo -e "\e[0;34m[\e[0m+\e[0;34m]\e[0m Scanning $target_file_12"
curl -m 3 -A "Mozilla/5.0 (Windows NT 11.0; Win64; x64) AppleWebKit/537.36" -H "X-Forwarded-For: 127.0.0.1" -Iv "$target_file_12" --stderr - | grep "< HTTP"
sleep $((1 + RANDOM % 3))

target_file_13="$target_url/db.sql"
echo -e "\e[0;34m[\e[0m+\e[0;34m]\e[0m Scanning $target_file_13"
curl -m 3 -A "Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36" -H "X-Forwarded-For: 127.0.0.1" -Iv "$target_file_13" --stderr - | grep "< HTTP"
sleep $((1 + RANDOM % 3))

target_file_14="$target_url/Dockerfile"
echo -e "\e[0;34m[\e[0m+\e[0;34m]\e[0m Scanning $target_file_14"
curl -m 3 -A "Mozilla/5.0 (Macintosh; Intel Mac OS X 13_4) AppleWebKit/605.1.15" -H "X-Forwarded-For: 127.0.0.1" -Iv "$target_file_14" --stderr - | grep "< HTTP"

echo -e "\e[0;33m[\e[0m?\e[0;33m]\e[0m Sleep for 5 seconds, to avoid suspicion"
sleep 5

target_file_15="$target_url/.env.local"
echo -e "\e[0;34m[\e[0m+\e[0;34m]\e[0m Scanning $target_file_15"
curl -m 3 -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 Chrome/113.0.0.0 Safari/537.36 OPR/99.0.0.0" -H "X-Forwarded-For: 127.0.0.1" -Iv "$target_file_15" --stderr - | grep "< HTTP"
sleep $((1 + RANDOM % 3))

target_file_16="$target_url/.env.development"
echo -e "\e[0;34m[\e[0m+\e[0;34m]\e[0m Scanning $target_file_16"
curl -m 3 -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36" -H "X-Forwarded-For: 127.0.0.1" -Iv "$target_file_16" --stderr - | grep "< HTTP"
sleep $((1 + RANDOM % 3))
target_file_17="$target_url/dump.sql"
echo -e "\e[0;34m[\e[0m+\e[0;34m]\e[0m Scanning $target_file_17"
curl -m 3 -A "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36" -H "X-Forwarded-For: 127.0.0.1" -Iv "$target_file_17" --stderr - | grep "< HTTP"
sleep $((1 + RANDOM % 3))

target_file_18="$target_url/web.config"
echo -e "\e[0;34m[\e[0m+\e[0;34m]\e[0m Scanning $target_file_18"
curl -m 3 -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:109.0) Gecko/20100101 Firefox/115.0" -H "X-Forwarded-For: 127.0.0.1" -Iv "$target_file_18" --stderr - | grep "< HTTP"
sleep $((1 + RANDOM % 3))

target_file_19="$target_url/pm2.config.js"
echo -e "\e[0;34m[\e[0m+\e[0;34m]\e[0m Scanning $target_file_19"
curl -m 3 -A "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36" -H "X-Forwarded-For: 127.0.0.1" -Iv "$target_file_19" --stderr - | grep "< HTTP"

echo -e "\e[0;33m[\e[0m?\e[0;33m]\e[0m Sleep for 5 seconds, to avoid suspicion"
sleep 5

target_file_20="$target_url/docker-compose.yml"
echo -e "\e[0;34m[\e[0m+\e[0;34m]\e[0m Scanning $target_file_20"
curl -m 3 -A "Mozilla/5.0 (iPhone; CPU iPhone OS 16_5 like Mac OS X) AppleWebKit/605.1.15" -H "X-Forwarded-For: 127.0.0.1" -Iv "$target_file_20" --stderr - | grep "< HTTP"
sleep $((1 + RANDOM % 3))

target_file_21="$target_url/firebase.json"
echo -e "\e[0;34m[\e[0m+\e[0;34m]\e[0m Scanning $target_file_21"
curl -m 3 -A "Mozilla/5.0 (iPad; CPU OS 16_5 like Mac OS X) AppleWebKit/605.1.15" -H "X-Forwarded-For: 127.0.0.1" -Iv "$target_file_21" --stderr - | grep "< HTTP"
sleep $((1 + RANDOM % 3))

target_file_22="$target_url/credentials.json"
echo -e "\e[0;34m[\e[0m+\e[0;34m]\e[0m Scanning $target_file_22"
curl -m 3 -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36" -H "X-Forwarded-For: 127.0.0.1" -Iv "$target_file_22" --stderr - | grep "< HTTP"
sleep $((1 + RANDOM % 3))
target_file_23="$target_url/.git/index"
echo -e "\e[0;34m[\e[0m+\e[0;34m]\e[0m Scanning $target_file_23"
curl -m 3 -A "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36" -H "X-Forwarded-For: 127.0.0.1" -Iv "$target_file_23" --stderr - | grep "< HTTP"
sleep $((1 + RANDOM % 3))

target_file_24="$target_url/config.py"
echo -e "\e[0;34m[\e[0m+\e[0;34m]\e[0m Scanning $target_file_24"
curl -m 3 -A "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36" -H "X-Forwarded-For: 127.0.0.1" -Iv "$target_file_24" --stderr - | grep "< HTTP"

echo -e "\e[0;33m[\e[0m?\e[0;33m]\e[0m Sleep for 5 seconds, to avoid suspicion"
sleep 5

target_file_25="$target_url/settings.py"
echo -e "\e[0;34m[\e[0m+\e[0;34m]\e[0m Scanning $target_file_25"
curl -m 3 -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:109.0) Gecko/20100101 Firefox/115.0" -H "X-Forwarded-For: 127.0.0.1" -Iv "$target_file_25" --stderr - | grep "< HTTP"
sleep $((1 + RANDOM % 3))

target_file_26="$target_url/.env.sample"
echo -e "\e[0;34m[\e[0m+\e[0;34m]\e[0m Scanning $target_file_26"
curl -m 3 -A "Mozilla/5.0 (iPhone; CPU iPhone OS 16_5 like Mac OS X) AppleWebKit/605.1.15" -H "X-Forwarded-For: 127.0.0.1" -Iv "$target_file_26" --stderr - | grep "< HTTP"
sleep $((1 + RANDOM % 3))

target_file_27="$target_url/.vscode/settings.json"
echo -e "\e[0;34m[\e[0m+\e[0;34m]\e[0m Scanning $target_file_27"
curl -m 3 -A "Mozilla/5.0 (iPad; CPU OS 16_5 like Mac OS X) AppleWebKit/605.1.15" -H "X-Forwarded-For: 127.0.0.1" -Iv "$target_file_27" --stderr - | grep "< HTTP"
sleep $((1 + RANDOM % 3))

target_file_28="$target_url/id_rsa"
echo -e "\e[0;34m[\e[0m+\e[0;34m]\e[0m Scanning $target_file_28"
curl -m 3 -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36" -H "X-Forwarded-For: 127.0.0.1" -Iv "$target_file_28" --stderr - | grep "< HTTP"
sleep $((1 + RANDOM % 3))
target_file_29="$target_url/.npmrc"
echo -e "\e[0;34m[\e[0m+\e[0;34m]\e[0m Scanning $target_file_29"
curl -m 3 -A "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36" -H "X-Forwarded-For: 127.0.0.1" -Iv "$target_file_29" --stderr - | grep "< HTTP"

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

echo ""
echo -e "\e[0;32m[\e[0m=\e[0;32m]\e[0m Done. ImCurvin' Version: 1.0.0."

