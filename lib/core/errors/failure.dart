import 'package:flutter/foundation.dart';

/// {@template failure_type}
/// Categorization of failures emitted by the domain and infrastructure layers.
/// {@endtemplate}
enum FailureType {
  /// Unknown or unclassified failure.
  unknown,

  /// Network connectivity issue.
  network,

  /// Server returned an error.
  server,

  /// Authentication / authorization issue.
  auth,

  /// Validation issue.
  validation,

  /// Storage / cache issue.
  storage,

  /// Permission denied.
  permission,

  /// Cancelled by user or system.
  cancelled,
}

/// {@template failure}
/// A serializable, user-friendly failure model used across the app.
///
/// Failures are value objects returned by repositories and services instead of
/// throwing exceptions, keeping error handling explicit and typed.
/// {@endtemplate}
@immutable
class Failure {
  /// {@macro failure}
  const Failure({
    required this.message,
    this.type = FailureType.unknown,
    this.code,
    this.exception,
  });

  /// Human-readable failure message.
  final String message;

  /// Failure category.
  final FailureType type;

  /// Optional error code (HTTP status, Firebase code, etc.).
  final String? code;

  /// Optional underlying exception for telemetry.
  final Object? exception;

  /// Creates a network failure.
  factory Failure.network({String? code, Object? exception}) => Failure(
    message: 'No internet connection. Please check your network and try again.',
    type: FailureType.network,
    code: code,
    exception: exception,
  );

  /// Creates a server failure.
  factory Failure.server({String? code, Object? exception}) => Failure(
    message: 'Something went wrong on our side. Please try again later.',
    type: FailureType.server,
    code: code,
    exception: exception,
  );

  /// Creates an authentication failure.
  factory Failure.auth({String? code, Object? exception, String? message}) =>
      Failure(
        message:
            message ?? 'Authentication failed. Please sign in and try again.',
        type: FailureType.auth,
        code: code,
        exception: exception,
      );

  /// Creates a validation failure.
  factory Failure.validation(String message, {String? code}) =>
      Failure(message: message, type: FailureType.validation, code: code);

  /// Creates a storage failure.
  factory Failure.storage({String? code, Object? exception}) => Failure(
    message: 'Could not access local storage.',
    type: FailureType.storage,
    code: code,
    exception: exception,
  );

  /// Creates a permission failure.
  factory Failure.permission({String? code, Object? exception}) => Failure(
    message: 'Permission denied. Please grant the required permission.',
    type: FailureType.permission,
    code: code,
    exception: exception,
  );

  /// Creates a cancelled failure.
  factory Failure.cancelled({String? code, Object? exception}) => Failure(
    message: 'The operation was cancelled.',
    type: FailureType.cancelled,
    code: code,
    exception: exception,
  );

  /// Creates an unknown failure.
  factory Failure.unknown({String? code, Object? exception}) => Failure(
    message: 'An unexpected error occurred. Please try again.',
    code: code,
    exception: exception,
  );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Failure &&
        other.message == message &&
        other.type == type &&
        other.code == code;
  }

  @override
  int get hashCode => Object.hash(message, type, code);

  @override
  String toString() => 'Failure(type: $type, message: $message, code: $code)';
}
