import sys
from curl_cffi import requests

def bye(url, proxy_port):
    proxies = {
        "http": f"socks5h://127.0.0.1:{proxy_port}",
        "https": f"socks5h://127.0.0.1:{proxy_port}"
    }
    response = requests.post(url, impersonate="chrome", proxies=proxies, timeout=12)
    print(f"{response.elapsed.total_seconds()}|{response.status_code}")

if __name__ == "__main__":
    bye(sys.argv[1], sys.argv[2])