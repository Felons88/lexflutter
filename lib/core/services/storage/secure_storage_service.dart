import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// {@template secure_storage_service}
/// Abstract secure key/value storage used by repositories and providers.
/// {@endtemplate}
abstract interface class SecureStorageService {
  /// Writes [value] for [key].
  Future<void> write({required String key, required String value});

  /// Reads the value for [key], or null if not present.
  Future<String?> read({required String key});

  /// Deletes the value for [key].
  Future<void> delete({required String key});

  /// Deletes all stored values.
  Future<void> deleteAll();
}

/// {@template flutter_secure_storage_service}
/// [SecureStorageService] implementation backed by [flutter_secure_storage].
/// {@endtemplate}
class FlutterSecureStorageService implements SecureStorageService {
  /// {@macro flutter_secure_storage_service}
  FlutterSecureStorageService({FlutterSecureStorage? storage})
      : _storage = storage ?? const FlutterSecureStorage();

  final FlutterSecureStorage _storage;

  @override
  Future<void> write({required String key, required String value}) async {
    await _storage.write(key: key, value: value);
  }

  @override
  Future<String?> read({required String key}) async {
    return _storage.read(key: key);
  }

  @override
  Future<void> delete({required String key}) async {
    await _storage.delete(key: key);
  }

  @override
  Future<void> deleteAll() async {
    await _storage.deleteAll();
  }
}
