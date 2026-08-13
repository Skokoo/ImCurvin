# Copyright 2026 Skokoo
# Licensed under the Apache License, Version 2.0

# Hey there, everyone.
# If you want me to incorporate AES, or other encryption algorithms like Camellia...
# Well, I don't really know, but I certainly love that kind of idea.

space2comment_engine() {
    local bruh_serabii="$1" 
    # Dual sed substitution transforms both spaces and encoded plus signs to break SQL injection signature filters globally.
    local bruh_cirengg=$(echo "$bruh_serabii" | sed 's/ /\/\*\*\//g' | sed 's/\+/\/\*\*\//g')
    echo "$bruh_cirengg" 
}

randomcase_engine() {
    local payload="$1"
    local result=""
    local length=${#payload}

    for (( i=0; i<length; i++ )); do
        local char="${payload:$i:1}"
        if [[ "$char" =~ [a-zA-Z] ]]; then
            # Modulo operation against Bash internal RANDOM variable creates an unpredictable 50/50 casing distribution to evade static WAF string rules.
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
        # Prefixed single quote force-interprets the character as its decimal ASCII integer equivalent for calculation.
        printf -v ascii_val "%d" "'$char"
        # Bitwise XOR operation obfuscates the byte against a fixed mask key before network transit.
        local xor_val=$(( ascii_val ^ key ))
        # Enforces a strict two-digit hexadecimal structure with leading zeros to maintain data stream alignment.
        printf -v hex_val "%02x" "$xor_val"
        output_hex="${output_hex}${hex_val}"
    done
    echo -n "$output_hex"
}

base64_engine() {
    local wow="$1"
    # Pipelining reverses raw hex bytes to binary stream before conversion, then strips newline formatting to ensure clean HTTP parameter injection.
    echo -n "$wow" | xxd -r -p | base64 | tr -d '\n'
}