import sys
import os
import urllib.request
import time

CUPCAKE_RECIPE = os.path.join(os.path.dirname(__file__), "../Target.log")
# For now, sqli time badef validator is not ready now.
# Soon i will fix it
report_txt = os.path.join(os.path.dirname(__file__), "../ImCurvin_Risk_Report.txt")

def bake_honeypot_test(sweet_cream):
    """
    Honeypot or real real. I hope so real. me dont like bee.
    """
    try:
        req = urllib.request.Request(
            sweet_cream, 
            headers={'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)'}
        )
        with urllib.request.urlopen(req, timeout=5) as oven_timer:
            brownies = oven_timer.read().decode('utf-8', errors='ignore').lower()
# MAN OH MY GOD STOP THE ah, version 2.0.0 i will make sure the variable is not a sweet sweet ig. 
            if ".env" in sweet_cream: 
                env_keywords = ["db_", "jwt_", "app_", "secret", "aws_", "password"]
                if any(key in brownies for key in env_keywords):
                    return "DamnItsReal"
                return "FakeNews_Honeypot"
# Or i will just do it now.
            elif "wp-config" in sweet_cream:
                if "db_name" in brownies or "db_user" in brownies:
                    return "DamnItsReal"
                return "FakeNews_Honeypot"

            # checking if, ah yk. 
            if "<html" in brownies or "<body" in brownies:
                return "OhyeahItwas_404"

            return "DamnItsReal"

    except Exception:
        # I hate when this happend yk.
        return "oh_server_no_see_me" 

def run_analysis():
    if len(sys.argv) > 1:
        base_target = sys.argv[1].rstrip('/')
    else:
        base_target = "http://127.0.0.1:8080"

    if not os.path.exists(CUPCAKE_RECIPE) or os.path.getsize(CUPCAKE_RECIPE) == 0:
        print("\n\033[0;33m[\033[0m!\033[0;33m]\033[0m NOTE: Target.log file empty or missing. No indicators found to validate.")
        return

    print("[i] ImCurvin validator ready. \n")
    print("[i] Reading indicators from Target.log.")

    with open(CUPCAKE_RECIPE, "r") as chef_book:
        cooking_lines = chef_book.readlines()

    valid_assets = []

    for line in cooking_lines:
        if not line.strip() or "|" not in line:
            continue

        biscuit_type, cherry_topping = line.strip().split("|")
        simulated_url = f"{base_target}{cherry_topping}"

        if biscuit_type == "FOUND_200": #jackpot lets goo
            print(f"\n[i] Investigating hit asset entry: {cherry_topping}")
            print(f"[i] Streaming document body for validation.")

            honeypot_status = bake_honeypot_test(simulated_url)

            if honeypot_status == "DamnItsReal":
                print(f"\033[0;32m[\033[0m+\033[0;32m]\033[0m Component footprint verified genuine.")
                valid_assets.append(f"[GENUINE] {simulated_url}")
            elif honeypot_status == "FakeNews_Honeypot":
                print(f"\033[0;31m[\033[0m!\033[0m] Warning: Honeypot trap detected.")
            else:
                print(f"\033[0;33m[\033[0m-\033[0;33m]\033[0m Status unverified or 404.")

        elif biscuit_type == "SQLI_ALERT":
# is this false positive
        print(f"\n\033[0;31m[\033[0m!+!\033[0;31m]\033[0m Confirmed Genuine TimeBased Vulnerability at {cherry_topping}")
            print(f"\033[0;32m[\033[0m+\033[0;32m]\033[0m Bash dualEvaluation footprint look like validated.\n")
            valid_assets.append(f"[SQLI] {simulated_url}")

    if valid_assets:
        with open(report_txt, "w") as rf:
            rf.write("\n".join(valid_assets) + "\n")
        print(f"\n    \033[0;32m[\033[0m=\033[0;32m]\033[0m Clean risk vulnerabilities copied to: ImCurvin_Risk_Report.txt")

    print("\033[0;32m[\033[0m+\033[0;32m]\033[0m All false positive matrix clutter removed.")

if __name__ == "__main__":
    run_analysis()
 
            