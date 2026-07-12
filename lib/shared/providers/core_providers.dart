import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/config/app_config.dart';
import '../../core/logging/logger.dart';
import '../../core/services/analytics/analytics_service.dart';
import '../../core/services/analytics/crashlytics_service.dart';
import '../../core/services/device/app_info_service.dart';
import '../../core/services/device/device_info_service.dart';
import '../../core/services/firebase/firebase_initializer.dart';
import '../../core/services/network/dio_client.dart';
import '../../core/services/network/network_info.dart';
import '../../core/services/permissions/permission_manager.dart';
import '../../core/services/remote_config/remote_config_service.dart';
import '../../core/services/storage/secure_storage_service.dart';

/// {@template core_providers}
/// Core dependency providers used across the app and shared by features.
///
/// Feature-specific providers are intentionally excluded here; they belong in
/// their respective feature packages.
/// {@endtemplate}

/// Application configuration.
final appConfigProvider = Provider<AppConfig>(
  (Ref ref) => AppConfig.fromEnvironment(),
  name: 'appConfigProvider',
);

/// Application logger.
final loggerProvider = Provider<AppLogger>(
  (Ref ref) => AppLogger(),
  name: 'loggerProvider',
);

/// Firebase initializer.
///
/// This is a future provider so widgets can await the initialization state
/// and show a splash screen.
final firebaseInitializerProvider = FutureProvider<FirebaseApp>((
  Ref ref,
) async {
  final AppLogger logger = ref.read(loggerProvider);
  final FirebaseInitializer initializer = FirebaseInitializer(logger: logger);
  return initializer.initialize();
}, name: 'firebaseInitializerProvider');

/// Firebase [FirebaseAuth] instance.
final firebaseAuthProvider = Provider<FirebaseAuth>(
  (Ref ref) => FirebaseAuth.instance,
  name: 'firebaseAuthProvider',
);

/// Firebase [FirebaseFirestore] instance.
final firebaseFirestoreProvider = Provider<FirebaseFirestore>(
  (Ref ref) => FirebaseFirestore.instance,
  name: 'firebaseFirestoreProvider',
);

/// Firebase [FirebaseStorage] instance.
final firebaseStorageProvider = Provider<FirebaseStorage>(
  (Ref ref) => FirebaseStorage.instance,
  name: 'firebaseStorageProvider',
);

/// Firebase [FirebaseMessaging] instance.
final firebaseMessagingProvider = Provider<FirebaseMessaging>(
  (Ref ref) => FirebaseMessaging.instance,
  name: 'firebaseMessagingProvider',
);

/// Firebase [FirebaseAnalytics] instance.
final firebaseAnalyticsProvider = Provider<FirebaseAnalytics>(
  (Ref ref) => FirebaseAnalytics.instance,
  name: 'firebaseAnalyticsProvider',
);

/// Firebase [FirebaseCrashlytics] instance.
final firebaseCrashlyticsProvider = Provider<FirebaseCrashlytics>(
  (Ref ref) => FirebaseCrashlytics.instance,
  name: 'firebaseCrashlyticsProvider',
);

/// Firebase [FirebaseRemoteConfig] instance.
final firebaseRemoteConfigProvider = Provider<FirebaseRemoteConfig>(
  (Ref ref) => FirebaseRemoteConfig.instance,
  name: 'firebaseRemoteConfigProvider',
);

/// Connectivity plugin.
final connectivityProvider = Provider<Connectivity>(
  (Ref ref) => Connectivity(),
  name: 'connectivityProvider',
);

/// Network information abstraction.
final networkInfoProvider = Provider<NetworkInfo>(
  (Ref ref) =>
      ConnectivityNetworkInfo(connectivity: ref.watch(connectivityProvider)),
  name: 'networkInfoProvider',
);

/// Secure storage service.
final secureStorageServiceProvider = Provider<SecureStorageService>(
  (Ref ref) => FlutterSecureStorageService(),
  name: 'secureStorageServiceProvider',
);

/// Analytics service.
final analyticsServiceProvider = Provider<AnalyticsService>(
  (Ref ref) =>
      AnalyticsService(analytics: ref.watch(firebaseAnalyticsProvider)),
  name: 'analyticsServiceProvider',
);

/// Crashlytics service.
final crashlyticsServiceProvider = Provider<CrashlyticsService>(
  (Ref ref) =>
      CrashlyticsService(crashlytics: ref.watch(firebaseCrashlyticsProvider)),
  name: 'crashlyticsServiceProvider',
);

/// Remote config service.
final remoteConfigServiceProvider = Provider<RemoteConfigService>(
  (Ref ref) => FirebaseRemoteConfigService(
    remoteConfig: ref.watch(firebaseRemoteConfigProvider),
  ),
  name: 'remoteConfigServiceProvider',
);

/// App info service.
final appInfoServiceProvider = Provider<AppInfoService>(
  (Ref ref) => AppInfoService(),
  name: 'appInfoServiceProvider',
);

/// Device info service.
final deviceInfoServiceProvider = Provider<DeviceInfoService>(
  (Ref ref) => DeviceInfoService(),
  name: 'deviceInfoServiceProvider',
);

/// Permission manager.
final permissionManagerProvider = Provider<PermissionManager>(
  (Ref ref) => const PermissionManager(),
  name: 'permissionManagerProvider',
);

/// Dio HTTP client.
final dioClientProvider = Provider<DioClient>(
  (Ref ref) => DioClient(
    config: ref.watch(appConfigProvider),
    logger: ref.watch(loggerProvider),
  ),
  name: 'dioClientProvider',
);
