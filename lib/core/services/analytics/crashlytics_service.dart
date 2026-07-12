import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

/// {@template crashlytics_service}
/// Crash reporting abstraction backed by Firebase Crashlytics.
/// {@endtemplate}
class CrashlyticsService {
  /// {@macro crashlytics_service}
  CrashlyticsService({FirebaseCrashlytics? crashlytics})
      : _crashlytics = crashlytics ?? FirebaseCrashlytics.instance,
        _enabled = kReleaseMode;

  final FirebaseCrashlytics _crashlytics;
  final bool _enabled;

  /// Records a non-fatal error.
  Future<void> recordError(
    Object exception,
    StackTrace? stack, {
    String? reason,
    bool fatal = false,
  }) async {
    if (!_enabled) return;
    await _crashlytics.recordError(
      exception,
      stack,
      reason: reason,
      fatal: fatal,
    );
  }

  /// Logs a breadcrumb message.
  Future<void> log(String message) async {
    if (!_enabled) return;
    await _crashlytics.log(message);
  }

  /// Sets the user identifier for crash reports.
  Future<void> setUserId(String userId) async {
    if (!_enabled) return;
    await _crashlytics.setUserIdentifier(userId);
  }

  /// Sets a custom key for crash reports.
  Future<void> setCustomKey(String key, Object value) async {
    if (!_enabled) return;
    await _crashlytics.setCustomKey(key, value);
  }

  /// Marks whether crash data collection is enabled.
  Future<void> setEnabled(bool enabled) async {
    await _crashlytics.setCrashlyticsCollectionEnabled(enabled);
  }
}
