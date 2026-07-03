#!/bin/bash
# Copyright 2026 Skokoo
# Licensed under the Apache License, Version 2.0

# i like /**/
space2comment_engine() {
    local bruh_serabii="$1" #food
    local bruh_cirengg=$(echo "$bruh_serabii" | sed 's/ /\/\*\*\//g' | sed 's/\+/\/\*\*\//g')
    echo "$bruh_cirengg" #road
}

appendnullbyte_engine() {
    local bruh_putuu="$1"
    local clean_payload=$(echo "$bruh_putuu" | sed 's/%00//g')
    local bruh_duhduhduuudh="${clean_payload}%00"
    echo "$bruh_duhduhduuudh"
}

between_engine() {
    local bruh_pempekk="$1" #rendang
    if echo "$bruh_pempekk" | grep -qE "=[A-Z]"; then
        local bruh_batagror="$bruh_pempekk"
    else
        local bruh_batagror=$(echo "$bruh_pempekk" | sed -E "s/\b([a-zA-Z0-9_'-]+)\s*=\s*([a-zA-Z0-9_'-]+)\b/\1 BETWEEN \2 AND \2/g")
    fi
    echo "$bruh_batagror"
} #OH YEAH MAN BETWEEN I LIKE TAMPER... Uh wait, tempe?



charencode_engine() {
    local bruh_baksow="$1"
    local bruh_siomayy=""
    local bruh_gettass=${#bruh_baksow}
    local fa_gao=false

    for (( i=0; i<bruh_gettass; i++ )); do
        local bruh_kelepon="${bruh_baksow:$i:1}" # C language copy cat ngl
        
        if [[ "$bruh_kelepon" == "'" || "$bruh_kelepon" == '"' ]]; then
            bruh_siomayy="${bruh_siomayy}${bruh_kelepon}"
            if [ "$fa_gao" = true ]; then
                fa_gao=false
            else
                fa_gao=true
            fi
            continue
        fi

        if [[ "$bruh_kelepon" =~ [a-zA-Z] ]] && [ "$fa_gao" = true ]; then
            local bruh_getukk=$(printf "%d" "'$bruh_kelepon")
            bruh_siomayy="${bruh_siomayy}CHAR(${bruh_getukk})"
        else
            bruh_siomayy="${bruh_siomayy}${bruh_kelepon}"
        fi #phi
    done
    echo "$bruh_siomayy"
}
randomcase_engine() {
    local payload="$1"
    local result=""
    local length=${#payload}

    for (( i=0; i<length; i++ )); do
        local char="${payload:$i:1}"
        if [[ "$char" =~ [a-zA-Z] ]]; then
            if (( RANDOM % 2 == 0 )); then
                result="${result}${char^^}"
            else
                result="${result}${char,,}"
            fi
        else
            result="${result}${char}"
        fi
    done
    echo "$result"
}
apostrophenullencode_engine() {
    local payload="$1"
    local obfuscated=$(echo "$payload" | sed "s/'/'%00/g")
    echo "$obfuscated"
}
xor_engine() {
    local input_str="$1"
    local key=137
    local output_hex=""
    
    for (( i=0; i<${#input_str}; i++ )); do
        local char="${input_str:$i:1}"
        printf -v ascii_val "%d" "'$char"
        local xor_val=$(( ascii_val ^ key ))
        printf -v hex_val "%02x" "$xor_val"
        output_hex="${output_hex}${hex_val}"
    done
    echo -n "$output_hex"
}

weirdcomment_engine() {
    local input_str="$1"
    local output_str=""
    local trash_words=("Skokoo" "ImCurvin" "Defiance" "Hahaha" "LolEasy" "WafImHere")
    
    for (( i=0; i<${#input_str}; i++ )); do
        local char="${input_str:$i:1}"
        output_str="${output_str}${char}"
        if [[ "$char" =~ [a-zA-Z0-9] ]] && (( RANDOM % 4 == 0 )); then
            local random_word=${trash_words[$RANDOM % ${#trash_words[@]}]}
            output_str="${output_str}/*${random_word}_$((RANDOM % 99))*/"
        fi
    done
    echo "$output_str"
}

base64_engine() {
    local wow="$1"
    echo -n "$wow" | base64 | tr -d '\n'
}
