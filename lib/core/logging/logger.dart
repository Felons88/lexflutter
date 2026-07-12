import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

/// {@template log_level}
/// Severity levels matching the underlying logger package.
/// {@endtemplate}
enum LogLevel {
  /// Verbose tracing.
  verbose,

  /// Debug information.
  debug,

  /// General information.
  info,

  /// Warning.
  warning,

  /// Error.
  error,

  /// Unrecoverable / WTF.
  wtf,
}

/// {@template app_logger}
/// Application logger abstraction.
///
/// Wraps the [logger](https://pub.dev/packages/logger) package and disables
/// output in release builds by default.
/// {@endtemplate}
class AppLogger {
  /// {@macro app_logger}
  AppLogger({Logger? logger, bool? enabled})
    : _logger = logger ?? _defaultLogger(),
      _enabled = enabled ?? !kReleaseMode;

  final Logger _logger;
  final bool _enabled;

  static Logger _defaultLogger() => Logger(
    filter: ProductionFilter(),
    printer: PrettyPrinter(printEmojis: false),
  );

  /// Logs a verbose message.
  void v(dynamic message, {dynamic error, StackTrace? stackTrace}) {
    _log(LogLevel.verbose, message, error: error, stackTrace: stackTrace);
  }

  /// Logs a debug message.
  void d(dynamic message, {dynamic error, StackTrace? stackTrace}) {
    _log(LogLevel.debug, message, error: error, stackTrace: stackTrace);
  }

  /// Logs an info message.
  void i(dynamic message, {dynamic error, StackTrace? stackTrace}) {
    _log(LogLevel.info, message, error: error, stackTrace: stackTrace);
  }

  /// Logs a warning message.
  void w(dynamic message, {dynamic error, StackTrace? stackTrace}) {
    _log(LogLevel.warning, message, error: error, stackTrace: stackTrace);
  }

  /// Logs an error message.
  void e(dynamic message, {dynamic error, StackTrace? stackTrace}) {
    _log(LogLevel.error, message, error: error, stackTrace: stackTrace);
  }

  /// Logs a wtf message.
  void wtf(dynamic message, {dynamic error, StackTrace? stackTrace}) {
    _log(LogLevel.wtf, message, error: error, stackTrace: stackTrace);
  }

  void _log(
    LogLevel level,
    dynamic message, {
    dynamic error,
    StackTrace? stackTrace,
  }) {
    if (!_enabled) return;
    final Object? combined = error != null ? '$message | $error' : message;
    switch (level) {
      case LogLevel.verbose:
        _logger.t(combined, error: error, stackTrace: stackTrace);
      case LogLevel.debug:
        _logger.d(combined, error: error, stackTrace: stackTrace);
      case LogLevel.info:
        _logger.i(combined, error: error, stackTrace: stackTrace);
      case LogLevel.warning:
        _logger.w(combined, error: error, stackTrace: stackTrace);
      case LogLevel.error:
        _logger.e(combined, error: error, stackTrace: stackTrace);
      case LogLevel.wtf:
        _logger.f(combined, error: error, stackTrace: stackTrace);
    }
  }
}
