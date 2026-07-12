import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

import '../../logging/logger.dart';

/// {@template firebase_initializer}
/// Initializes Firebase and all Firebase services used by LEX.
///
/// This is a single entry point called from [main] before the app starts.
/// {@endtemplate}
class FirebaseInitializer {
  /// {@macro firebase_initializer}
  FirebaseInitializer({
    required this._logger,
    this._app,
    FirebaseMessaging? messaging,
    FirebaseAnalytics? analytics,
    FirebaseCrashlytics? crashlytics,
    FirebaseAppCheck? appCheck,
  }) : _messaging = messaging ?? FirebaseMessaging.instance,
       _analytics = analytics ?? FirebaseAnalytics.instance,
       _crashlytics = crashlytics ?? FirebaseCrashlytics.instance,
       _appCheck = appCheck ?? FirebaseAppCheck.instance;

  final AppLogger _logger;
  final FirebaseApp? _app;
  final FirebaseMessaging _messaging;
  final FirebaseAnalytics _analytics;
  final FirebaseCrashlytics _crashlytics;
  final FirebaseAppCheck _appCheck;

  /// Initializes Firebase core and services.
  Future<FirebaseApp> initialize() async {
    final FirebaseApp app = _app ?? await Firebase.initializeApp();
    _logger.i('Firebase initialized: ${app.name}');

    await _configureCrashlytics();
    await _configureAnalytics();
    await _configureMessaging();
    await _configureAppCheck();

    return app;
  }

  Future<void> _configureCrashlytics() async {
    await _crashlytics.setCrashlyticsCollectionEnabled(kReleaseMode);
  }

  Future<void> _configureAnalytics() async {
    await _analytics.setAnalyticsCollectionEnabled(kReleaseMode);
  }

  Future<void> _configureMessaging() async {
    if (kIsWeb) return;
    final NotificationSettings settings = await _messaging.requestPermission();
    _logger.i('Firebase messaging permission: ${settings.authorizationStatus}');
    await _messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  Future<void> _configureAppCheck() async {
    if (kIsWeb) return;
    await _appCheck.activate();
  }
}
