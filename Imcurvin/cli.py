import os
import subprocess
import sys

def main():
    current_dir = os.path.dirname(os.path.abspath(__file__))
    script_path = os.path.join(current_dir, 'imcurvin.sh')
    for sh_file in ['imcurvin.sh', 'Defiancescan.sh', 'default_scan.sh', 'risk_scan.sh']:
        p = os.path.join(current_dir, sh_file)
        if os.path.exists(p):
            os.chmod(p, 0o755)
    try:
        subprocess.run(['bash', script_path] + sys.argv[1:], check=True)
    except subprocess.CalledProcessError as e:
        sys.exit(e.returncode)
    except KeyboardInterrupt:
        sys.exit(130)
