from typing import Optional, Sequence
from urllib.parse import urlparse
import os

ENFORCE_URL_ORIGIN_FORMAT = "Input origins must be well-formed URLs, i.e. https://google.com or https://www.google.com."
SCHEMAS = ('http', 'https')
CORS_HOSTS = os.getenv('CORS_HOSTS', 'localhost').split(',')
CORS_PORTS = os.getenv('CORS_PORTS').split(',') if os.getenv('CORS_PORTS') else None

def compute_local_origins(port: Optional[int] = None) -> list[str]:
    local_origins = [f'{schema}://{host}' for schema in SCHEMAS for host in CORS_HOSTS]
    if CORS_PORTS:
        local_origins = [f'{origin}:{port}' for origin in local_origins for port in CORS_PORTS]
    print("local_origins", local_origins)
    return local_origins


def normalize_origins(origins: Sequence[str]) -> set[str]:
    allowed_origins = set()
    for origin in origins:
        url = urlparse(origin)
        assert url.scheme, ENFORCE_URL_ORIGIN_FORMAT
        valid_origin = f'{url.scheme}://{url.hostname}'
        if url.port:
            valid_origin += f':{url.port}'
        allowed_origins.add(valid_origin)
    return allowed_origins
