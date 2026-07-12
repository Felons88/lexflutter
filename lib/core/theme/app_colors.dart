import 'package:flutter/material.dart';

/// {@template app_colors}
/// Premium design-token colors for the LEX dark/light themes.
///
/// These values are not a palette dump; they are the semantic values consumed
/// by widgets and component themes.  Standard colors live in [ThemeData.colorScheme];
/// this extension carries gradients, glass, and status accents.
/// {@endtemplate}
@immutable
class AppColors extends ThemeExtension<AppColors> {
  /// {@macro app_colors}
  const AppColors({
    required this.primaryGradient,
    required this.accentGradient,
    required this.surfaceGradient,
    required this.success,
    required this.onSuccess,
    required this.warning,
    required this.onWarning,
    required this.info,
    required this.onInfo,
    required this.glassBackground,
    required this.glassBorder,
    required this.shadow,
    required this.shimmerBase,
    required this.shimmerHighlight,
  });

  /// Premium purple/magenta gradient used for CTAs, hero accents, and
  /// immersive backgrounds.
  final LinearGradient primaryGradient;

  /// Magenta/purple accent gradient used for highlights, badges, and
  /// emphasis states.
  final LinearGradient accentGradient;

  /// Subtle dark/elevated gradient used for floating cards and sheets.
  final LinearGradient surfaceGradient;

  /// Success / online / positive state color.
  final Color success;

  /// Content color on top of [success].
  final Color onSuccess;

  /// Warning / attention state color.
  final Color warning;

  /// Content color on top of [warning].
  final Color onWarning;

  /// Information / helper state color.
  final Color info;

  /// Content color on top of [info].
  final Color onInfo;

  /// Background color for glassmorphism cards.
  final Color glassBackground;

  /// Border color for glassmorphism cards.
  final Color glassBorder;

  /// Shadow tint used for premium elevation.
  final Color shadow;

  /// Shimmer placeholder base color.
  final Color shimmerBase;

  /// Shimmer placeholder highlight color.
  final Color shimmerHighlight;

  /// Creates the dark palette used as the LEX primary identity.
  factory AppColors.dark() => const AppColors(
    primaryGradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: <Color>[Color(0xFF8A3FFC), Color(0xFFFF2E8A)],
    ),
    accentGradient: LinearGradient(
      colors: <Color>[Color(0xFFFF2E8A), Color(0xFF8A3FFC)],
    ),
    surfaceGradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: <Color>[Color(0xFF1E1E2A), Color(0xFF0A0A0F)],
    ),
    success: Color(0xFF00E676),
    onSuccess: Color(0xFF000000),
    warning: Color(0xFFFFB300),
    onWarning: Color(0xFF000000),
    info: Color(0xFF00B0FF),
    onInfo: Color(0xFF000000),
    glassBackground: Color(0x1AFFFFFF),
    glassBorder: Color(0x33FFFFFF),
    shadow: Color(0xFF000000),
    shimmerBase: Color(0xFF1E1E2A),
    shimmerHighlight: Color(0xFF2A2A3A),
  );

  /// Creates the light palette, maintaining the same premium identity.
  factory AppColors.light() => const AppColors(
    primaryGradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: <Color>[Color(0xFF6C2AED), Color(0xFFFF0055)],
    ),
    accentGradient: LinearGradient(
      colors: <Color>[Color(0xFFFF0055), Color(0xFF6C2AED)],
    ),
    surfaceGradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: <Color>[Color(0xFFFFFFFF), Color(0xFFF7F7FA)],
    ),
    success: Color(0xFF00C853),
    onSuccess: Color(0xFFFFFFFF),
    warning: Color(0xFFFFA000),
    onWarning: Color(0xFFFFFFFF),
    info: Color(0xFF0091EA),
    onInfo: Color(0xFFFFFFFF),
    glassBackground: Color(0x80FFFFFF),
    glassBorder: Color(0x33FFFFFF),
    shadow: Color(0x1F000000),
    shimmerBase: Color(0xFFE0E0E0),
    shimmerHighlight: Color(0xFFF5F5F5),
  );

  @override
  AppColors copyWith({
    LinearGradient? primaryGradient,
    LinearGradient? accentGradient,
    LinearGradient? surfaceGradient,
    Color? success,
    Color? onSuccess,
    Color? warning,
    Color? onWarning,
    Color? info,
    Color? onInfo,
    Color? glassBackground,
    Color? glassBorder,
    Color? shadow,
    Color? shimmerBase,
    Color? shimmerHighlight,
  }) => AppColors(
    primaryGradient: primaryGradient ?? this.primaryGradient,
    accentGradient: accentGradient ?? this.accentGradient,
    surfaceGradient: surfaceGradient ?? this.surfaceGradient,
    success: success ?? this.success,
    onSuccess: onSuccess ?? this.onSuccess,
    warning: warning ?? this.warning,
    onWarning: onWarning ?? this.onWarning,
    info: info ?? this.info,
    onInfo: onInfo ?? this.onInfo,
    glassBackground: glassBackground ?? this.glassBackground,
    glassBorder: glassBorder ?? this.glassBorder,
    shadow: shadow ?? this.shadow,
    shimmerBase: shimmerBase ?? this.shimmerBase,
    shimmerHighlight: shimmerHighlight ?? this.shimmerHighlight,
  );

  @override
  AppColors lerp(AppColors? other, double t) {
    if (other == null) {
      return this;
    }

    return AppColors(
      primaryGradient: _lerpGradient(primaryGradient, other.primaryGradient, t),
      accentGradient: _lerpGradient(accentGradient, other.accentGradient, t),
      surfaceGradient: _lerpGradient(surfaceGradient, other.surfaceGradient, t),
      success: Color.lerp(success, other.success, t) ?? success,
      onSuccess: Color.lerp(onSuccess, other.onSuccess, t) ?? onSuccess,
      warning: Color.lerp(warning, other.warning, t) ?? warning,
      onWarning: Color.lerp(onWarning, other.onWarning, t) ?? onWarning,
      info: Color.lerp(info, other.info, t) ?? info,
      onInfo: Color.lerp(onInfo, other.onInfo, t) ?? onInfo,
      glassBackground:
          Color.lerp(glassBackground, other.glassBackground, t) ??
          glassBackground,
      glassBorder: Color.lerp(glassBorder, other.glassBorder, t) ?? glassBorder,
      shadow: Color.lerp(shadow, other.shadow, t) ?? shadow,
      shimmerBase: Color.lerp(shimmerBase, other.shimmerBase, t) ?? shimmerBase,
      shimmerHighlight:
          Color.lerp(shimmerHighlight, other.shimmerHighlight, t) ??
          shimmerHighlight,
    );
  }

  LinearGradient _lerpGradient(LinearGradient a, LinearGradient b, double t) {
    final Gradient? lerped = Gradient.lerp(a, b, t);
    if (lerped is LinearGradient) {
      return lerped;
    }
    return t < 0.5 ? a : b;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is AppColors &&
        other.primaryGradient == primaryGradient &&
        other.accentGradient == accentGradient &&
        other.surfaceGradient == surfaceGradient &&
        other.success == success &&
        other.onSuccess == onSuccess &&
        other.warning == warning &&
        other.onWarning == onWarning &&
        other.info == info &&
        other.onInfo == onInfo &&
        other.glassBackground == glassBackground &&
        other.glassBorder == glassBorder &&
        other.shadow == shadow &&
        other.shimmerBase == shimmerBase &&
        other.shimmerHighlight == shimmerHighlight;
  }

  @override
  int get hashCode => Object.hash(
    primaryGradient,
    accentGradient,
    surfaceGradient,
    success,
    onSuccess,
    warning,
    onWarning,
    info,
    onInfo,
    glassBackground,
    glassBorder,
    shadow,
    shimmerBase,
    shimmerHighlight,
  );
}
