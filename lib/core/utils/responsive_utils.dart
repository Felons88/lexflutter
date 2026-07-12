import 'package:flutter/material.dart';

/// {@template screen_type}
/// Logical screen categories used by the responsive layout engine.
/// {@endtemplate}
enum ScreenType {
  /// Small phones (< 360 logical pixels).
  smallPhone,

  /// Large phones (360 - 600 logical pixels).
  largePhone,

  /// Foldable devices when unfolded (600 - 840 logical pixels).
  foldable,

  /// Tablets (840 - 1200 logical pixels).
  tablet,

  /// Large tablets / desktop (> 1200 logical pixels).
  desktop,
}

/// {@template responsive_utils}
/// Responsive helpers and a builder widget that adapts to screen size,
/// orientation, foldable form factors, and text scaling.
/// {@endtemplate}
@immutable
class ResponsiveUtils {
  /// {@macro responsive_utils}
  const ResponsiveUtils(this.size, this.orientation);

  /// Creates responsive data from the given [BuildContext].
  factory ResponsiveUtils.of(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    final Orientation orientation = MediaQuery.orientationOf(context);
    return ResponsiveUtils(size, orientation);
  }

  /// Current logical screen size.
  final Size size;

  /// Current device orientation.
  final Orientation orientation;

  /// Shortest side of the screen.
  double get shortestSide => size.shortestSide;

  /// Longest side of the screen.
  double get longestSide => size.longestSide;

  /// Current screen width.
  double get width => size.width;

  /// Current screen height.
  double get height => size.height;

  /// Whether the device is currently in landscape orientation.
  bool get isLandscape => orientation == Orientation.landscape;

  /// Whether the device is currently in portrait orientation.
  bool get isPortrait => orientation == Orientation.portrait;

  /// True for phones or smaller.
  bool get isPhone =>
      screenType != ScreenType.tablet &&
      screenType != ScreenType.desktop &&
      screenType != ScreenType.foldable;

  /// True for foldable devices.
  bool get isFoldable => screenType == ScreenType.foldable;

  /// True for tablets and larger.
  bool get isTablet =>
      screenType == ScreenType.tablet || screenType == ScreenType.desktop;

  /// True for desktop / large tablets.
  bool get isDesktop => screenType == ScreenType.desktop;

  /// Screen type category based on the shortest side.
  ScreenType get screenType {
    if (shortestSide >= 1200) return ScreenType.desktop;
    if (shortestSide >= 840) return ScreenType.tablet;
    if (shortestSide >= 600) return ScreenType.foldable;
    if (shortestSide >= 360) return ScreenType.largePhone;
    return ScreenType.smallPhone;
  }

  /// Returns a value based on screen type.
  T responsiveValue<T>({
    T? smallPhone,
    T? largePhone,
    T? foldable,
    T? tablet,
    T? desktop,
    required T mobile,
  }) {
    return switch (screenType) {
      ScreenType.smallPhone => smallPhone ?? mobile,
      ScreenType.largePhone => largePhone ?? mobile,
      ScreenType.foldable => foldable ?? tablet ?? mobile,
      ScreenType.tablet => tablet ?? mobile,
      ScreenType.desktop => desktop ?? tablet ?? mobile,
    };
  }

  /// Scales a [value] by the current screen size relative to a base width.
  double scale(double value, {double baseWidth = 375}) =>
      (width / baseWidth) * value;

  /// Clamps a [value] to a reasonable range for the current screen type.
  double clampedScale(double value, {double min = 0.8, double max = 1.5}) =>
      scale(value).clamp(value * min, value * max);
}

/// {@template responsive_layout}
/// A widget that rebuilds when the screen size or orientation changes and
/// provides a responsive utility object to the builder.
///
/// Optionally wraps the child with [SafeArea] and clamps text scaling.
/// {@endtemplate}
class ResponsiveLayout extends StatelessWidget {
  /// {@macro responsive_layout}
  const ResponsiveLayout({
    required this.builder,
    this.useSafeArea = true,
    this.minTextScale = 0.8,
    this.maxTextScale = 1.25,
    this.child,
    super.key,
  });

  /// Builder receiving [BuildContext] and [ResponsiveUtils].
  final Widget Function(BuildContext context, ResponsiveUtils responsive)
  builder;

  /// Whether to wrap the result with [SafeArea].
  final bool useSafeArea;

  /// Minimum allowed text scale.
  final double minTextScale;

  /// Maximum allowed text scale.
  final double maxTextScale;

  /// Optional child to pass through to the builder.
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final ResponsiveUtils responsive = ResponsiveUtils.of(context);
        final TextScaler textScaler = MediaQuery.textScalerOf(
          context,
        ).clamp(minScaleFactor: minTextScale, maxScaleFactor: maxTextScale);

        Widget result = MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaler: textScaler),
          child: builder(context, responsive),
        );

        if (useSafeArea) {
          result = SafeArea(child: result);
        }

        return result;
      },
    );
  }
}

/// {@template responsive_orientation_builder}
/// Builds different widgets for portrait and landscape orientations.
/// {@endtemplate}
class ResponsiveOrientationBuilder extends StatelessWidget {
  /// {@macro responsive_orientation_builder}
  const ResponsiveOrientationBuilder({
    required this.portrait,
    this.landscape,
    super.key,
  });

  /// Widget shown in portrait orientation.
  final Widget portrait;

  /// Widget shown in landscape orientation; defaults to [portrait].
  final Widget? landscape;

  @override
  Widget build(BuildContext context) {
    final Orientation orientation = MediaQuery.orientationOf(context);
    return orientation == Orientation.landscape
        ? (landscape ?? portrait)
        : portrait;
  }
}
