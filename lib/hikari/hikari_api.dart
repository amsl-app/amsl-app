import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:amsl_app/authentication/auth.dart';
import 'package:amsl_app/constants.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:http/retry.dart';
import 'package:logging/logging.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'exception.dart';
import 'hikari_client.dart';
import 'hikari_retry_client.dart';

bool whenError(Object error, StackTrace stack) {
  return error is TimeoutException ||
      error is SocketException ||
      error is OSError;
}

/// Hikari client that performs authenticated requests
class HikariApiClient extends BaseHikariApiClient {
  static final log = Logger("HikariApiClient");

  final AuthController authController;
  FutureOr<void> Function() onUnauthorized;

  HikariApiClient({required this.authController, required this.onUnauthorized})
    : super() {
    client = HikariClient(authController, super.client);
  }

  @override
  Future<T> handleRequest<T>(
    Future<http.Response> request, {
    required Uri uri,
    T Function(dynamic)? transform,
    Set<int>? acceptedStatusCodes,
    bool rawResponse = false,
  }) async {
    try {
      final result = await super.handleRequest(
        request,
        uri: uri,
        transform: transform,
        acceptedStatusCodes: acceptedStatusCodes,
        rawResponse: rawResponse,
      );
      return result;
    } on HikariUnauthorizedException {
      log.info("calling onUnauthorized");
      await onUnauthorized.call();
      rethrow;
    }
  }

  @override
  FutureOr<Map<String, String>> prepareWsConnectHeaders() async {
    final headers = await super.prepareWsConnectHeaders();
    String? token = (await authController.getTokens()).access;

    headers.addAll({"Authorization": "Bearer $token"});
    return headers;
  }
}

class BaseHikariApiClient {
  static final log = Logger("BaseHikariApiClient");
  static const logoutCodes = [401];

  http.Client client;

  BaseHikariApiClient()
    : client = HikariRetryClient(
        RetryClient(
          http.Client(),
          whenError: (e, stacktrace) =>
              e is TimeoutException || e is SocketException || e is OSError,
        ),
      );

  Future<T> handleRequest<T>(
    Future<http.Response> request, {
    required Uri uri,
    T Function(dynamic)? transform,
    Set<int>? acceptedStatusCodes,
    bool rawResponse = false,
  }) async {
    try {
      final response = await request;
      final statusCode = response.statusCode;
      final statusCodeType = checkStatusCode(statusCode, acceptedStatusCodes);
      switch (statusCodeType) {
        case StatusCodeType.success:
          if (rawResponse) {
            log.fine("Successfully retrieved binary data from $uri");
            return response.bodyBytes as T;
          }
          if (transform == null) return Future.value();
          final json = jsonDecode(utf8.decode(response.bodyBytes));
          return transform(json);
        case StatusCodeType.authError:
          log.info("got AuthError while retrieving $uri: $statusCode");
          throw HikariUnauthorizedException("Serverside logout", statusCode);
        case StatusCodeType.serverError:
          log.severe("got server error while retrieving $uri: $statusCode");
          throw HikariServerException(response.body, statusCode);
        case StatusCodeType.clientError:
          log.severe("got client error while retrieving $uri: $statusCode");
          throw HikariClientException(response.body, statusCode);
      }
    } on HikariException catch (e) {
      log.info("hikari exception while loading $uri: ${e.message}");
      rethrow;
    } on http.ClientException catch (e) {
      log.warning("client exception while loading $uri: ${e.message}");
      throw HikariNetworkException("Failed load $uri: ${e.message}");
    } on TimeoutException catch (e) {
      log.warning("load time out $uri: ${e.message}");
      throw HikariNetworkException("Failed load $uri: ${e.message}");
    }
  }

  Future<T> post<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
    T Function(dynamic)? transform,
    Set<int>? acceptedStatusCodes,
  }) async {
    final uri = ApiConstants.scheme(
      ApiConstants.baseUrl,
      "${ApiConstants.apiPath}$path",
      queryParameters,
    );
    log.info("Sending POST request to $uri");

    final request = client.post(
      uri,
      headers: headers,
      body: body,
      encoding: encoding,
    );

    return await handleRequest(
      request,
      uri: uri,
      transform: transform,
      acceptedStatusCodes: acceptedStatusCodes,
    );
  }

  Future<T> put<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
    T Function(dynamic)? transform,
    Set<int>? acceptedStatusCodes,
  }) async {
    final uri = ApiConstants.scheme(
      ApiConstants.baseUrl,
      "${ApiConstants.apiPath}$path",
      queryParameters,
    );
    log.info("Sending PUT request to $uri");

    final request = client.put(
      uri,
      headers: headers,
      body: body,
      encoding: encoding,
    );
    return await handleRequest(
      request,
      uri: uri,
      transform: transform,
      acceptedStatusCodes: acceptedStatusCodes,
    );
  }

  Future<T> patch<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
    T Function(dynamic)? transform,
    Set<int>? acceptedStatusCodes,
  }) async {
    final uri = ApiConstants.scheme(
      ApiConstants.baseUrl,
      "${ApiConstants.apiPath}$path",
      queryParameters,
    );
    log.info("Sending PATCH request to $uri");

    final request = client.patch(
      uri,
      headers: headers,
      body: body,
      encoding: encoding,
    );
    return await handleRequest(
      request,
      uri: uri,
      transform: transform,
      acceptedStatusCodes: acceptedStatusCodes,
    );
  }

  Future<T> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    T Function(dynamic)? transform,
    Set<int>? acceptedStatusCodes,
    bool rawResponse = false,
  }) async {
    return getBase<T>(
      "${ApiConstants.apiPath}$path",
      queryParameters: queryParameters,
      headers: headers,
      rawResponse: rawResponse,
      transform: transform,
      acceptedStatusCodes: acceptedStatusCodes,
    );
  }

  Future<T> getBase<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    T Function(dynamic)? transform,
    bool rawResponse = false,
    bool unauthenticated = false,
    Set<int>? acceptedStatusCodes,
  }) async {
    final uri = ApiConstants.scheme(
      ApiConstants.baseUrl,
      path,
      queryParameters,
    );
    log.info("Sending GET request to $uri");

    final Future<Response> request = client.get(uri, headers: headers);

    return await handleRequest<T>(
      request,
      uri: uri,
      rawResponse: rawResponse,
      transform: transform,
      acceptedStatusCodes: acceptedStatusCodes,
    );
  }

  static StatusCodeType checkStatusCode(int statusCode, Set<int>? codes) {
    bool acceptedBySet = codes != null && codes.contains(statusCode);
    bool acceptedByRange =
        codes == null && (statusCode >= 200 && statusCode < 300);

    if (acceptedBySet || acceptedByRange) {
      return StatusCodeType.success;
    }

    if (statusCode == 401) {
      return StatusCodeType.authError;
    }
    if (statusCode >= 400 && statusCode < 500) {
      return StatusCodeType.clientError;
    }

    return StatusCodeType.serverError;
  }

  FutureOr<Map<String, String>> prepareWsConnectHeaders() async {
    Map<String, String> headers = {
      "Connection": "Upgrade",
      "upgrade": "websocket",
    };
    return headers;
  }

  Future<WebSocketChannel> connectToWs(String path) async {
    final uri = Uri.parse(
      "${ApiConstants.wsSchemeString}://${ApiConstants.baseUrl}/${ApiConstants.apiPath}$path",
    );

    final headers = await prepareWsConnectHeaders();

    log.info("Connecting to $uri");

    // TODO refresh token and retry in case token is invalid
    return IOWebSocketChannel.connect(
      uri,
      headers: headers,
      connectTimeout: const Duration(seconds: 10),
      pingInterval: const Duration(seconds: 30),
    );
  }
}

enum StatusCodeType { success, authError, serverError, clientError }
