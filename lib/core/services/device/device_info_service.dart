import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';

/// {@template device_info}
/// Normalized device metadata.
/// {@endtemplate}
@immutable
class DeviceInfo {
  /// {@macro device_info}
  const DeviceInfo({
    required this.deviceId,
    required this.brand,
    required this.model,
    required this.osVersion,
    required this.platform,
  });

  /// Stable device identifier or empty string.
  final String deviceId;

  /// Device brand / manufacturer.
  final String brand;

  /// Device model name.
  final String model;

  /// OS version string.
  final String osVersion;

  /// Platform name (ios, android, web, windows, macos, linux).
  final String platform;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is DeviceInfo && other.deviceId == deviceId;
  }

  @override
  int get hashCode => deviceId.hashCode;
}

/// {@template device_info_service}
/// Loads device metadata using [device_info_plus].
/// {@endtemplate}
class DeviceInfoService {
  /// {@macro device_info_service}
  DeviceInfoService({DeviceInfoPlugin? plugin})
    : _plugin = plugin ?? DeviceInfoPlugin();

  final DeviceInfoPlugin _plugin;

  /// Loads device info.
  Future<DeviceInfo> getInfo() async {
    if (kIsWeb) {
      final WebBrowserInfo info = await _plugin.webBrowserInfo;
      return DeviceInfo(
        deviceId: '',
        brand: info.browserName.name,
        model: info.platform ?? 'web',
        osVersion: info.appVersion ?? '',
        platform: 'web',
      );
    }

    if (Platform.isAndroid) {
      final AndroidDeviceInfo info = await _plugin.androidInfo;
      return DeviceInfo(
        deviceId: info.id,
        brand: info.brand,
        model: info.model,
        osVersion: 'Android ${info.version.release}',
        platform: 'android',
      );
    }

    if (Platform.isIOS) {
      final IosDeviceInfo info = await _plugin.iosInfo;
      return DeviceInfo(
        deviceId: info.identifierForVendor ?? '',
        brand: 'Apple',
        model: info.modelName,
        osVersion: 'iOS ${info.systemVersion}',
        platform: 'ios',
      );
    }

    if (Platform.isWindows) {
      final WindowsDeviceInfo info = await _plugin.windowsInfo;
      return DeviceInfo(
        deviceId: info.deviceId,
        brand: 'Microsoft',
        model: info.computerName,
        osVersion: info.displayVersion,
        platform: 'windows',
      );
    }

    if (Platform.isMacOS) {
      final MacOsDeviceInfo info = await _plugin.macOsInfo;
      return DeviceInfo(
        deviceId: info.systemGUID ?? '',
        brand: 'Apple',
        model: info.model,
        osVersion: 'macOS ${info.osRelease}',
        platform: 'macos',
      );
    }

    if (Platform.isLinux) {
      final LinuxDeviceInfo info = await _plugin.linuxInfo;
      return DeviceInfo(
        deviceId: info.machineId ?? '',
        brand: info.name,
        model: info.prettyName,
        osVersion: info.versionId ?? '',
        platform: 'linux',
      );
    }

    return const DeviceInfo(
      deviceId: '',
      brand: 'Unknown',
      model: 'Unknown',
      osVersion: '',
      platform: 'unknown',
    );
  }
}
