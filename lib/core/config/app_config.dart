import 'package:flutter/foundation.dart';

import 'environment.dart';

/// {@template app_config}
/// Immutable application configuration resolved at startup.
///
/// Values are read from compile-time environment variables via
/// [String.fromEnvironment] and sensible defaults for development.
/// {@endtemplate}
@immutable
class AppConfig {
  /// {@macro app_config}
  const AppConfig({
    required this.environment,
    required this.apiBaseUrl,
    required this.apiKey,
    required this.connectTimeoutSeconds,
    required this.receiveTimeoutSeconds,
    required this.sendTimeoutSeconds,
    required this.enableLogging,
    required this.enforceAuth,
  });

  /// Resolves [AppConfig] from the current environment.
  factory AppConfig.fromEnvironment() {
    const String envString = String.fromEnvironment('ENV', defaultValue: 'dev');
    final Environment environment = _parseEnvironment(envString);

    return AppConfig(
      environment: environment,
      apiBaseUrl: const String.fromEnvironment('API_BASE_URL'),
      apiKey: const String.fromEnvironment('API_KEY'),
      connectTimeoutSeconds: const int.fromEnvironment(
        'CONNECT_TIMEOUT_SECONDS',
        defaultValue: 30,
      ),
      receiveTimeoutSeconds: const int.fromEnvironment(
        'RECEIVE_TIMEOUT_SECONDS',
        defaultValue: 30,
      ),
      sendTimeoutSeconds: const int.fromEnvironment(
        'SEND_TIMEOUT_SECONDS',
        defaultValue: 30,
      ),
      enableLogging: !environment.isProduction,
      enforceAuth: environment.isProduction,
    );
  }

  /// Runtime environment.
  final Environment environment;

  /// Backend API base URL.
  final String apiBaseUrl;

  /// Backend API key.
  final String apiKey;

  /// Connection timeout in seconds.
  final int connectTimeoutSeconds;

  /// Receive timeout in seconds.
  final int receiveTimeoutSeconds;

  /// Send timeout in seconds.
  final int sendTimeoutSeconds;

  /// Whether verbose logging is enabled.
  final bool enableLogging;

  /// Whether authentication route guards are enforced.
  final bool enforceAuth;

  static Environment _parseEnvironment(String value) {
    return switch (value.toLowerCase()) {
      'prod' || 'production' => Environment.prod,
      'staging' || 'stage' => Environment.staging,
      _ => Environment.dev,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AppConfig && other.environment == environment;
  }

  @override
  int get hashCode => environment.hashCode;

  @override
  String toString() => 'AppConfig(environment: $environment)';
}
