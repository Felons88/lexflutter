/// {@template environment}
/// Supported runtime environments for the LEX application.
/// {@endtemplate}
enum Environment {
  /// Local development with permissive flags and verbose logging.
  dev,

  /// Staging environment for QA and preview builds.
  staging,

  /// Production environment with strict flags and telemetry enabled.
  prod,
}

/// {@template environment_extensions}
/// Helpers for [Environment] parsing.
/// {@endtemplate}
extension EnvironmentExtensions on Environment {
  /// Returns true when the environment is [Environment.prod].
  bool get isProduction => this == Environment.prod;

  /// Returns true when the environment is [Environment.dev].
  bool get isDevelopment => this == Environment.dev;

  /// Returns true when the environment is [Environment.staging].
  bool get isStaging => this == Environment.staging;
}
