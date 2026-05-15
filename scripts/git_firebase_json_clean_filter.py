#!/usr/bin/env python3

import json
import sys

SANITIZED = {
    "project_number": "100000000000",
    "project_id": "amsl-local",
    "storage_bucket": "amsl-local.appspot.com",
    "mobilesdk_app_id": "1:100000000000:android:aaaaaaaaaaaaaaaaaaaaaa",
    "package_name": "edu.kit.iism.issd.amsl.app",
    "client_id": "100000000000-aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa.apps.googleusercontent.com",
    "current_key": "AIzaSyREDACTED",
}


def main() -> None:
    raw = sys.stdin.read()
    try:
        data = json.loads(raw)
    except json.JSONDecodeError:
        sys.stdout.write(raw)
        return

    info = data.get("project_info", {})
    for key in ("project_number", "project_id", "storage_bucket"):
        if key in info:
            info[key] = SANITIZED[key]

    for client in data.get("client", []):
        client_info = client.get("client_info", {})
        if "mobilesdk_app_id" in client_info:
            client_info["mobilesdk_app_id"] = SANITIZED["mobilesdk_app_id"]

        android_info = client_info.get("android_client_info", {})
        if "package_name" in android_info:
            android_info["package_name"] = SANITIZED["package_name"]

        for oauth in client.get("oauth_client", []):
            if "client_id" in oauth:
                oauth["client_id"] = SANITIZED["client_id"]

        for api_key in client.get("api_key", []):
            if "current_key" in api_key:
                api_key["current_key"] = SANITIZED["current_key"]

    sys.stdout.write(json.dumps(data, indent=2) + "\n")


if __name__ == "__main__":
    main()
