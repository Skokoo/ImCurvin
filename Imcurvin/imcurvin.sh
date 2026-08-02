#!/bin/bash
# ==============================================
# ImCurvin' v1.2.0
# Copyright 2026 Skokoo
# Licensed under the Apache License, Version 2.0
# ==============================================

  help() {
  echo -e "->>\n"
  echo -e "Usage: imcurvin -u <TARGET_URL> [OPTION]\n"
  echo -e "Available Options:"
  echo -e "  -u <URL>         : Specify the target website URL (Required)"
  echo -e "  -cnf             : Automode (Passed directly to Defiance)"
  echo -e "  -rec             : Run environment reconnaissance"
  echo -e "  -shwpld          : Show payloads actively during execution"
  echo -e "  -val             : Enable post-scan Python validation engine for latency isolation"
  echo -e "  -cookie=<string> : Ingest custom session cookies (e.g., -cookie=\"PHPSESSID=123\")"
  echo -e "  -proxy=<addr>    : Route traffic through a custom proxy (e.g., http://127.0.0.1:8080)"
  echo -e "  -h               : Display this help guide"
  echo -e "\n->>"
  exit 0
}
terminate() {
  echo -e "\e[0;33m[\e[0m-\e[0;37m]\e[0m Execution failed for an unknown reason."
  exit 1
}

if ! command -v curl &> /dev/null; then
  echo -e "\e[0;33m[\e[0m-\e[0;37m]\e[0m WARNING: 'curl' is not installed on your terminal."
  echo -e "\e[0;33m[\e[0m-\e[0;37m]\e[0m Please install curl first before running imCurvin'."
  terminate
fi

echo ""

skip_confirm="false"
custom_cookie=""
recon="false"
enable_val="false"
custom_wordlist=""
show_help="false"
target_url=""
payloadsi="false"
while [[ "$#" -gt 0 ]]; do
  case "$1" in
    -u) target_url="$2"; shift 2 ;;
    -shwpld) payloadsi="true"; shift 1 ;;
    -val) enable_val="true"; shift 1 ;;
    -rec) recon="true"; shift 1 ;;
    -cookie=*) custom_cookie="${1#*=}"; shift 1 ;;
    -cnf) skip_confirm="true"; shift 1 ;;
    -proxy=*) custom_proxy="${1#*=}"; shift 1 ;;
    -h) show_help="true"; shift 1 ;;
    *) shift ;;
  esac
done

if [[ "$show_help" = "true" ]]; then
help
fi
if [ -z "$target_url" ]; then
  echo -e "\e[0;31m[\e[0m!\e[0;31m]\e[0m Error: URL not specified."
  echo -e "\e[0;37m[\e[0mmi\e[0;37m]\e[0m Please refer to the option guide below:\n"
  help
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
  export custom_proxy
  export skip_confirm
  export show_help
  export custom_cookie
  export enable_val
  export recon
  export payloadsi
  source "$script_dir/Defiancescan.sh" "$target_url"
  echo ""
  exit 0
else
  echo -e "\e[0;33m[\e[0m-\e[0;37m]\e[0m Defiancescan.sh missing at $script_dir."
  exit 1
fi