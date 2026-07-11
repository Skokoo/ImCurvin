import os
import subprocess
import sys
# ImCurvin' v1.2.0
# Copyright 2026 Skokoo
# Licensed under the Apache License, Version 2.0
def main():
    current_dir = os.path.dirname(os.path.abspath(__file__))
    script_path = os.path.join(current_dir, 'imcurvin.sh')
    if not os.path.exists(script_path):
        parent_dir = os.path.dirname(current_dir)
        script_path = os.path.join(parent_dir, 'Imcurvin', 'imcurvin.sh')
    if os.path.exists(script_path):
        try:
            os.chmod(script_path, 0o755)
        except Exception:
            pass 
    try:
        subprocess.run(['bash', script_path] + sys.argv[1:], check=True)
    except subprocess.CalledProcessError as e:
        sys.exit(e.returncode)
    except KeyboardInterrupt:
        sys.exit(130)