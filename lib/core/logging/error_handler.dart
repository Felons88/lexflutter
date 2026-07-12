import 'dart:async';

import 'package:flutter/foundation.dart';

import 'logger.dart';

/// {@template error_handler}
/// Centralized error handling for Flutter, platform, and async errors.
///
/// Hooks into [FlutterError.onError] and [PlatformDispatcher.onError] and
/// forwards telemetry to the configured [AppLogger] (and Crashlytics via
/// the crashlytics service).
/// {@endtemplate}
class ErrorHandler {
  /// {@macro error_handler}
  ErrorHandler({required this._logger});

  final AppLogger _logger;

  /// Installs global error handlers.
  void install() {
    FlutterError.onError = _handleFlutterError;
    PlatformDispatcher.instance.onError = _handlePlatformError;
  }

  void _handleFlutterError(FlutterErrorDetails details) {
    _logger.e(
      'Flutter error: ${details.exceptionAsString()}',
      error: details.exception,
      stackTrace: details.stack,
    );
    if (kReleaseMode) {
      // Crashlytics will be forwarded by the crashlytics service.
      // Non-fatal errors are reported separately to avoid coupling.
    }
  }

  bool _handlePlatformError(Object error, StackTrace stack) {
    _logger.e('Platform error: $error', error: error, stackTrace: stack);
    return true;
  }

  /// Wraps a callback with the error handler hooks.
  Future<T> runAppZone<T>(Future<T> Function() app) async {
    return runZonedGuarded(app, (Object error, StackTrace stack) {
          _logger.e(
            'Unhandled zone error: $error',
            error: error,
            stackTrace: stack,
          );
        })
        as Future<T>;
  }
}
