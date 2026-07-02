import sys
from urllib.parse import urlparse, parse_qs

def eye_detector(url):
    parsed_url = urlparse(url)
    queries = parse_qs(parsed_url.query)
    
    if not queries:
        path_parts = [p for p in parsed_url.path.split('/') if p]
        if path_parts:
            print(f"PATH_PARAM|{parsed_url.path}")
        else:
            print("NO_PARAM|NONE")
        return

    param_list = ",".join(queries.keys())
    print(f"QUERY_PARAM|{parsed_url.path}|{param_list}")

if __name__ == "__main__":
    if len(sys.argv) > 1:
        eye_detector(sys.argv[1])