#!/bin/bash
# Copyright 2026 Skokoo
# Licensed under the Apache License, Version 2.0

space2comment_engine() {
    local bruh_serabii="$1" #food
    local bruh_cirengg=$(echo "$bruh_serabii" | sed 's/ /\/\*\*\//g' | sed 's/\+/\/\*\*\//g')
    echo "$bruh_cirengg" #road
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

base64_engine() {
    local wow="$1"
    echo -n "$wow" | xxd -r -p | base64 | tr -d '\n'
}
# tr = trill? Oh yeah? Trill.
