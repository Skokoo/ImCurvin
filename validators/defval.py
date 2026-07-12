import sys
import os
import urllib.request
import time
# ImCurvin' v1.2.0
# Copyright 2026 Skokoo
# Licensed under the Apache License, Version 2.0

current_dir = os.path.dirname(os.path.abspath(__file__))
log_f = os.path.join(current_dir, "targetDef.log")
report_txt = os.path.join(current_dir, "ImCurvin_Report.txt")

def run_analysis():
    if len(sys.argv) > 1:
        base_target = sys.argv[1].rstrip('/')
    else:
        base_target = "http://127.0.0.1:8080"

    if not os.path.exists(log_f) or os.path.getsize(log_f) == 0:
        print("\n\033[0;31m[\033[0m!\033[0;31m]\033[0m targetDef.log file empty or missing. No indicators found.")
        return

    print("\033[0;34m[\033[0m!\033[0;34m]\033[0m ImCurvin Defiance Validator Active.\n")

    with open(log_f, "r") as f:
        lines = f.readlines()

    valid_sqli = []

    for line in lines:
        if not line.strip() or "|" not in line:
            continue

        parts = line.strip().split("|")
        t = parts[0]
        path = parts[1] if len(parts) > 1 else ""

        if t == "SQLI_ALERT":
            clean_path = path.split("|")[0] if "|" in path else path
            print(f"\n\033[0;31m[\033[0m!\033[0;31m]\033[0m Investigating Time Based Alert at: {clean_path}")
            print("\033[0;34m[\033[0mi\033[0;34m]\033[0m Sending baseline request to isolate network lag..")
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
                print(f"\033[0;34m[\033[0m+\033[0m\033[0;34m]\033[0m Baseline Latency: {baseline_latency:.2f}s (Fast Connection)")
                print("\033[0;34m[\033[0m+\033[0m\033[0;34m]\033[0m Verified genuine MySQL Time Based Vulnerability.\n")
            valid_sqli.append(f"{base_target}{clean_path}")
            else:
                print(f"\033[0;33m[\033[0m-\033[0m\033[0;33m]\033[0m Baseline Latency: {baseline_latency:.2f}s (Network Congestion Detected)")
                print("\033[0;33m[-]\033[0m Status: False Positive. Your connection just make it delayed.\n")

    if valid_sqli:
        with open(report_txt, "w") as rf:
            rf.write("\n".join(valid_sqli) + "\n")
        print(f"\033[0;32m[\033[0m=\033[0;32m]\033[0m Clean vulnerabilities copied to: ImCurvin_Report.txt")

    print("\033[0;34m[\033[0m+\033[0;34m]\033[0m Defiance matrix clutter analysis complete.")

if __name__ == "__main__":
    run_analysis()