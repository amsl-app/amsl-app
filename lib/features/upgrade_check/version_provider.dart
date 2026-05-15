import 'package:amsl_app/features/tracking/tracking.dart';
import 'package:amsl_app/providers/package_info.dart';
import 'package:logging/logging.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'min_version_provider.dart';

part 'version_provider.g.dart';

final log = Logger("Version Provider");

@Riverpod(dependencies: [packageInfo])
Future<Version> appVersion(Ref ref) async {
  final packageInfo = ref.read(packageInfoProvider);
  trackDimension(
    dimension: TrackingDimension.version,
    value: "${packageInfo.version}+${packageInfo.buildNumber}",
  );
  final version = Version.parse(packageInfo.version);
  log.finer("current app version: $version");
  return version;
}

sealed class UpdateInfo {
  const UpdateInfo();
}

final class UnknownUpdate extends UpdateInfo {
  const UnknownUpdate();
}

final class NeedsUpdate extends UpdateInfo {
  final Version appVersion;
  final Version minVersion;

  const NeedsUpdate({required this.appVersion, required this.minVersion});
}

@Riverpod(keepAlive: true, dependencies: [appVersion, MinVersion])
class UpdateData extends _$UpdateData {
  @override
  UpdateInfo build() {
    final appVersion = ref.watch(appVersionProvider);
    final minVersion = ref.watch(minVersionProvider);

    switch ((appVersion, minVersion)) {
      case (
        AsyncData(value: final appVersion),
        AsyncData(value: final minVersion),
      ):
        if (minVersion > appVersion) {
          return NeedsUpdate(appVersion: appVersion, minVersion: minVersion);
        }
        return const UnknownUpdate();
      default:
        return const UnknownUpdate();
    }
  }
}
