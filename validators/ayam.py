import sys
import re
import json
import collections
import ssl
import argparse
from datetime import datetime
from urllib.parse import urlparse, parse_qs, urlencode
from urllib.request import urlopen, Request

# ImCurvin' v1.3.0
# Copyright 2026 Skokoo
# Licensed under the Apache License, Version 2.0

class StructuralParameterExtractor:
    def __init__(self, target_url: str):
        self.raw_url = target_url.strip() if isinstance(target_url, str) else ""
        self.scheme = ""
        self.path = ""
        self.query = ""
        # OrderedDict is used to ensure parameter analysis matches the exact order of the original HTTP request.
        self.extracted_parameters = collections.OrderedDict()
        self.routing_type = "NO_PARAM"
        self.html_content = ""
        self.detected_method = "GET"
        self.is_raw_post_input = False
        
        self.headers = {
            'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36',
            'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8',
            'Accept-Language': 'en-US,en;q=0.9',
            'Cache-Control': 'no-cache',
            'Pragma': 'no-cache'
        }

    def _get_timestamp(self) -> str:
        return datetime.now().strftime("%H:%M:%S")

    def _ask_user_confirmation(self) -> bool:
        try:
            ts = self._get_timestamp()
            preview_payload = self.raw_url[:80] + "..." if len(self.raw_url) > 80 else self.raw_url
            
            sys.stderr.write(f"\n[\033[34m{ts}\033[0m] [\033[33m!\033[0m] Input detected as raw POST payload format.\n")
            sys.stderr.write(f"[\033[34m{ts}\033[0m] [\033[36mi\033[0m] Payload Preview: \033[37m{preview_payload}\033[0m\n")
            sys.stderr.write(f"[\033[34m{ts}\033[0m] [\033[33m?\033[0m] Do you want to process this data using POST method? (y/n): ")
            sys.stderr.flush()

            # Reading from /dev/tty guarantees direct terminal interaction even if stdin is being redirected from a piped file or output.
            with open('/dev/tty', 'r') as tty:
                choice = tty.readline().strip().lower()
                
            if choice in ['y', 'yes']:
                return True
            return False
        except Exception:
            # Fallback to True ensures the execution does not crash in non-POSIX environments (like Windows) where /dev/tty is unavailable.
            return True

    def _sanitize_and_enforce_scheme(self) -> bool:
        if not self.raw_url:
            return False
        # This pattern identifies key-value pairs (e.g., id=1&user=admin) to distinguish raw POST data from a standard URL string.
        if "=" in self.raw_url and "://" not in self.raw_url and not self.raw_url.startswith("http"):
            if self._ask_user_confirmation():
                self.is_raw_post_input = True
                return True
            else:
                ts = self._get_timestamp()
                sys.stderr.write(f"[\033[34m{ts}\033[0m] [\033[31m-\033[0m] Operation aborted by user.\n")
                return False

        working_url = self.raw_url
        if not re.match(r'^https?://', working_url, re.I):
            working_url = f"http://{working_url}"

        # Disabling SSL verification prevents connection drops when targeting local environments or sites with self-signed certificates.
        ssl_context = ssl.create_default_context()
        ssl_context.check_hostname = False
        ssl_context.verify_mode = ssl.CERT_NONE

        try:
            req = Request(working_url, headers=self.headers)
            with urlopen(req, timeout=5, context=ssl_context) as response:
                self.raw_url = working_url
                self.html_content = response.read().decode('utf-8', errors='ignore')
                return True
        except Exception:
            # Automatic protocol upgrade acts as a fallback mechanism for servers that reject plaintext HTTP connections entirely.
            if working_url.startswith("http://"):
                working_url = working_url.replace("http://", "https://", 1)
                try:
                    req = Request(working_url, headers=self.headers)
                    with urlopen(req, timeout=5, context=ssl_context) as response:
                        self.raw_url = working_url
                        self.html_content = response.read().decode('utf-8', errors='ignore')
                        return True
                except Exception:
                    pass
            return True

    def _execute_rfc_decomposition(self) -> bool:
        # Mock values simulate a standard structure so that subsequent parsing logic handles raw payloads seamlessly.
        if self.is_raw_post_input:
            self.scheme = "http"
            self.path = "/"
            self.query = self.raw_url
            return True
        try:
            parsed = urlparse(self.raw_url)
            self.scheme = parsed.scheme or "http"
            self.path = parsed.path or "/"
            self.query = parsed.query or ""
            return True
        except Exception:
            return False

    def _extract_standard_query_matrix(self) -> None:
        if not self.query:
            return
        try:
            # keep_blank_values=True ensures that parameters present in the URL without values (e.g., ?debug=) are not discarded.
            parsed_matrix = parse_qs(self.query, keep_blank_values=True, strict_parsing=False)
            for key, values in parsed_matrix.items():
                # Regex filtering isolates valid web parameter keys and ignores malicious or corrupted key names.      
                if re.match(r'\A[A-Za-z0-9_\-\[\]]+\Z', key):
                    self.extracted_parameters.setdefault(key, []).extend(values)
        except Exception:
            pass

    def _extract_raw_post_matrix(self) -> None:
        if self.extracted_parameters or not self.query:
            return
        try:
            # Manual split acts as a secondary parser fallback if standard library routines misinterpret non-standard POST payloads.
            pairs = self.query.split('&')
            for pair in pairs:
                if '=' in pair:
                    # split('=', 1) guarantees correct parsing when the parameter value itself contains nested = characters (e.g., base64 strings).            
                    key, val = pair.split('=', 1)
                    key = key.strip()
                    if re.match(r'\A[A-Za-z0-9_\-\[\]]+\Z', key):
                        self.extracted_parameters.setdefault(key, []).append(val)
        except Exception:
            pass

    def _extract_heuristic_fallback_matrix(self) -> None:
        if not self.query:
            return
        # Regex search recovers data from malformed query strings that break native URL parsers but still follow key=value formatting.
        fallback_regex = r"\b(?P<key>[A-Za-z0-9_\-\[\]]+)=(?P<val>[^&]*)"
        for match in re.finditer(fallback_regex, self.query):
            key = match.group("key")
            val = match.group("val")
            if key not in self.extracted_parameters:
                self.extracted_parameters.setdefault(key, []).append(val)

    def _extract_inline_path_matrix(self) -> None:
        if not self.path or self.path == "/":
            return
        # Matrix parameter parsing extracts inline configurations embedded in the URI path components (common in framework routers like Spring/Java).
        inline_regex = r";(?P<key>[A-Za-z0-9_\-\[\]]+)=(?P<val>[^;]*)"
        for match in re.finditer(inline_regex, self.path):
            key = match.group("key")
            val = match.group("val")
            self.extracted_parameters.setdefault(key, []).append(val)

    def _extract_html_form_parameters(self) -> bool:
        if not self.html_content:
            return False
        # Regular expressions target hidden input forms and dataset tags to uncover blind parameters used by client-side scripts.
        patterns = [
            r'<(?:input|textarea|select|button)[^>]*\bname=["\']([A-Za-z0-9_\-\[\]]+)["\']',
            r'<(?:form)[^>]*\bformaction=["\']([A-Za-z0-9_\-\[\]]+)["\']',
            r'data-(?P<key>[A-Za-z0-9_\-]+)=["\']'
        ]

        all_discovered = []
        for pattern in patterns:
            matches = re.findall(pattern, self.html_content, re.I)
            if matches:
                all_discovered.extend(matches)

        exclusions = r'^(?:_token|csrf|xsrf|token|captcha|timestamp|nonce|submit|true|false|null|undefined|void|return)$'
        found_any = False
        for key in all_discovered:
            if re.match(exclusions, key, re.I):
                continue
            if key not in self.extracted_parameters:
                self.extracted_parameters[key] = ["audit_mapped"]
                found_any = True
        return found_any

    def _verify_working_parameter(self) -> str:
        if not self.extracted_parameters:
            return "id"

        if self.is_raw_post_input:
            return list(self.extracted_parameters.keys())

        ssl_context = ssl.create_default_context()
        ssl_context.check_hostname = False
        ssl_context.verify_mode = ssl.CERT_NONE

        parsed_url = urlparse(self.raw_url)
        base_url = f"{self.scheme}://{parsed_url.netloc}{self.path}"

        for param in list(self.extracted_parameters.keys()):
            try:
                if self.detected_method == "POST":
                    test_data = urlencode({param: "1"}).encode('utf-8')
                    req = Request(base_url, data=test_data, headers=self.headers, method="POST")
                else:
                    test_url = f"{base_url}?{urlencode({param: '1'})}"
                    req = Request(test_url, headers=self.headers, method="GET")

                with urlopen(req, timeout=3, context=ssl_context) as res:
                    if res.getcode() == 200:
                        return param
            except Exception:
                continue

        keys = list(self.extracted_parameters.keys())
        return keys if keys else "id"

    def process(self) -> str:
        if not self._sanitize_and_enforce_scheme() or not self._execute_rfc_decomposition():
            return "NO_PARAM|NONE|NONE|NONE"

        self._extract_standard_query_matrix()
        self._extract_raw_post_matrix()
        self._extract_heuristic_fallback_matrix()
        self._extract_inline_path_matrix()

        if self.extracted_parameters:
            if self.is_raw_post_input:
                self.detected_method = "POST"
            else:
                self.detected_method = "GET"
        else:
            if self._extract_html_form_parameters():
                self.detected_method = "POST"

        if self.extracted_parameters:
            self.routing_type = "QUERY_PARAM"
            confirmed_param = self._verify_working_parameter()
            
            if isinstance(confirmed_param, list):
                confirmed_param = ",".join(confirmed_param)
                
            clean_path = re.sub(r';.*\Z', '', self.path)
            return f"{self.routing_type}|{clean_path}|{confirmed_param}|{self.detected_method}"

        return "NO_PARAM|NONE|NONE|NONE"

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Structural Parameter Extractor")
    parser.add_argument("-u", "--url", required=True, help="Target URL or Raw POST payload data")
    args = parser.parse_args()

    extractor = StructuralParameterExtractor(args.url)
    output_buffer = extractor.process()
    print(output_buffer)
        
            