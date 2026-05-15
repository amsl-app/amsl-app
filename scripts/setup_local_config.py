from pathlib import Path
import json
import platform
import re

FLAVORS = ("dev", "qa", "staging", "prod")
GLOBAL_KEYS = [
    "FIREBASE_PROJECT_NUMBER",
    "FIREBASE_PROJECT_ID",
    "FIREBASE_STORAGE_BUCKET",
    "ANDROID_FIREBASE_MOBILE_SDK_APP_ID",
    "ANDROID_FIREBASE_OAUTH_CLIENT_ID",
    "ANDROID_FIREBASE_API_KEY",
    "IOS_FIREBASE_API_KEY",
    "IOS_FIREBASE_GCM_SENDER_ID",
    "IOS_FIREBASE_GOOGLE_APP_ID",
    "MATOMO_URL",
    "SENTRY_URL",
]
FLAVORS_KEYS = [
    "API_URL",
    "AUTH_URL",
    "AUTH_CLIENT_ID",
    "REDIRECT_URL",
    "SITE_ID",
]
OPTIONAL_KEYS = ["IOS_DEVELOPMENT_TEAM"]


def load_env(env_path: Path) -> dict[str, str]:
    env: dict[str, str] = {}
    for raw_line in env_path.read_text().splitlines():
        line = raw_line.strip()
        if not line or line.startswith("#") or line.startswith(";") or "=" not in line:
            continue
        key, value = line.split("=", 1)
        env[key.strip()] = value.strip()
    return env


def require_keys(env: dict[str, str], keys: list[str], extra_help="") -> None:
    missing = [key for key in keys if not env.get(key)]
    if missing:
        raise SystemExit(
            "Missing env keys: "
            + ", ".join(missing)
            + f". Use .env to set the value."
            + extra_help
        )


def get_value(env: dict[str, str], key: str, default: str) -> str:
    value = env.get(key)
    return value if value else default


def load_optional_env(env_path: Path) -> tuple[dict[str, str], bool]:
    if not env_path.exists():
        return {}, False
    return load_env(env_path), True


def merge_env(base_env: dict[str, str], override_env: dict[str, str]) -> dict[str, str]:
    merged = dict(base_env)
    merged.update(override_env)
    return merged


def require_flavor_values(flavor: str, values: dict[str, str]) -> None:
    missing = [k for k, v in values.items() if not v and k not in OPTIONAL_KEYS]
    if missing:
        joined = ", ".join(missing)
        raise SystemExit(
            f"Missing {joined} for '{flavor}' flavor. Use .env to set them. Flavor specific values can also be set or overwritten in .env.{flavor}."
        )
    require_keys(
        values,
        GLOBAL_KEYS + FLAVORS_KEYS,
        extra_help=" Flavor specific values can also be set or overwritten in .env.{flavor}.",
    )


def resolve_global_env(
    base_env: dict[str, str], flavor_raw_envs: dict[str, dict[str, str]]
) -> dict[str, str]:
    resolved: dict[str, str] = {}

    for key in GLOBAL_KEYS:
        value = flavor_raw_envs.get("prod", base_env).get(key, base_env.get(key))
        if value:
            resolved[key] = value

    for key in OPTIONAL_KEYS:
        value = flavor_raw_envs.get("prod", base_env).get(key, base_env.get(key, ""))
        resolved[key] = value

    return resolved


def _replace_case_return(body: str, flavor: str, value: str) -> str:
    flavor_pattern = rf"Flavor\s*\.{flavor}"

    pattern = rf"""(case {flavor_pattern}:[^\n]*\s*return ['"])([^'"]*)(["'];)"""
    updated_body, replacements = re.subn(pattern, rf"\g<1>{value}\g<3>", body, count=1)
    if replacements != 1:
        raise SystemExit(
            f"Could not update '{flavor}' case in flavors.dart to {value} in {body}"
        )
    return updated_body


def _update_getter_cases(content: str, getter_name: str, values: dict[str, str]) -> str:
    getter_pattern = rf"(static String get {getter_name} \{{\n)([\s\S]*?)(\n  \}})"
    match = re.search(getter_pattern, content)
    if not match:
        raise SystemExit(f"Could not find getter '{getter_name}' in flavors.dart")

    body = match.group(2)
    for flavor, value in values.items():
        body = _replace_case_return(body, flavor, value)

    return content[: match.start(2)] + body + content[match.end(2) :]


def write_flavors_dart(flavor_envs: dict[str, dict[str, str]]) -> None:
    dev = flavor_envs["dev"]
    qa = flavor_envs["qa"]
    staging = flavor_envs["staging"]
    prod = flavor_envs["prod"]

    require_flavor_values("dev", dev)
    require_flavor_values("qa", qa)
    require_flavor_values("staging", staging)
    require_flavor_values("prod", prod)

    path = Path("lib/flavors.base.dart")
    out_path = Path("lib/flavors.dart")
    content = path.read_text()

    content = _update_getter_cases(
        content,
        "apiUrl",
        {
            "dev": dev["API_URL"],
            "qa": qa["API_URL"],
            "staging": staging["API_URL"],
            "prod": prod["API_URL"],
        },
    )
    content = _update_getter_cases(
        content,
        "redirectUrl",
        {
            "dev": dev["REDIRECT_URL"],
            "qa": qa["REDIRECT_URL"],
            "staging": staging["REDIRECT_URL"],
            "prod": prod["REDIRECT_URL"],
        },
    )
    content = _update_getter_cases(
        content,
        "siteId",
        {
            "dev": dev["SITE_ID"],
            "qa": qa["SITE_ID"],
            "staging": staging["SITE_ID"],
            "prod": prod["SITE_ID"],
        },
    )
    content = _update_getter_cases(
        content,
        "authUrl",
        {
            "dev": dev["AUTH_URL"],
            "qa": qa["AUTH_URL"],
            "staging": staging["AUTH_URL"],
            "prod": prod["AUTH_URL"],
        },
    )
    content = _update_getter_cases(
        content,
        "authClientId",
        {
            "dev": dev["AUTH_CLIENT_ID"],
            "qa": qa["AUTH_CLIENT_ID"],
            "staging": staging["AUTH_CLIENT_ID"],
            "prod": prod["AUTH_CLIENT_ID"],
        },
    )
    content = _update_getter_cases(
        content,
        "sentryUrl",
        {
            "dev": dev["SENTRY_URL"],
            "qa": qa["SENTRY_URL"],
            "staging": staging["SENTRY_URL"],
            "prod": prod["SENTRY_URL"],
        },
    )
    content = _update_getter_cases(
        content,
        "matomoUrl",
        {
            "dev": dev["MATOMO_URL"],
            "qa": qa["MATOMO_URL"],
            "staging": staging["MATOMO_URL"],
            "prod": prod["MATOMO_URL"],
        },
    )

    out_path.write_text(content)
    print(f"Wrote {out_path}")


def write_android_google_services(env: dict[str, str]) -> None:
    android_package_id = "edu.kit.iism.issd.amsl.app"
    android = {
        "project_info": {
            "project_number": env["FIREBASE_PROJECT_NUMBER"],
            "project_id": env["FIREBASE_PROJECT_ID"],
            "storage_bucket": env["FIREBASE_STORAGE_BUCKET"],
        },
        "client": [
            {
                "client_info": {
                    "mobilesdk_app_id": env["ANDROID_FIREBASE_MOBILE_SDK_APP_ID"],
                    "android_client_info": {
                        "package_name": android_package_id,
                    },
                },
                "oauth_client": [
                    {
                        "client_id": env["ANDROID_FIREBASE_OAUTH_CLIENT_ID"],
                        "client_type": 3,
                    }
                ],
                "api_key": [
                    {
                        "current_key": env["ANDROID_FIREBASE_API_KEY"],
                    }
                ],
                "services": {"appinvite_service": {"other_platform_oauth_client": []}},
            }
        ],
        "configuration_version": "1",
    }

    android_path = Path("android/app/google-services.json")
    android_path.parent.mkdir(parents=True, exist_ok=True)
    android_path.write_text(json.dumps(android, indent=2) + "\n")
    print(f"Wrote {android_path}")


def write_ios_google_service_info(env: dict[str, str]) -> None:
    ios_bundle_id = "edu.kit.iism.issd.amsl.app.dev"
    ios_project_id = env.get("IOS_FIREBASE_PROJECT_ID", env["FIREBASE_PROJECT_ID"])
    ios_storage_bucket = env.get(
        "IOS_FIREBASE_STORAGE_BUCKET", env["FIREBASE_STORAGE_BUCKET"]
    )

    ios_path = Path("ios/Runner/GoogleService-Info.plist")
    ios_path.parent.mkdir(parents=True, exist_ok=True)
    ios_path.write_text(
        """<?xml version=\"1.0\" encoding=\"UTF-8\"?>
<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">
<plist version=\"1.0\">
<dict>
\t<key>API_KEY</key>
\t<string>{ios_api_key}</string>
\t<key>GCM_SENDER_ID</key>
\t<string>{ios_sender_id}</string>
\t<key>PLIST_VERSION</key>
\t<string>1</string>
\t<key>BUNDLE_ID</key>
\t<string>{ios_bundle_id}</string>
\t<key>PROJECT_ID</key>
\t<string>{project_id}</string>
\t<key>STORAGE_BUCKET</key>
\t<string>{storage_bucket}</string>
\t<key>IS_ADS_ENABLED</key>
\t<false></false>
\t<key>IS_ANALYTICS_ENABLED</key>
\t<false></false>
\t<key>IS_APPINVITE_ENABLED</key>
\t<true></true>
\t<key>IS_GCM_ENABLED</key>
\t<true></true>
\t<key>IS_SIGNIN_ENABLED</key>
\t<true></true>
\t<key>GOOGLE_APP_ID</key>
\t<string>{ios_google_app_id}</string>
</dict>
</plist>
""".format(
            ios_api_key=env["IOS_FIREBASE_API_KEY"],
            ios_sender_id=env["IOS_FIREBASE_GCM_SENDER_ID"],
            ios_bundle_id=ios_bundle_id,
            project_id=ios_project_id,
            storage_bucket=ios_storage_bucket,
            ios_google_app_id=env["IOS_FIREBASE_GOOGLE_APP_ID"],
        )
    )
    print(f"Wrote {ios_path}")


def set_ios_development_team(env: dict[str, str]) -> None:
    if platform.system() != "Darwin":
        return

    team_id = env.get("IOS_DEVELOPMENT_TEAM", "").strip()
    if not team_id:
        return

    pbxproj_path = Path("ios/Runner.xcodeproj/project.pbxproj")
    if not pbxproj_path.exists():
        return

    content = pbxproj_path.read_text()
    content = re.sub(
        r'("?)DEVELOPMENT_TEAM(\[sdk=\w+\*])?("?) = "[^"]*";',
        f'\\g<1>DEVELOPMENT_TEAM\\g<2>\\g<3> = "{team_id}";',
        content,
    )
    pbxproj_path.write_text(content)
    print(f"Set iOS DEVELOPMENT_TEAM to {team_id}")


def main() -> None:
    base_env, base_exists = load_optional_env(Path(".env"))

    flavor_envs: dict[str, dict[str, str]] = {}
    flavor_raw_envs: dict[str, dict[str, str]] = {}
    for flavor in FLAVORS:
        flavor_env, flavor_exists = load_optional_env(Path(f".env.{flavor}"))
        if not base_exists and not flavor_exists:
            raise SystemExit(
                f"Missing both .env and .env.{flavor}. At least one must exist."
            )
        flavor_raw_envs[flavor] = flavor_env
        flavor_envs[flavor] = merge_env(base_env, flavor_env)

    global_env = resolve_global_env(base_env, flavor_raw_envs)
    require_keys(global_env, GLOBAL_KEYS)

    write_flavors_dart(flavor_envs)
    write_android_google_services(global_env)
    write_ios_google_service_info(global_env)
    set_ios_development_team(global_env)


if __name__ == "__main__":
    main()
