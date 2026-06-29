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
if [ -f "$script_dir/default_scan.sh" ]; then
    source "$script_dir/default_scan.sh"
else
    echo -e "\e[0;33m[\e[0m-\e[0;33m]\e[0m ERROR: default_scan.sh missing."
    exit 1
fi
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

