#!/usr/bin/env python3

import re
import sys

REPLACEMENTS = {
    "API_KEY": "AIzaSyREDACTED",
    "GCM_SENDER_ID": "100000000000",
    "BUNDLE_ID": "edu.kit.iism.issd.amsl.app.dev",
    "PROJECT_ID": "amsl-local",
    "STORAGE_BUCKET": "amsl-local.appspot.com",
    "GOOGLE_APP_ID": "1:100000000000:ios:bbbbbbbbbbbbbbbbbbbbbb",
}


def replace_key(content: str, key: str, value: str) -> str:
    pattern = rf"(<key>{re.escape(key)}</key>\s*<string>)(.*?)(</string>)"
    return re.sub(pattern, rf"\g<1>{value}\g<3>", content, count=1, flags=re.DOTALL)


def main() -> None:
    content = sys.stdin.read()
    for key, value in REPLACEMENTS.items():
        content = replace_key(content, key, value)
    sys.stdout.write(content)


if __name__ == "__main__":
    main()
