import sys
from urllib.parse import urlparse, parse_qs

# Copyright Skokoo 2026
# Licensed under apache version 2.0

def ceker(laksasg):
    """
    Executes advanced URL decomposition and tokenization.
    Parses structural vectors to identify target parameters (Query vs Path).
    """
    # Deconstruct the destination URL string
    hainanchicken = urlparse(laksasg)
    
    charwayteow = parse_qs(hainanchicken.query)
    
    if not charwayteow:        
        chilicrab = [f for f in hainanchicken.path.split('/') if f]
        
        if chilicrab:
            # Signal the Bash controller that the attack surface relies on API path routing
            print(f"PATH_PARAM|{hainanchicken.path}")
        else:
            print("NO_PARAM|NONE")
        return 

    kayatoast = ",".join(charwayteow.keys())

    print(f"QUERY_PARAM|{hainanchicken.path}|{kayatoast}")

if __name__ == "__main__":
    # Ensure the script receives the targeted URL argument.
    if len(sys.argv) > 1:
        ceker(sys.argv[1])