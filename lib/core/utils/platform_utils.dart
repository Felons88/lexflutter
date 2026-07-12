import 'dart:io';

import 'package:flutter/foundation.dart';

/// {@template platform_utils}
/// Platform detection helpers.
/// {@endtemplate}
abstract final class PlatformUtils {
  const PlatformUtils._();

  /// True when running on the web.
  static bool get isWeb => kIsWeb;

  /// True when running on Android.
  static bool get isAndroid => !kIsWeb && Platform.isAndroid;

  /// True when running on iOS.
  static bool get isIOS => !kIsWeb && Platform.isIOS;

  /// True when running on macOS.
  static bool get isMacOS => !kIsWeb && Platform.isMacOS;

  /// True when running on Windows.
  static bool get isWindows => !kIsWeb && Platform.isWindows;

  /// True when running on Linux.
  static bool get isLinux => !kIsWeb && Platform.isLinux;

  /// True when running on a mobile device.
  static bool get isMobile => isAndroid || isIOS;

  /// True when running on a desktop device.
  static bool get isDesktop => isMacOS || isWindows || isLinux;

  /// True when running on Apple platforms (iOS / macOS).
  static bool get isApple => isIOS || isMacOS;
}
