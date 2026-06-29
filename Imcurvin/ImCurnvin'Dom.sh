#!/bin/bash
# ==============================================
# ImCurvin' v1.0.0
# Copyright 2026 Skokoo
# Licensed under the Apache License, Version 2.0
# ==============================================
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
script_dir="$(dirname "$0")"
if [ "$risk_mode" = "true" ]; then
    echo -e "\e[0;33m[\e[0m!\e[0;33m]\e[0m Checking for TOR."
    
    tor_port="9050"
        if pgrep -x "tor" >/dev/null 2>&1; then
        echo -e "\e[0;32m[\e[0m=\e[0;32m]\e[0m Tor terminal service detected as active (Port $tor_port)."
    else
        echo -e "\e[0;33m[\e[0m-\e[0;33m]\e[0m WARNING: Tor terminal service is not detected/running."
        echo -e "\e[0;33m[\e[0m-\e[0;33m]\e[0m Run the command 'sudo systemctl start tor' or 'tor' in a new terminal."
        terminate_script
    fi
fi
if [ "$risk_mode" = "false" ]; then
if [ -f "$script_dir/default_scan.sh" ]; then
    source "$script_dir/default_scan.sh"
else
    echo -e "\e[0;33m[\e[0m-\e[0;33m]\e[0m ERROR: default_scan.sh missing."
    exit 1
fi
fi
if [ "$risk_mode" = "true" ]; then
    if [ -f "$script_dir/risk_scan.sh" ]; then
        source "$script_dir/risk_scan.sh"
    else
        echo -e "\e[0;33m[\e[0m-\e[0;33m]\e[0m ERROR: risk_scan.sh missing."
        exit 1
    fi
fi
echo ""
echo -e "\e[0;32m[\e[0m=\e[0;32m]\e[0m Done. ImCurvin' Version: 1.0.0."

