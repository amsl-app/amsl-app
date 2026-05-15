import 'package:http/http.dart' as http;

class HikariRetryClient extends http.BaseClient {
  final http.Client _innerRetryClient;

  HikariRetryClient(this._innerRetryClient);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    return _innerRetryClient.send(request).timeout(Duration(seconds: 30));
  }
}
