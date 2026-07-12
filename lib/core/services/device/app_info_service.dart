import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';

/// {@template app_info}
/// Immutable application package metadata.
/// {@endtemplate}
@immutable
class AppInfo {
  /// {@macro app_info}
  const AppInfo({
    required this.appName,
    required this.packageName,
    required this.version,
    required this.buildNumber,
  });

  /// Display name of the application.
  final String appName;

  /// Package name / bundle identifier.
  final String packageName;

  /// Human-readable version string.
  final String version;

  /// Build number string.
  final String buildNumber;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AppInfo && other.version == version;
  }

  @override
  int get hashCode => version.hashCode;
}

/// {@template app_info_service}
/// Loads and exposes package metadata using [package_info_plus].
/// {@endtemplate}
class AppInfoService {
  /// {@macro app_info_service}
  AppInfoService({this._packageInfo});

  PackageInfo? _packageInfo;

  /// Loads the package info once and caches it.
  Future<AppInfo> getInfo() async {
    _packageInfo ??= await PackageInfo.fromPlatform();
    return _toAppInfo(_packageInfo!);
  }

  AppInfo _toAppInfo(PackageInfo info) {
    return AppInfo(
      appName: info.appName,
      packageName: info.packageName,
      version: info.version,
      buildNumber: info.buildNumber,
    );
  }
}
