#!/usr/bin/env python3

import re
import sys

SANITIZED = {
    "apiUrl": {
        "dev": "dev-api.amsl.app",
        "qa": "qa-api.amsl.app",
        "staging": "staging-api.amsl.app",
        "prod": "api.amsl.app",
    },
    "redirectUrl": {
        "dev": "edu.kit.iism.issd.amsl.app.dev://login-callback",
        "qa": "edu.kit.iism.issd.amsl.app.test://login-callback",
        "staging": "edu.kit.iism.issd.amsl.app.staging://login-callback",
        "prod": "edu.kit.iism.issd.amsl.app://login-callback",
    },
    "authUrl": {
        "dev": "https://auth.amsl.app/realms/amsl",
        "qa": "https://auth.amsl.app/realms/amsl",
        "staging": "https://auth.amsl.app/realms/amsl",
        "prod": "https://auth.amsl.app/realms/amsl",
    },
    "authClientId": {
        "dev": "amsl-mobile",
        "qa": "amsl-mobile",
        "staging": "amsl-mobile",
        "prod": "amsl-mobile",
    },
    "matomoUrl": {
        "dev": "https://analytics.amsl.app/matomo.php",
        "qa": "https://analytics.amsl.app/matomo.php",
        "staging": "https://analytics.amsl.app/matomo.php",
        "prod": "https://analytics.amsl.app/matomo.php",
    },
    "sentryUrl": {
        "dev": "https://placeholderPublicKey@sentry.amsl.app/1",
        "qa": "https://placeholderPublicKey@sentry.amsl.app/1",
        "staging": "https://placeholderPublicKey@sentry.amsl.app/1",
        "prod": "https://placeholderPublicKey@sentry.amsl.app/1",
    },
}


def replace_case_return(block: str, flavor: str, value: str) -> str:
    flavor_pattern = rf"Flavor\s*\.{flavor}"
    pattern = rf"(case {flavor_pattern}:[^\n]*\n\s*return [\"'])([^\"']*)([\"'];)"
    updated, _ = re.subn(pattern, rf"\g<1>{value}\g<3>", block, count=1)
    return updated


def update_getter(content: str, getter: str, values: dict[str, str]) -> str:
    getter_pattern = rf"(static String get {getter} \{{\n)([\s\S]*?)(\n  \}})"
    match = re.search(getter_pattern, content)
    if not match:
        return content

    body = match.group(2)
    for flavor, value in values.items():
        body = replace_case_return(body, flavor, value)

    return content[: match.start(2)] + body + content[match.end(2) :]


def main() -> None:
    content = sys.stdin.read()
    for getter, values in SANITIZED.items():
        content = update_getter(content, getter, values)
    sys.stdout.write(content)


if __name__ == "__main__":
    main()
