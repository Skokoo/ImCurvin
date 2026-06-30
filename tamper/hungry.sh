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
    local bruh_batagror=$(echo "$bruh_pempekk" | sed -E "s/\b([a-zA-Z0-9_'-]+)\s*=\s*([a-zA-Z0-9_'-]+)\b/\1 BETWEEN \2 AND \2/g")
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
