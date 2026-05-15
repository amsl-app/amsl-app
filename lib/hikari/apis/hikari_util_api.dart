import 'package:amsl_app/hikari/hikari_api.dart';
import 'package:logging/logging.dart';

import '../models/version_info.dart';

class HikariUtilApi {
  final BaseHikariApiClient hikari;
  static final log = Logger('hikariUtilApi');

  const HikariUtilApi(this.hikari);

  Future<VersionInfo> getVersionInfo() async => hikari.getBase(
    "version",
    transform: (json) => VersionInfo.fromJson(json),
  );
}
