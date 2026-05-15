import 'dart:convert';
import 'dart:typed_data';

import 'package:amsl_app/features/tracking/tracking.dart';
import 'package:amsl_app/models/hikari/user/access_approvals.dart';
import 'package:base32/base32.dart';
import 'package:base32/encodings.dart';
import 'package:logging/logging.dart';

import '../../models/hikari/user/user.dart';
import '../hikari_api.dart';

class HikariUserApi {
  final BaseHikariApiClient hikari;
  static final log = Logger('hikariUserApi');

  const HikariUserApi(this.hikari);

  Future<User> getUser() async => hikari.get(
    "/user",
    queryParameters: {"deep": "true"},
    transform: (json) => User.fromJson(json),
  );

  Future<AccessApprovals?> getAccessTokenApprovals(String token) async =>
      hikari.get(
        "/user/access/$token/approvals",
        transform: (json) =>
            json == null ? null : AccessApprovals.fromJson(json),
      );

  Future<void> postAccessToken(String token) async =>
      hikari.post("/user/access", body: json.encode({"token": token}));

  Future<void> patchUser({required String? name}) async {
    trackEvent(
      category: TrackingCategory.profile,
      action: TrackingAction.edit,
      name: "username",
    );

    return hikari.patch("/user", body: json.encode({"name": name}));
  }

  Future<String> userHandle() async {
    Encoding encoding = Encoding.zbase32;

    String base64String = await hikari.post(
      "/user/handle",
      transform: (json) => json['handle'],
    );
    Uint8List decodedList = base64.decode(base64String);
    int checksum = calculateChecksum(decodedList);

    return base32.encode(decodedList, encoding: encoding) +
        encodeChecksum(checksum, encoding);
  }

  int calculateChecksum(List<int> data) {
    int handle = data.fold(0, (value, element) => (value + element) % 37);
    return 36 - handle;
  }

  String encodeChecksum(int checksum, Encoding encoding) {
    String encodingString = '${EncodingUtils.getChars(encoding)}*!\$=#';
    return encodingString[checksum];
  }
}
