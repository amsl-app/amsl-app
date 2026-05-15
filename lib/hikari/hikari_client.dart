import 'package:amsl_app/authentication/auth.dart';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';

class HikariClient extends http.BaseClient {
  final log = Logger("hikariClient");

  AuthController authController;
  final http.Client _inner;

  HikariClient(this.authController, this._inner);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    request.headers.addAll({
      'Content-type': 'application/json',
      'Accept': 'application/json; charset=UTF-8',
    });

    String? token = (await authController.getTokens()).access;
    request.headers.addAll({'Authorization': 'Bearer $token'});

    log.fine("Requesting ${request.url}");

    // TODO refresh token and retry in case token is invalid
    return _inner.send(request);
  }
}
