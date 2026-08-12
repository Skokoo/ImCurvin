#!/bin/bash

# ImCurvin' v1.3.0
# Copyright 2026 Skokoo
# Licensed under the Apache License, Version 2.0

# This system is strictly for authorized testing and validation purposes.
# All operations must remain entirely non-malicious and constructive.
#
# Do not target external infrastructure. Protecting your own assets while 
# disrupting others is unacceptable and contradictory. 
#
# Cyberattacks offer only temporary gratification and waste critical time.
# Aligning with ethical protocols yields superior long-term results.
#
# Use your technical skills to build and secure systems, not destroy them.
# Choose a constructive professional path.
# Code starts:

echo ""

custom_cookie=""
enable_val="false"
show_help="false"
target_url=""
tech="false"
valnow="false"
skip="true"
payloadsi="false"
while [[ "$#" -gt 0 ]]; do
  case "$1" in
    -u|--url) target_url="$2"; shift 2 ;;
    -shwpld|--show-payload) payloadsi="true"; shift 1 ;;
    -tech|--technique) tech="true"; shift 1 ;;
    -val|--validate) enable_val="true"; shift 1 ;;
    -cookie=*|--cookie=*) custom_cookie="${1#*=}"; shift 1 ;;    
    -skip) skip="false"; shift 1 ;;
    -valnow|--validate-now) valnow="true"; shift 1 ;;
    -h|--help) show_help="true"; shift 1 ;;
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
  export skip_confirm
  export valnow
  export show_help
  export custom_cookie
  export enable_val
  export tech
  export payloadsi
  export skip
  source "$script_dir/Defiancescan.sh" "$target_url"
  echo ""
  exit 0
else
  echo -e "\e[0;33m[\e[0m-\e[0;37m]\e[0m Defiancescan.sh missing at $script_dir."
  exit 1
fi