#!/bin/bash
# ==============================================
# ImCurvin' v1.2.0
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
    echo -e "  -cnf          : Automode (Passed directly to Defiance)"
    echo -e "  -proxy=<addr> : Route traffic through a custom proxy (e.g., http://127.0.0.1:8080)"
    echo -e "  -add=<path>   : Load a custom external wordlist path for the scan"
    echo -e "  -nerf         : Nerf defiance mode payload a bit."
    echo -e "  -h            : Display this help guide"
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
echo ""

skip_confirm="false"
nerf_mode="false"
custom_proxy=""
custom_wordlist=""
target_url=""

while [[ "$#" -gt 0 ]]; do
    case "$1" in
        -u) target_url="$2"; shift 2 ;;
        -nerf) nerf_mode="true"; shift 1 ;;
        -cnf) skip_confirm="true"; shift 1 ;;
        -proxy=*) custom_proxy="${1#*=}"; shift 1 ;;
        -add=*) custom_wordlist="${1#*=}"; shift 1 ;;
        -h) show_help ;;
        *) shift ;;
    esac
done

if [ -z "$target_url" ]; then
    echo -e "\e[0;31m[\e[0m!\e[0;31m]\e[0m Error: URL not specified."
    echo -e "\e[0;37m[\e[0mmi\e[0;37m]\e[0m Please refer to the option guide below:\n"
    show_help
    exit 1
fi

if [ -f "./Imcurvin/Defiancescan.sh" ]; then
    script_dir="$(pwd)/Imcurvin"
elif [ -f "./Defiancescan.sh" ]; then
    script_dir="$(pwd)"
else
    script_dir=$(python3 -c "import os, sys; print(next((os.path.join(p, 'Imcurvin') for p in sys.path if os.path.exists(os.path.join(p, 'Imcurvin'))), ''))" 2>/dev/null)
fi

if [ -f "$script_dir/Defiancescan.sh" ]; then
    export custom_wordlist
    export custom_proxy
    export skip_confirm
    export nerf_mode
    source "$script_dir/Defiancescan.sh" "$target_url"
    echo ""
    exit 0
else
    echo -e "\e[0;33m[\e[0m-\e[0;37m]\e[0m Defiancescan.sh missing at $script_dir."
    exit 1
fi

echo -e "\e[0;32m[\e[0m=\e[0;32m]\e[0m Ending. ImCurvin' Version: 1.2.0."


    