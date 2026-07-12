import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';

/// {@template analytics_service}
/// Application analytics abstraction backed by Firebase Analytics.
///
/// All events are no-ops in debug mode to keep developer telemetry clean.
/// {@endtemplate}
class AnalyticsService {
  /// {@macro analytics_service}
  AnalyticsService({FirebaseAnalytics? analytics})
    : _analytics = analytics ?? FirebaseAnalytics.instance,
      _enabled = kReleaseMode;

  final FirebaseAnalytics _analytics;
  final bool _enabled;

  /// Logs a custom event with optional parameters.
  Future<void> logEvent({
    required String name,
    Map<String, Object>? parameters,
  }) async {
    if (!_enabled) return;
    await _analytics.logEvent(name: name, parameters: parameters);
  }

  /// Sets the current screen name.
  Future<void> setCurrentScreen({
    required String screenName,
    String? screenClass,
  }) async {
    if (!_enabled) return;
    await _analytics.logScreenView(
      screenName: screenName,
      screenClass: screenClass,
    );
  }

  /// Sets the user identifier.
  Future<void> setUserId(String? userId) async {
    if (!_enabled) return;
    await _analytics.setUserId(id: userId);
  }

  /// Sets a user property.
  Future<void> setUserProperty({
    required String name,
    required String? value,
  }) async {
    if (!_enabled) return;
    await _analytics.setUserProperty(name: name, value: value);
  }

  /// Logs a login event.
  Future<void> logLogin({String? method}) async {
    if (!_enabled) return;
    await _analytics.logLogin(loginMethod: method);
  }

  /// Logs a sign-up event.
  Future<void> logSignUp({String? method}) async {
    if (!_enabled) return;
    await _analytics.logSignUp(signUpMethod: method ?? 'unknown');
  }

  /// Logs a purchase event.
  Future<void> logPurchase({
    required String currency,
    required double value,
    String? transactionId,
  }) async {
    if (!_enabled) return;
    await _analytics.logPurchase(
      currency: currency,
      value: value,
      transactionId: transactionId,
    );
  }
}
