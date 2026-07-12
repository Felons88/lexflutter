import 'package:flutter/material.dart';

export 'app_curves.dart';
export 'app_durations.dart';

/// {@template app_animations}
/// Centralized animation constants for the LEX motion system.
///
/// Re-exports [AppDurations] and [AppCurves] and adds spring constants
/// for hero and shared element transitions.
/// {@endtemplate}
abstract final class AppAnimations {
  const AppAnimations._();

  /// Standard spring description for bouncy UI elements.
  static const SpringDescription springDefault = SpringDescription(
    mass: 1,
    stiffness: 380,
    damping: 25,
  );

  /// Soft spring description for large elements (sheets, pages).
  static const SpringDescription springSoft = SpringDescription(
    mass: 1,
    stiffness: 200,
    damping: 25,
  );

  /// Snappy spring description for small elements (chips, icons).
  static const SpringDescription springSnappy = SpringDescription(
    mass: 1,
    stiffness: 700,
    damping: 35,
  );

  /// Slow fade duration for page transitions.
  static const Duration pageFadeDuration = Duration(milliseconds: 400);

  /// Page slide duration.
  static const Duration pageSlideDuration = Duration(milliseconds: 300);

  /// Scale duration for shared element hero transitions.
  static const Duration heroScaleDuration = Duration(milliseconds: 350);
}
