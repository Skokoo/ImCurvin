#!/bin/bash
# ==============================================
# ImCurvin' v1.0.9
# Copyright 2026 Skokoo
# Licensed under the Apache License, Version 2.0
# ==============================================

terminate_script() {
    echo -e "\e[0;33m[\e[0m-\e[0;37m]\e[0m Execution failed for an unknown reason."
    exit 1
}

show_help() {
    echo -e "->>\n"
    echo -e "Usage: ./imcurvin.sh -u <TARGET_URL> [OPTION]\n"
    echo -e "Available option:"
    echo -e "  -u <URL>      : Specify the target website URL (Required)"
    echo -e "  -risk         : Enable 'Risk' Mode."
    echo -e "  -defiance     : Enable Defiance Mode (Agressive, extreme Parallel MySQL Strike)"
    echo -e "  -cnf          : Automode (Skip all confirmation prompts)"
    echo -e "  -str=risk     : Keep scanning files even after acquiring HTTP 200 (Risk Mode only)"
    echo -e "  -cmb          : Combined mode (Automatically execute Default Scan then Risk Scan)"
    echo -e "  -h            : Display this help guide"
    echo -e "  -proxy=<addr> : Route traffic through a custom proxy (e.g., http://127.0.0.1:8080)"
    echo -e "  -add=<path>   : Load a custom external wordlist path for the scan"
    echo -e "\n->>"
    exit 0
}

if ! command -v curl &> /dev/null; then
    echo -e "\e[0;33m[\e[0m-\e[0;37m]\e[0m WARNING: 'curl' is not installed on your terminal."
    echo -e "\e[0;33m[\e[0m-\e[0;37m]\e[0m Please install curl first before running imCurvin'."
    terminate_script
fi

for arg in "$@"; do
    if [ "$arg" = "-h" ]; then
        show_help
    fi
done

clear                                                                                                           
echo -e "\e[0;34m[ImCurvin'] Version 1.2.0\e[0m"
echo ""

defiance_check="false"
for arg in "$@"; do
    if [ "$arg" = "-defiance" ]; then
        defiance_check="true"
    fi
done

if [ "$defiance_check" = "false" ]; then
    echo -e "\e[0;33m[\e[0m!\e[0;37m]\e[0m LEGAL WARNING: Running this scan on a website"
    echo -e "without written permission is an ILLEGAL act and a violation of cyber law."
    echo -n -e "\e[0;33m[\e[0m?\e[0;37m]\e[0m Do you have explicit written consent from the target owner? (y/n) "
    echo ""

    skip_confirm="false"
    for arg in "$@"; do
        if [ "$arg" = "-cnf" ]; then
            skip_confirm="true"
        fi
    done

    if [ "$skip_confirm" = "true" ]; then
        user_agreement="y"
    else
        read -r user_agreement
    fi

    if [[ "$user_agreement" != "y" && "$user_agreement" != "Y" ]]; then
        terminate_script
    fi
fi

skip_confirm="false"
store_mode="false"
combine_mode="false"
risk_mode="false"
defiance_mode="false"
custom_proxy=""
custom_wordlist=""
target_url=""

while [[ "$#" -gt 0 ]]; do
    case "$1" in
        -u) target_url="$2"; shift 2 ;;
        -risk) risk_mode="true"; shift 1 ;;
        -defiance) defiance_mode="true"; shift 1 ;;
        -cnf) skip_confirm="true"; shift 1 ;;
        -str=risk) store_mode="true"; shift 1 ;;
        -proxy=*) custom_proxy="${1#*=}"; shift 1 ;;
        -add=*) custom_wordlist="${1#*=}"; shift 1 ;;
        -cmb) combine_mode="true"; shift 1 ;;
        -h) show_help ;;
        *) shift ;;
    esac
done

if [ -z "$target_url" ]; then
    echo -e "\e[0;33m[\e[0m-\e[0;37m]\e[0m URL not found. Input the url using the flag -u 'URL_NAME'"
    exit 1
fi

script_dir="$(dirname "$0")"

if [ "$defiance_mode" = "true" ]; then
    if [ -f "$script_dir/Defiancescan.sh" ]; then
        export custom_wordlist
        export custom_proxy
        export skip_confirm

        chmod +x "$script_dir/Defiancescan.sh"
        source "$script_dir/Defiancescan.sh" "$target_url"
        echo ""
        echo -e "\e[0;32m[\e[0m=\e[0;32m]\e[0m Ending. ImCurvin' Version: 1.2.0."
        exit 0
    else
        echo -e "\e[0;33m[\e[0m-\e[0;37m]\e[0m ERROR: Defiancescan.sh missing."
        exit 1
    fi
fi

if [ "$combine_mode" = "true" ]; then
    risk_mode="true"
fi

if [ "$risk_mode" = "true" ]; then
    echo -e "\e[0;33m[\e[0m!\e[0;37m]\e[0m Checking for TOR."
    tor_port="9050"
    if pgrep -x "tor" >/dev/null 2>&1; then
        echo -e "\e[0;32m[\e[0m=\e[0;32m]\e[0m Tor terminal service detected as active (Port $tor_port)."
    else
        echo -e "\e[0;33m[\e[0m-\e[0;37m]\e[0m WARNING: Tor terminal service is not detected/running."
        echo -e "\e[0;33m[\e[0m-\e[0;37m]\e[0m Run the command 'sudo systemctl start tor' or 'tor' in a new terminal."

        terminate_script() {
            echo -e "\e[0;33m[\e[0m-\e[0;37m]\e[0m Operation aborted due to environment mismatch."
            exit 1
        }
        terminate_script
    fi
fi

if [ "$risk_mode" = "false" ] || [ "$combine_mode" = "true" ]; then
    if [ -f "$script_dir/default_scan.sh" ]; then
        source "$script_dir/default_scan.sh"
    else
        echo -e "\e[0;33m[\e[0m-\e[0;37m]\e[0m ERROR: default_scan.sh missing."
        exit 1
    fi
fi

if [ "$risk_mode" = "true" ]; then
    if [ -f "$script_dir/risk_scan.sh" ]; then
        export skip_confirm
        export store_mode
        export combine_mode
        export custom_proxy
        export custom_wordlist
        source "$script_dir/risk_scan.sh"
    else
        echo -e "\e[0;33m[\e[0m-\e[0;37m]\e[0m ERROR: risk_scan.sh missing."
        exit 1
    fi
fi

echo ""
echo -e "\e[0;32m[\e[0m=\e[0;32m]\e[0m Ending. ImCurvin' Version: 1.2.0."

 
        
        