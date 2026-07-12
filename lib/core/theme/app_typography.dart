import 'package:flutter/material.dart';

/// {@template app_typography}
/// Material 3 typography configured for the LEX premium identity.
///
/// Uses [Typography.material2021] as a base and overrides the size/weight
/// scale for the luxury marketplace feel.  Roboto is the fallback family.
/// {@endtemplate}
abstract final class AppTypography {
  /// Font family used throughout the app.
  static const String fontFamily = 'Roboto';

  /// Dark text theme for the default dark interface.
  static TextTheme get dark => _buildTextTheme(Brightness.dark);

  /// Light text theme for the optional light interface.
  static TextTheme get light => _buildTextTheme(Brightness.light);

  static TextTheme _buildTextTheme(Brightness brightness) {
    final Color displayColor =
        brightness == Brightness.dark ? Colors.white : const Color(0xFF0A0A0F);
    final Color bodyColor =
        brightness == Brightness.dark ? Colors.white70 : const Color(0xFF1E1E2A);

    final TextTheme base = Typography.material2021().white.copyWith(
          displayLarge: const TextStyle(
            fontFamily: fontFamily,
            fontSize: 57,
            fontWeight: FontWeight.w700,
            height: 1.12,
            letterSpacing: -0.25,
          ),
          displayMedium: const TextStyle(
            fontFamily: fontFamily,
            fontSize: 45,
            fontWeight: FontWeight.w700,
            height: 1.16,
            letterSpacing: 0,
          ),
          displaySmall: const TextStyle(
            fontFamily: fontFamily,
            fontSize: 36,
            fontWeight: FontWeight.w700,
            height: 1.22,
            letterSpacing: 0,
          ),
          headlineLarge: const TextStyle(
            fontFamily: fontFamily,
            fontSize: 32,
            fontWeight: FontWeight.w700,
            height: 1.25,
            letterSpacing: 0,
          ),
          headlineMedium: const TextStyle(
            fontFamily: fontFamily,
            fontSize: 28,
            fontWeight: FontWeight.w600,
            height: 1.28,
            letterSpacing: 0,
          ),
          headlineSmall: const TextStyle(
            fontFamily: fontFamily,
            fontSize: 24,
            fontWeight: FontWeight.w600,
            height: 1.33,
            letterSpacing: 0,
          ),
          titleLarge: const TextStyle(
            fontFamily: fontFamily,
            fontSize: 22,
            fontWeight: FontWeight.w600,
            height: 1.27,
            letterSpacing: 0,
          ),
          titleMedium: const TextStyle(
            fontFamily: fontFamily,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            height: 1.5,
            letterSpacing: 0.15,
          ),
          titleSmall: const TextStyle(
            fontFamily: fontFamily,
            fontSize: 14,
            fontWeight: FontWeight.w600,
            height: 1.43,
            letterSpacing: 0.1,
          ),
          bodyLarge: const TextStyle(
            fontFamily: fontFamily,
            fontSize: 16,
            fontWeight: FontWeight.w400,
            height: 1.5,
            letterSpacing: 0.5,
          ),
          bodyMedium: const TextStyle(
            fontFamily: fontFamily,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            height: 1.5,
            letterSpacing: 0.25,
          ),
          bodySmall: const TextStyle(
            fontFamily: fontFamily,
            fontSize: 12,
            fontWeight: FontWeight.w400,
            height: 1.33,
            letterSpacing: 0.4,
          ),
          labelLarge: const TextStyle(
            fontFamily: fontFamily,
            fontSize: 14,
            fontWeight: FontWeight.w600,
            height: 1.43,
            letterSpacing: 0.1,
          ),
          labelMedium: const TextStyle(
            fontFamily: fontFamily,
            fontSize: 12,
            fontWeight: FontWeight.w600,
            height: 1.33,
            letterSpacing: 0.5,
          ),
          labelSmall: const TextStyle(
            fontFamily: fontFamily,
            fontSize: 11,
            fontWeight: FontWeight.w600,
            height: 1.45,
            letterSpacing: 0.5,
          ),
        );

    return base.apply(
      displayColor: displayColor,
      bodyColor: bodyColor,
      fontFamily: fontFamily,
    );
  }

  const AppTypography._();
}
