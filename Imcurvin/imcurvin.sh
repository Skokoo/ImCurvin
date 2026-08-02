#!/bin/bash
# ==============================================
# ImCurvin' v1.2.0
# Copyright 2026 Skokoo
# Licensed under the Apache License, Version 2.0
# ==============================================

terminate() {
  echo -e "\e[0;33m[\e[0m-\e[0;37m]\e[0m Execution failed for an unknown reason."
  exit 1
}

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