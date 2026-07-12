import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_durations.dart';
import '../theme/app_radius.dart';
import '../theme/app_shadows.dart';
import '../theme/app_spacing.dart';

export '../theme/app_colors.dart';
export '../theme/app_durations.dart';
export '../theme/app_radius.dart';
export '../theme/app_shadows.dart';
export '../theme/app_spacing.dart';

/// {@template build_context_extensions}
/// Convenience accessors for the LEX design system and screen metrics.
/// {@endtemplate}
extension BuildContextExtensions on BuildContext {
  /// The closest [ThemeData].
  ThemeData get theme => Theme.of(this);

  /// The [ColorScheme] from the current theme.
  ColorScheme get colorScheme => theme.colorScheme;

  /// Whether the current theme is dark.
  bool get isDark => theme.brightness == Brightness.dark;

  /// The [TextTheme] from the current theme.
  TextTheme get textTheme => theme.textTheme;

  /// The LEX extended color tokens.
  AppColors get appColors => theme.extension<AppColors>() ?? AppColors.dark();

  /// The LEX spacing tokens.
  AppSpacing get appSpacing =>
      theme.extension<AppSpacing>() ?? AppSpacing.value;

  /// The LEX radius tokens.
  AppRadius get appRadius => theme.extension<AppRadius>() ?? AppRadius.value;

  /// The LEX shadow tokens.
  AppShadows get appShadows =>
      theme.extension<AppShadows>() ?? AppShadows.dark();

  /// The LEX animation duration tokens.
  AppDurations get appDurations =>
      theme.extension<AppDurations>() ?? AppDurations.value;

  /// The [MediaQueryData] for the context.
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  /// The current screen size.
  Size get screenSize => mediaQuery.size;

  /// The current screen width.
  double get screenWidth => screenSize.width;

  /// The current screen height.
  double get screenHeight => screenSize.height;

  /// The safe area padding.
  EdgeInsets get safePadding => MediaQuery.paddingOf(this);

  /// The current text scaler.
  TextScaler get textScaler => mediaQuery.textScaler;
}
