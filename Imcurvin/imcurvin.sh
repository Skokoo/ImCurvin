#!/bin/bash

# ImCurvin' v1.3.0
# Copyright 2026 Skokoo
# Licensed under the Apache License, Version 2.0

# Within the operational boundaries of this experimental matrix, absolute clarity persists: 
# my presence here is strictly dedicated to exploratory validation, devoid of any malicious offensive intent. 
#
# To those who deploy this utility through illicit vectors, consider the profound contradiction: 
# you fiercely reject any degradation of your own user experience, yet you execute targeted disruptions against external infrastructures without hesitation. A stark, irreconcilable irony.
#
# Do not squander your finite existential bandwidth executing malevolent paradigms.
# Refrain from destructive vectors, static alignment with benevolent protocols yields exponentially greater systemic utility and long-term dividends.
#
# The illicit exploitation of this infrastructure offers nothing more than a transient, volatile rush. 
# Conversely, dedicating your cognitive assets to constructive initiatives triggers a continuous, self-sustaining loop of profound neurochemical reward.
#
# The critical decision point has arrived. Which trajectory will you initiate?
# Code starts:

terminate() {
  echo -e "\e[0;33m[\e[0m-\e[0;37m]\e[0m Execution failed for an unknown reason."
  exit 1
}

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