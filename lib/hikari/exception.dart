import 'package:http/http.dart';

// API

sealed class HikariException extends ClientException {
  final Function? resolve;

  HikariException(super.message, [this.resolve]);

  HikariException copyWith({String? message, Function? resolve});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HikariException &&
          runtimeType == other.runtimeType &&
          resolve == other.resolve &&
          message == other.message;

  @override
  int get hashCode => resolve.hashCode ^ message.hashCode;
}

sealed class HikariStatusException extends HikariException {
  final int statusCode;

  HikariStatusException(super.message, this.statusCode, [super.resolve]);

  @override
  HikariStatusException copyWith({
    String? message,
    Function? resolve,
    int? statusCode,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other &&
          other is HikariStatusException &&
          runtimeType == other.runtimeType &&
          statusCode == other.statusCode;

  @override
  int get hashCode => super.hashCode ^ statusCode.hashCode;
}

class HikariServerException extends HikariStatusException {
  HikariServerException(super.message, super.statusCode, [super.resolve]);

  @override
  HikariServerException copyWith({
    String? message,
    Function? resolve,
    int? statusCode,
  }) => HikariServerException(
    message ?? super.message,
    statusCode ?? super.statusCode,
    resolve ?? super.resolve,
  );
}

class HikariClientException extends HikariStatusException {
  HikariClientException(super.message, super.statusCode, [super.resolve]);

  @override
  HikariClientException copyWith({
    String? message,
    Function? resolve,
    int? statusCode,
  }) => HikariClientException(
    message ?? super.message,
    statusCode ?? super.statusCode,
    resolve ?? super.resolve,
  );
}

class HikariUnauthorizedException extends HikariStatusException {
  HikariUnauthorizedException(super.message, super.statusCode, [super.resolve]);

  @override
  HikariUnauthorizedException copyWith({
    String? message,
    int? statusCode,
    Function? resolve,
  }) => HikariUnauthorizedException(
    message ?? super.message,
    statusCode ?? super.statusCode,
    resolve ?? super.resolve,
  );
}

class HikariClosedWebsocketException extends HikariStatusException {
  HikariClosedWebsocketException(
    super.message,
    super.statusCode, [
    super.resolve,
  ]);

  @override
  HikariClosedWebsocketException copyWith({
    String? message,
    int? statusCode,
    Function? resolve,
  }) => HikariClosedWebsocketException(
    message ?? super.message,
    statusCode ?? super.statusCode,
    resolve ?? super.resolve,
  );
}

class HikariNetworkException extends HikariException {
  HikariNetworkException(super.message, [super.resolve]);

  @override
  HikariNetworkException copyWith({String? message, Function? resolve}) =>
      HikariNetworkException(
        message ?? super.message,
        resolve ?? super.resolve,
      );
}

// Auth

class AuthenticationException implements Exception {
  final String message;

  const AuthenticationException(this.message);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthenticationException &&
          runtimeType == other.runtimeType &&
          message == other.message;

  @override
  int get hashCode => message.hashCode;
}

// Custom

class FrontendEndException implements Exception {
  final String label;

  const FrontendEndException(this.label);

  @override
  String toString() {
    return label;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FrontendEndException &&
          runtimeType == other.runtimeType &&
          label == other.label;

  @override
  int get hashCode => label.hashCode;
}

// TODO Change inheritance structure to extend HikariException (and make HikariException not extend ClientException)
class HikariConversionException implements Exception {
  final String message;

  const HikariConversionException(this.message);

  @override
  String toString() {
    return message;
  }
}
