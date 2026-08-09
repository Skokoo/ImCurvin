import sys
import re
import json
import collections
import ssl
from urllib.parse import urlparse, parse_qs
from urllib.request import urlopen, Request

class StructuralParameterExtractor:
    def __init__(self, target_url: str):
        self.raw_url = target_url.strip() if isinstance(target_url, str) else ""
        self.scheme = ""
        self.path = ""
        self.extracted_parameters = collections.OrderedDict()
        self.routing_type = "NO_PARAM"
        self.html_content = ""

    def _sanitize_and_enforce_scheme(self) -> bool:
        if not self.raw_url:
            return False

        clean_base = re.sub(r'^\s*https?://', '', self.raw_url, flags=re.I)
        ssl_context = ssl.create_default_context()
        ssl_context.check_hostname = False
        ssl_context.verify_mode = ssl.CERT_NONE
        
        headers = {
            'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36',
            'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8',
            'Accept-Language': 'en-US,en;q=0.9',
            'Cache-Control': 'no-cache',
            'Pragma': 'no-cache'
        }

        test_url = f"http://{clean_base}"
        try:
            req = Request(test_url, headers=headers)
            with urlopen(req, timeout=5, context=ssl_context) as response:
                self.raw_url = test_url
                self.html_content = response.read().decode('utf-8', errors='ignore')
                return True
        except Exception:
            self.raw_url = f"https://{clean_base}"
            try:
                req = Request(self.raw_url, headers=headers)
                with urlopen(req, timeout=5, context=ssl_context) as response:
                    self.html_content = response.read().decode('utf-8', errors='ignore')
            except Exception:
                pass
            return True

    def _execute_rfc_decomposition(self) -> bool:
        try:
            parsed = urlparse(self.raw_url)
            self.scheme = parsed.scheme
            self.path = parsed.path or "/"
            self.query = parsed.query or ""
            return True
        except Exception:
            return False

    def _extract_standard_query_matrix(self) -> None:
        if not self.query:
            return
        try:
            parsed_matrix = parse_qs(self.query, keep_blank_values=True, strict_parsing=False)
            for key, values in parsed_matrix.items():
                if re.match(r'\A[A-Za-z0-9_\-\[\]]+\Z', key):
                    self.extracted_parameters.setdefault(key, []).extend(values)
        except Exception:
            pass

    def _extract_heuristic_fallback_matrix(self) -> None:
        if not self.query:
            return
        fallback_regex = r"\b(?P<key>[A-Za-z0-9_\-\[\]]+)=(?P<val>[^&]*)"
        for match in re.finditer(fallback_regex, self.query):
            key = match.group("key")
            val = match.group("val")
            if key not in self.extracted_parameters:
                self.extracted_parameters.setdefault(key, []).append(val)

    def _extract_inline_path_matrix(self) -> None:
        if not self.path or self.path == "/":
            return
        inline_regex = r";(?P<key>[A-Za-z0-9_\-\[\]]+)=(?P<val>[^;]*)"
        for match in re.finditer(inline_regex, self.path):
            key = match.group("key")
            val = match.group("val")
            self.extracted_parameters.setdefault(key, []).append(val)

    def _extract_html_form_parameters(self) -> None:
        if not self.html_content:
            return
            
        patterns = [
            r'<(?:input|textarea|select|button|form)[^>]*\b(?:name|formaction)=["\']([A-Za-z0-9_\-\[\]]+)["\']',
            r'["\'](?P<key>[A-Za-z0-9_\-]{2,30})["\']\s*:\s*["\'][^"\']*["\']',
            r'\b(?:var|let|const)\s+([A-Za-z0-9_\-]+)\s*=',
            r'data-(?P<key>[A-Za-z0-9_\-]+)=["\']'
        ]
        
        all_discovered = []
        for pattern in patterns:
            matches = re.findall(pattern, self.html_content, re.I)
            if matches:
                all_discovered.extend(matches)
        
        exclusions = r'^(?:_token|csrf|xsrf|token|captcha|timestamp|nonce|submit|true|false|null|undefined|void|return|if|else|for|while)$'
        for key in all_discovered:
            if re.match(exclusions, key, re.I):
                continue
            if key not in self.extracted_parameters:
                self.extracted_parameters[key] = ["audit_mapped"]

    def process(self) -> str:
        if not self._sanitize_and_enforce_scheme() or not self._execute_rfc_decomposition():
            return "NO_PARAM|NONE"

        self._extract_standard_query_matrix()
        self._extract_heuristic_fallback_matrix()
        self._extract_inline_path_matrix()
        self._extract_html_form_parameters()

        if self.extracted_parameters:
            self.routing_type = "QUERY_PARAM"
            parameter_keys = ",".join(self.extracted_parameters.keys())
            clean_path = re.sub(r';.*\Z', '', self.path)
            return f"{self.routing_type}|{clean_path}|{parameter_keys}"

        path_segments = [segment for segment in self.path.split('/') if segment]
        if path_segments:
            self.routing_type = "PATH_PARAM"
            clean_segments = "/" + "/".join(path_segments)
            clean_segments = re.sub(r';.*\Z', '', clean_segments)
            return f"{self.routing_type}|{clean_segments}"

        return "NO_PARAM|NONE"

if __name__ == "__main__":
    if len(sys.argv) > 1 and sys.argv[1]:
        extractor = StructuralParameterExtractor(sys.argv[1])
        output_buffer = extractor.process()
        print(output_buffer)
    else:
        print("NO_PARAM|NONE")