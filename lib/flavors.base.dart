// Warning: Template file for setup_local_config.py
// Do not edit needlessly

enum Flavor { dev, qa, staging, prod }

class F {
  static Flavor appFlavor = Flavor.prod;

  static String get name => appFlavor.name;

  static String get title {
    switch (appFlavor) {
      case Flavor.dev:
        return 'Amsl Dev';
      case Flavor
          .qa: // This flavor is called QA because flavors can't be called test :/
        return 'Amsl Test';
      case Flavor.staging:
        return 'Amsl Staging';
      case Flavor.prod:
        return 'Amsl';
    }
  }

  static String get apiUrl {
    switch (appFlavor) {
      case Flavor.dev:
        return 'dev-api.amsl.app';
      case Flavor
          .qa: // This flavor is called QA because flavors can't be called test :/
        return 'qa-api.amsl.app';
      case Flavor.staging:
        return 'staging-api.amsl.app';
      case Flavor.prod:
        return 'api.amsl.app';
    }
  }

  static String get redirectUrl {
    switch (appFlavor) {
      case Flavor.dev:
        return 'edu.kit.iism.issd.amsl.app.dev://login-callback';
      case Flavor
          .qa: // This flavor is called QA because flavors can't be called test :/
        return 'edu.kit.iism.issd.amsl.app.test://login-callback';
      case Flavor.staging:
        return 'edu.kit.iism.issd.amsl.app.staging://login-callback';
      case Flavor.prod:
        return 'edu.kit.iism.issd.amsl.app://login-callback';
    }
  }

  static bool get https {
    return true;
  }

  static String get matomoUrl {
    switch (appFlavor) {
      case Flavor.dev:
        return "https://analytics.amsl.app/matomo.php";
      case Flavor.qa:
        return "https://analytics.amsl.app/matomo.php";
      case Flavor.staging:
        return "https://analytics.amsl.app/matomo.php";
      case Flavor.prod:
        return "https://analytics.amsl.app/matomo.php";
    }
  }

  static String get sentryUrl {
    switch (appFlavor) {
      case Flavor.dev:
        return "https://placeholderPublicKey@sentry.amsl.app/1";
      case Flavor.qa:
        return "https://placeholderPublicKey@sentry.amsl.app/1";
      case Flavor.staging:
        return "https://placeholderPublicKey@sentry.amsl.app/1";
      case Flavor.prod:
        return "https://placeholderPublicKey@sentry.amsl.app/1";
    }
  }

  static String get siteId {
    switch (appFlavor) {
      case Flavor.dev:
        return '1';
      case Flavor.qa:
        return '1';
      case Flavor.staging:
        return '1';
      case Flavor.prod:
        return '1';
    }
  }

  static String get authUrl {
    switch (appFlavor) {
      case Flavor.dev:
        return 'https://auth.amsl.app/realms/amsl';
      case Flavor.qa:
        return 'https://auth.amsl.app/realms/amsl';
      case Flavor.staging:
        return 'https://auth.amsl.app/realms/amsl';
      case Flavor.prod:
        return 'https://auth.amsl.app/realms/amsl';
    }
  }

  static String get authClientId {
    switch (appFlavor) {
      case Flavor.dev:
        return 'amsl-mobile';
      case Flavor.qa:
        return 'amsl-mobile';
      case Flavor.staging:
        return 'amsl-mobile';
      case Flavor.prod:
        return 'amsl-mobile';
    }
  }

  static String get cdnUrl {
    switch (appFlavor) {
      case Flavor.dev:
        return 'cdn.amsl.app';
      case Flavor.qa:
        return 'cdn.amsl.app';
      case Flavor.staging:
        return 'cdn.amsl.app';
      case Flavor.prod:
        return 'cdn.amsl.app';
    }
  }

  static bool get debugEnabled {
    switch (appFlavor) {
      case Flavor.dev:
        return true;
      case Flavor.qa:
        return true;
      case Flavor.staging:
        return false;
      default:
        return false;
    }
  }
}
