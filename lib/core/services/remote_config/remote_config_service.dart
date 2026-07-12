import 'package:firebase_remote_config/firebase_remote_config.dart';

/// {@template remote_config_service}
/// Abstract feature flag and remote configuration gateway.
/// {@endtemplate}
abstract interface class RemoteConfigService {
  /// Initializes and fetches the latest remote config values.
  Future<bool> initialize();

  /// Returns a string value for [key] or [defaultValue] if missing.
  String getString(String key, {String defaultValue = ''});

  /// Returns a boolean value for [key] or [defaultValue] if missing.
  bool getBool(String key, {bool defaultValue = false});

  /// Returns an integer value for [key] or [defaultValue] if missing.
  int getInt(String key, {int defaultValue = 0});

  /// Returns a double value for [key] or [defaultValue] if missing.
  double getDouble(String key, {double defaultValue = 0});
}

/// {@template firebase_remote_config_service}
/// [RemoteConfigService] implementation backed by [FirebaseRemoteConfig].
/// {@endtemplate}
class FirebaseRemoteConfigService implements RemoteConfigService {
  /// {@macro firebase_remote_config_service}
  FirebaseRemoteConfigService({FirebaseRemoteConfig? remoteConfig})
      : _remoteConfig = remoteConfig ?? FirebaseRemoteConfig.instance;

  final FirebaseRemoteConfig _remoteConfig;

  @override
  Future<bool> initialize() async {
    await _remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(minutes: 1),
        minimumFetchInterval: const Duration(hours: 1),
      ),
    );
    await _remoteConfig.setDefaults(<String, dynamic>{});
    return _remoteConfig.fetchAndActivate();
  }

  @override
  String getString(String key, {String defaultValue = ''}) {
    return _remoteConfig.getString(key).isEmpty
        ? defaultValue
        : _remoteConfig.getString(key);
  }

  @override
  bool getBool(String key, {bool defaultValue = false}) {
    return _remoteConfig.getBool(key);
  }

  @override
  int getInt(String key, {int defaultValue = 0}) {
    return _remoteConfig.getInt(key);
  }

  @override
  double getDouble(String key, {double defaultValue = 0}) {
    return _remoteConfig.getDouble(key);
  }
}
