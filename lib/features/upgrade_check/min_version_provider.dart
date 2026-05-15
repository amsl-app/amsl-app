import 'package:amsl_app/hikari/hikari.dart';
import 'package:amsl_app/hikari/hikari_api.dart';
import 'package:amsl_app/hikari/models/version_info.dart';
import 'package:logging/logging.dart';
import 'package:pausable_timer/pausable_timer.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'min_version_provider.g.dart';

@Riverpod(keepAlive: true)
class MinVersion extends _$MinVersion {
  static final log = Logger("MinVersion");
  final api = Hikari(apiClient: BaseHikariApiClient());

  PausableTimer? checkDelay;

  @override
  Future<Version> build() async {
    final version = await refresh();
    checkDelay = PausableTimer(Duration(days: 1), () async {
      ref.invalidateSelf();
    });
    checkDelay?.start();
    ref.onDispose(() {
      checkDelay?.cancel();
    });
    return version;
  }

  Future<Version> refresh() async {
    log.finer("getting hikari version info");
    final api = Hikari(apiClient: BaseHikariApiClient());
    final VersionInfo versionInfo;
    try {
      versionInfo = await api.utilApi.getVersionInfo();
    } catch (e) {
      log.warning("failed to version info", e);
      rethrow;
    }
    final version = Version.parse(versionInfo.frontend.min);
    log.fine("Current required frontend version: $version");
    return version;
  }
}
