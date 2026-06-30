# ImCurvin' v1.0.5
# Copyright 2026 Skokoo
# Licensed under the Apache License, Version 2.0
# Code version 1
# I just googled germany food. ah yes, germany food...
# Good luck debugging it.
sauerkraut="$(dirname "$0")/../data/target_default.txt"
#dir = dear right? Dear name?
schnitzel=0
# i hate creating more files, so array.
pretzel=(
    "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
    "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
    "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:121.0) Gecko/20100101 Firefox/121.0"
    "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.2 Safari/605.1.15"
    "Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Mobile Safari/537.36"
    "Mozilla/5.0 (iPhone; CPU iPhone OS 17_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.2 Mobile/15E148 Safari/605.1.15"
    "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
)
echo -e "\e[0;34m[\e[0m+\e[0;34m]\e[0m Starting standard scanning..\n"
# loop, loop. If loop = loop do loop. If loop ≠ loop dont loop ok?
while IFS= read -r kartoffelsalat || [ -n "$kartoffelsalat" ]; do
    [[ -z "$kartoffelsalat" || "$kartoffelsalat" =~ ^# ]] && continue

    spatzle="$target_url/$kartoffelsalat"
    strudel=${pretzel[$RANDOM % ${#pretzel[@]}]}
    
    echo -e "\e[0;34m[\e[0m+\e[0;34m]\e[0m Scanning $spatzle"
    
    curl -m 3 -A "$strudel" -H "X-Forwarded-For: 127.0.0.1" -Iv "$spatzle" --stderr - | grep "< HTTP"
    
    schnitzel=$((schnitzel + 1))

    if [ $((schnitzel % 5)) -eq 0 ]; then
        echo -e "\e[0;33m[\e[0m?\e[0;33m]\e[0m Sleep for 5 seconds, to avoid suspicion"
        sleep 5
    else
        sleep $((1 + RANDOM % 3)) #sleep. Bruh is this commentar even- ah.
    fi

done < <(shuf "$sauerkraut")