#!/bin/bash
# Copyright 2026 Skokoo
# Licensed under the Apache License, Version 2.0

# i like /**/
space2comment_engine() {
    local bruh_serabii="$1" #food
    # Diperbaiki agar spasi asli digantikan sepenuhnya oleh komentar, tanpa menyisakan spasi kosong
    local bruh_cirengg=$(echo "$bruh_serabii" | sed 's/ /\/\*\*\//g')
    echo "$bruh_cirengg" #road
}

appendnullbyte_engine() {
    local bruh_putuu="$1"
    local bruh_duhduhduuudh="${bruh_putuu}%00"
    echo "$bruh_duhduhduuudh"
}
#So, uh. 1+1 is between 2 function.
between_engine() {
    local bruh_pempekk="$1" #rendang
    local bruh_batagror=$(echo "$bruh_pempekk" | sed -E "s/([a-zA-Z0-9_'-]+)=([a-zA-Z0-9_'-]+)/\1 BETWEEN \2 AND \2/g; s/([a-zA-Z0-9_'-]+)\+=([a-zA-Z0-9_'-]+)/\1+BETWEEN+\2+AND+\2/g")
    echo "$bruh_batagror"
} #OH YEAH MAN BETWEEN I LIKE TAMPER... Uh wait, tempe?

#Man i hate this part, food.
charencode_engine() {
    local bruh_baksow="$1"
    local bruh_siomayy=""
    local bruh_gettass=${#bruh_baksow}
    local dalam_petik=false

    for (( i=0; i<bruh_gettass; i++ )); do
        local bruh_kelepon="${bruh_baksow:$i:1}" # C language copy cat ngl

        if [[ "$bruh_kelepon" == "'" || "$bruh_kelepon" == '"' ]]; then
            if [ "$dalam_petik" = true ]; then
                dalam_petik=false
            else
                dalam_petik=true
            fi
            bruh_siomayy="${bruh_siomayy}${bruh_kelepon}"
            continue
        fi

        if [[ "$bruh_kelepon" =~ [a-zA-Z] ]] && [ "$dalam_petik" = true ]; then
            local bruh_getukk=$(printf "%d" "'$bruh_kelepon")
            bruh_siomayy="${bruh_siomayy}CHAR(${bruh_getukk})"
        else
            bruh_siomayy="${bruh_siomayy}${bruh_kelepon}"
        fi #phi
    done
    echo "$bruh_siomayy"
}
