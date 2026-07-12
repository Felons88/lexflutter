import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_durations.dart';
import 'app_radius.dart';
import 'app_shadows.dart';
import 'app_spacing.dart';
import 'app_typography.dart';

/// {@template app_theme}
/// Complete LEX [ThemeData] factory for dark and light modes.
///
/// Composes color schemes, typography, spacing, radius, shadow, and
/// component themes into a single source of truth.
/// {@endtemplate}
abstract final class AppTheme {
  /// {@macro app_theme}
  const AppTheme._();

  /// Dark theme - the primary LEX identity.
  static ThemeData get dark => _buildTheme(
    brightness: Brightness.dark,
    colors: AppColors.dark(),
    shadows: AppShadows.dark(),
  );

  /// Light theme - secondary mode with the same premium feel.
  static ThemeData get light => _buildTheme(
    brightness: Brightness.light,
    colors: AppColors.light(),
    shadows: AppShadows.light(),
  );

  static ThemeData _buildTheme({
    required Brightness brightness,
    required AppColors colors,
    required AppShadows shadows,
  }) {
    final bool isDark = brightness == Brightness.dark;
    final Color background = isDark
        ? const Color(0xFF0A0A0F)
        : const Color(0xFFF7F7FA);
    final Color surface = isDark ? const Color(0xFF14141C) : Colors.white;
    final Color surfaceContainerHighest = isDark
        ? const Color(0xFF1E1E2A)
        : const Color(0xFFF0F0F5);
    final Color onSurface = isDark ? Colors.white : const Color(0xFF0A0A0F);
    final Color onSurfaceVariant = isDark
        ? Colors.white70
        : const Color(0xFF6B6B7B);
    final Color outline = isDark
        ? const Color(0x33FFFFFF)
        : const Color(0xFFE0E0E5);
    final Color outlineVariant = isDark
        ? const Color(0x1AFFFFFF)
        : const Color(0xFFF0F0F5);

    final ColorScheme colorScheme = ColorScheme(
      brightness: brightness,
      primary: const Color(0xFF8A3FFC),
      onPrimary: Colors.white,
      secondary: const Color(0xFFFF2E8A),
      onSecondary: Colors.white,
      tertiary: const Color(0xFF00B0FF),
      onTertiary: Colors.white,
      error: const Color(0xFFFF4D4D),
      onError: Colors.white,
      surface: surface,
      onSurface: onSurface,
      surfaceContainerHighest: surfaceContainerHighest,
      onSurfaceVariant: onSurfaceVariant,
      outline: outline,
      outlineVariant: outlineVariant,
      shadow: colors.shadow,
      inverseSurface: isDark ? Colors.white : const Color(0xFF0A0A0F),
      onInverseSurface: isDark ? const Color(0xFF0A0A0F) : Colors.white,
      inversePrimary: const Color(0xFF6C2AED),
      surfaceTint: const Color(0xFF8A3FFC),
      scrim: const Color(0x99000000),
    );

    final TextTheme textTheme = isDark
        ? AppTypography.dark
        : AppTypography.light;

    final ThemeData base = ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      textTheme: textTheme,
      scaffoldBackgroundColor: background,
      fontFamily: AppTypography.fontFamily,
      extensions: <ThemeExtension<dynamic>>[
        colors,
        AppSpacing.value,
        AppRadius.value,
        shadows,
        AppDurations.value,
      ],
    );

    return base.copyWith(
      appBarTheme: _appBarTheme(colorScheme, textTheme, colors),
      bottomAppBarTheme: BottomAppBarThemeData(
        color: surface,
        elevation: 0,
        shadowColor: colors.shadow,
      ),
      bottomNavigationBarTheme: _bottomNavigationBarTheme(colorScheme, colors),
      navigationBarTheme: _navigationBarTheme(colorScheme, colors),
      cardTheme: _cardThemeData(colorScheme, colors, shadows),
      chipTheme: _chipTheme(colorScheme, textTheme, colors),
      dialogTheme: _dialogThemeData(colorScheme, textTheme, colors, shadows),
      bottomSheetTheme: _bottomSheetTheme(colorScheme, colors, shadows),
      snackBarTheme: _snackBarTheme(colorScheme, textTheme, colors),
      inputDecorationTheme: _inputDecorationTheme(colorScheme, colors),
      elevatedButtonTheme: _elevatedButtonTheme(colorScheme, colors, shadows),
      outlinedButtonTheme: _outlinedButtonTheme(colorScheme, colors),
      textButtonTheme: _textButtonTheme(colorScheme, colors),
      iconButtonTheme: _iconButtonTheme(colorScheme),
      floatingActionButtonTheme: _floatingActionButtonTheme(
        colorScheme,
        colors,
      ),
      tabBarTheme: _tabBarThemeData(colorScheme, textTheme),
      dividerTheme: DividerThemeData(
        color: outlineVariant,
        thickness: 1,
        space: 1,
      ),
      splashFactory: InkRipple.splashFactory,
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: <TargetPlatform, PageTransitionsBuilder>{
          TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.windows: FadeUpwardsPageTransitionsBuilder(),
          TargetPlatform.linux: FadeUpwardsPageTransitionsBuilder(),
          TargetPlatform.fuchsia: FadeUpwardsPageTransitionsBuilder(),
        },
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }

  static AppBarTheme _appBarTheme(
    ColorScheme colorScheme,
    TextTheme textTheme,
    AppColors colors,
  ) {
    return AppBarTheme(
      backgroundColor: colorScheme.surface.withAlpha(200),
      foregroundColor: colorScheme.onSurface,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: true,
      titleTextStyle: textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.w700,
      ),
      iconTheme: IconThemeData(color: colorScheme.onSurface),
      actionsIconTheme: IconThemeData(color: colorScheme.onSurface),
      shadowColor: colors.shadow,
    );
  }

  static BottomNavigationBarThemeData _bottomNavigationBarTheme(
    ColorScheme colorScheme,
    AppColors colors,
  ) {
    return BottomNavigationBarThemeData(
      backgroundColor: colorScheme.surface.withAlpha(230),
      selectedItemColor: colorScheme.secondary,
      unselectedItemColor: colorScheme.onSurfaceVariant,
      selectedLabelStyle: const TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 12,
      ),
      unselectedLabelStyle: const TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 12,
      ),
      type: BottomNavigationBarType.fixed,
      elevation: 0,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      enableFeedback: true,
    );
  }

  static NavigationBarThemeData _navigationBarTheme(
    ColorScheme colorScheme,
    AppColors colors,
  ) {
    return NavigationBarThemeData(
      backgroundColor: colorScheme.surface.withAlpha(230),
      indicatorColor: colorScheme.primary.withAlpha(40),
      labelTextStyle: WidgetStateProperty.resolveWith((
        Set<WidgetState> states,
      ) {
        if (states.contains(WidgetState.selected)) {
          return TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: colorScheme.secondary,
          );
        }
        return TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: colorScheme.onSurfaceVariant,
        );
      }),
      iconTheme: WidgetStateProperty.resolveWith((Set<WidgetState> states) {
        if (states.contains(WidgetState.selected)) {
          return IconThemeData(color: colorScheme.secondary);
        }
        return IconThemeData(color: colorScheme.onSurfaceVariant);
      }),
      elevation: 0,
      shadowColor: colors.shadow,
    );
  }

  static CardThemeData _cardThemeData(
    ColorScheme colorScheme,
    AppColors colors,
    AppShadows shadows,
  ) {
    return CardThemeData(
      color: colorScheme.surface,
      elevation: 0,
      shadowColor: colors.shadow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.value.lg),
        side: BorderSide(color: colors.glassBorder),
      ),
      margin: EdgeInsets.zero,
    );
  }

  static ChipThemeData _chipTheme(
    ColorScheme colorScheme,
    TextTheme textTheme,
    AppColors colors,
  ) {
    return ChipThemeData(
      backgroundColor: colorScheme.surfaceContainerHighest,
      disabledColor: colorScheme.surfaceContainerHighest.withAlpha(80),
      selectedColor: colorScheme.primary.withAlpha(40),
      secondarySelectedColor: colorScheme.secondary.withAlpha(40),
      labelStyle: textTheme.labelLarge ?? const TextStyle(),
      secondaryLabelStyle: textTheme.labelLarge ?? const TextStyle(),
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.value.md,
        vertical: AppSpacing.value.sm,
      ),
      shape: StadiumBorder(side: BorderSide(color: colors.glassBorder)),
      iconTheme: IconThemeData(color: colorScheme.onSurface, size: 18),
      elevation: 0,
      pressElevation: 0,
    );
  }

  static DialogThemeData _dialogThemeData(
    ColorScheme colorScheme,
    TextTheme textTheme,
    AppColors colors,
    AppShadows shadows,
  ) {
    return DialogThemeData(
      backgroundColor: colorScheme.surface,
      elevation: 0,
      shadowColor: colors.shadow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.value.xl),
        side: BorderSide(color: colors.glassBorder),
      ),
      titleTextStyle: textTheme.titleLarge,
      contentTextStyle: textTheme.bodyMedium,
    );
  }

  static BottomSheetThemeData _bottomSheetTheme(
    ColorScheme colorScheme,
    AppColors colors,
    AppShadows shadows,
  ) {
    return BottomSheetThemeData(
      backgroundColor: colorScheme.surface,
      modalBackgroundColor: colorScheme.surface,
      elevation: 0,
      shadowColor: colors.shadow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppRadius.value.xl),
          topRight: Radius.circular(AppRadius.value.xl),
        ),
        side: BorderSide(color: colors.glassBorder),
      ),
      modalElevation: 0,
      modalBarrierColor: colorScheme.scrim,
      clipBehavior: Clip.antiAlias,
    );
  }

  static SnackBarThemeData _snackBarTheme(
    ColorScheme colorScheme,
    TextTheme textTheme,
    AppColors colors,
  ) {
    return SnackBarThemeData(
      backgroundColor: colorScheme.surfaceContainerHighest,
      contentTextStyle: textTheme.bodyMedium,
      actionTextColor: colorScheme.secondary,
      disabledActionTextColor: colorScheme.onSurfaceVariant,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.value.md),
      ),
      behavior: SnackBarBehavior.floating,
      insetPadding: EdgeInsets.all(AppSpacing.value.lg),
    );
  }

  static InputDecorationTheme _inputDecorationTheme(
    ColorScheme colorScheme,
    AppColors colors,
  ) {
    return InputDecorationTheme(
      filled: true,
      fillColor: colorScheme.surfaceContainerHighest,
      contentPadding: EdgeInsets.symmetric(
        horizontal: AppSpacing.value.lg,
        vertical: AppSpacing.value.md,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.value.lg),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.value.lg),
        borderSide: BorderSide(color: colors.glassBorder),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.value.lg),
        borderSide: BorderSide(color: colorScheme.primary, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.value.lg),
        borderSide: BorderSide(color: colorScheme.error),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.value.lg),
        borderSide: BorderSide(color: colorScheme.error, width: 1.5),
      ),
      hintStyle: TextStyle(color: colorScheme.onSurfaceVariant),
      labelStyle: TextStyle(color: colorScheme.onSurfaceVariant),
      prefixIconColor: colorScheme.onSurfaceVariant,
      suffixIconColor: colorScheme.onSurfaceVariant,
    );
  }

  static ElevatedButtonThemeData _elevatedButtonTheme(
    ColorScheme colorScheme,
    AppColors colors,
    AppShadows shadows,
  ) {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: colorScheme.primary,
        disabledForegroundColor: colorScheme.onSurfaceVariant,
        disabledBackgroundColor: colorScheme.surfaceContainerHighest,
        elevation: 0,
        shadowColor: colors.shadow,
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.value.xl,
          vertical: AppSpacing.value.md,
        ),
        shape: StadiumBorder(side: BorderSide(color: colors.glassBorder)),
        textStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.1,
        ),
      ),
    );
  }

  static OutlinedButtonThemeData _outlinedButtonTheme(
    ColorScheme colorScheme,
    AppColors colors,
  ) {
    return OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: colorScheme.onSurface,
        disabledForegroundColor: colorScheme.onSurfaceVariant,
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.value.xl,
          vertical: AppSpacing.value.md,
        ),
        side: BorderSide(color: colors.glassBorder),
        shape: StadiumBorder(side: BorderSide(color: colors.glassBorder)),
        textStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.1,
        ),
      ),
    );
  }

  static TextButtonThemeData _textButtonTheme(
    ColorScheme colorScheme,
    AppColors colors,
  ) {
    return TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: colorScheme.secondary,
        disabledForegroundColor: colorScheme.onSurfaceVariant,
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.value.md,
          vertical: AppSpacing.value.sm,
        ),
        textStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.1,
        ),
      ),
    );
  }

  static IconButtonThemeData _iconButtonTheme(ColorScheme colorScheme) {
    return IconButtonThemeData(
      style: IconButton.styleFrom(
        foregroundColor: colorScheme.onSurface,
        backgroundColor: colorScheme.surfaceContainerHighest,
        disabledForegroundColor: colorScheme.onSurfaceVariant,
        shape: const CircleBorder(),
      ),
    );
  }

  static FloatingActionButtonThemeData _floatingActionButtonTheme(
    ColorScheme colorScheme,
    AppColors colors,
  ) {
    return FloatingActionButtonThemeData(
      backgroundColor: colorScheme.secondary,
      foregroundColor: Colors.white,
      elevation: 0,
      disabledElevation: 0,
      highlightElevation: 0,
      shape: const CircleBorder(),
    );
  }

  static TabBarThemeData _tabBarThemeData(
    ColorScheme colorScheme,
    TextTheme textTheme,
  ) {
    return TabBarThemeData(
      labelColor: colorScheme.onSurface,
      unselectedLabelColor: colorScheme.onSurfaceVariant,
      labelStyle: textTheme.labelLarge,
      unselectedLabelStyle: textTheme.labelLarge,
      indicatorColor: colorScheme.secondary,
      dividerColor: colorScheme.outlineVariant,
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(color: colorScheme.secondary, width: 2),
        insets: EdgeInsets.symmetric(horizontal: AppSpacing.value.lg),
      ),
    );
  }

  static TextTheme get textTheme => AppTypography.dark;
}
