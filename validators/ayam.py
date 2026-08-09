import sys
import re
import json
import collections
import ssl
from urllib.parse import urlparse, parse_qs
from urllib.request import urlopen, Request

# Copyright Skokoo 2026
# Licensed under apache version 2.0

class StructuralParameterExtractor:
    """
    Enterprise-grade URL decomposition and tokenization engine.
    Parses deep structural vectors to isolate input parameters across multiple vectors.
    Includes built-in HTTP/HTTPS live connectivity verification and automated scheme fallback.
    """
    def __init__(self, target_url: str):
        self.raw_url = target_url.strip() if isinstance(target_url, str) else ""
        self.scheme = ""
        self.path = ""
        self.extracted_parameters = collections.OrderedDict()
        self.routing_type = "NO_PARAM"

    def _sanitize_and_enforce_scheme(self) -> bool:
        if not self.raw_url:
            return False

        # Singkirkan skema lama jika user memasukkannya secara manual untuk keperluan pengetesan ulang
        clean_base = re.sub(r'^\s*https?://', '', self.raw_url, flags=re.I)
        
        # Konfigurasi SSL Context agar mengabaikan sertifikat rusak/expired (seperti flag -k pada curl)
        ssl_context = ssl.create_default_context()
        ssl_context.check_hostname = False
        ssl_context.verify_mode = ssl.CERT_NONE

        # Setup header user-agent standar agar tidak diblokir oleh web firewall dasar
        headers = {'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)'}

        # Strategi 1: Coba koneksi menggunakan HTTP biasa terlebih dahulu
        test_url = f"http://{clean_base}"
        try:
            req = Request(test_url, headers=headers)
            # Timeout dinamis 4 detik agar tidak membuat skrip menggantung lama
            with urlopen(req, timeout=4, context=ssl_context) as response:
                self.raw_url = test_url
                return True
        except Exception:
            # Strategi 2: Jika HTTP gagal/ditolak, lakukan failover otomatis ke HTTPS
            self.raw_url = f"https://{clean_base}"
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

    def process(self) -> str:
        if not self._sanitize_and_enforce_scheme() or not self._execute_rfc_decomposition():
            return "NO_PARAM|NONE"

        self._extract_standard_query_matrix()
        self._extract_heuristic_fallback_matrix()
        self._extract_inline_path_matrix()

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