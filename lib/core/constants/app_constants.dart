/// {@template app_constants}
/// Application-wide constants that do not vary by environment.
/// {@endtemplate}
abstract final class AppConstants {
  /// App display name.
  static const String appName = 'LEX';

  /// Default locale tag.
  static const String defaultLocale = 'en_US';

  /// Default currency code.
  static const String defaultCurrency = 'USD';

  /// Default currency symbol.
  static const String defaultCurrencySymbol = '\$';

  /// Maximum cache age for network images in days.
  static const int maxCacheAgeDays = 7;

  /// Max upload size for images in bytes (10 MB).
  static const int maxUploadSizeBytes = 10 * 1024 * 1024;

  const AppConstants._();
}
