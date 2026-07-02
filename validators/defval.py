import sys
import os
import urllib.request
import time
# ImCurvin' v1.0.9
# Copyright 2026 Skokoo
# Licensed under the Apache License, Version 2.0
# Ah man, i was tried while making this. i hope no bug bug.
log_f = os.path.join(os.path.dirname(__file__), "../targetDef.log")

def run_analysis():
    if len(sys.argv) > 1:
        base_target = sys.argv[1].rstrip('/')
    else:
        base_target = "http://127.0.0.1:8080"

    if not os.path.exists(log_f) or os.path.getsize(log_f) == 0:
        print("\n\033[0;31m[\033[0m!\033[0m] targetDef.log file empty or missing. No indicators found.")
        return

    print("\033[0;34m[\033[0m!\033[0m] ImCurvin Defiance Validator Active.\n")

    with open(log_f, "r") as f:
        lines = f.readlines()

    for line in lines:
        if not line.strip() or "|" not in line:
            continue

        parts = line.strip().split("|")
        t = parts[0]
        path = parts[1] if len(parts) > 1 else ""

        if t == "FOUND_200":
            print(f"\033[0;34m[\033[0m+\033[0m] Found Vector 1 Discovery: {path}")

        elif t == "SQLI_ALERT":
            clean_path = path.split("|")[0] if "|" in path else path
            print(f"\n\033[0;31m[\033[0m!+!\033[0m] Investigating Time Based Alert at: {clean_path}")
            print("[i] Sending baseline request to isolate network lag...")
            u = f"{base_target}{clean_path}"
            req = urllib.request.Request(u, headers={'User-Agent': 'Mozilla/5.0'})

            start_t = time.time()
            try:
                with urllib.request.urlopen(req, timeout=8) as resp:
                    resp.read()
            except Exception:
                pass
            baseline_latency = time.time() - start_t
            if baseline_latency < 1.5:
                print(f"    \033[0;34m[\033[0m+\033[0m] Baseline Latency: {baseline_latency:.2f}s (Fast Connection)")
                print("\033[0;34m[\033[0m+\033[0m] Verified genuine MySQL Time Based Vulnerability.\n")
            else:
                print(f"    \033[0;33m[\033[0m-\033[0m] Baseline Latency: {baseline_latency:.2f}s (Network Congestion Detected)")
                print("\033[0;33m[\033[0m-\033[0m] Status: False Positive. Your connection just make it delayed.\n")

    print("\033[0;34m[\033[0m+\033[0m] Defiance matrix clutter analysis complete.")

if __name__ == "__main__":
    run_analysis()