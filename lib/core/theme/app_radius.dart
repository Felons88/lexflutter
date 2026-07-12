import 'dart:ui';

import 'package:flutter/material.dart';

/// {@template app_radius}
/// Corner radius design tokens for the LEX rounded, premium aesthetic.
/// {@endtemplate}
@immutable
class AppRadius extends ThemeExtension<AppRadius> {
  /// {@macro app_radius}
  const AppRadius({
    required this.none,
    required this.xs,
    required this.sm,
    required this.md,
    required this.lg,
    required this.xl,
    required this.xxl,
    required this.full,
  });

  /// Zero radius.
  final double none;

  /// 4dp radius for small chips, tags.
  final double xs;

  /// 8dp radius for small cards and buttons.
  final double sm;

  /// 12dp radius for medium cards.
  final double md;

  /// 16dp radius for large cards and dialogs.
  final double lg;

  /// 24dp radius for bottom sheets and floating panels.
  final double xl;

  /// 32dp radius for large media thumbnails.
  final double xxl;

  /// 1000dp radius for pills, avatars, and fully rounded elements.
  final double full;

  /// Default LEX radius scale.
  static const AppRadius value = AppRadius(
    none: 0,
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32,
    full: 1000,
  );

  BorderRadius get noneRadius => BorderRadius.circular(none);
  BorderRadius get xsRadius => BorderRadius.circular(xs);
  BorderRadius get smRadius => BorderRadius.circular(sm);
  BorderRadius get mdRadius => BorderRadius.circular(md);
  BorderRadius get lgRadius => BorderRadius.circular(lg);
  BorderRadius get xlRadius => BorderRadius.circular(xl);
  BorderRadius get xxlRadius => BorderRadius.circular(xxl);
  BorderRadius get fullRadius => BorderRadius.circular(full);

  Radius get noneCircularRadius => Radius.circular(none);
  Radius get xsCircularRadius => Radius.circular(xs);
  Radius get smCircularRadius => Radius.circular(sm);
  Radius get mdCircularRadius => Radius.circular(md);
  Radius get lgCircularRadius => Radius.circular(lg);
  Radius get xlCircularRadius => Radius.circular(xl);
  Radius get xxlCircularRadius => Radius.circular(xxl);
  Radius get fullCircularRadius => Radius.circular(full);

  @override
  AppRadius copyWith({
    double? none,
    double? xs,
    double? sm,
    double? md,
    double? lg,
    double? xl,
    double? xxl,
    double? full,
  }) =>
      AppRadius(
        none: none ?? this.none,
        xs: xs ?? this.xs,
        sm: sm ?? this.sm,
        md: md ?? this.md,
        lg: lg ?? this.lg,
        xl: xl ?? this.xl,
        xxl: xxl ?? this.xxl,
        full: full ?? this.full,
      );

  @override
  AppRadius lerp(AppRadius? other, double t) {
    if (other == null) return this;
    return AppRadius(
      none: lerpDouble(none, other.none, t) ?? none,
      xs: lerpDouble(xs, other.xs, t) ?? xs,
      sm: lerpDouble(sm, other.sm, t) ?? sm,
      md: lerpDouble(md, other.md, t) ?? md,
      lg: lerpDouble(lg, other.lg, t) ?? lg,
      xl: lerpDouble(xl, other.xl, t) ?? xl,
      xxl: lerpDouble(xxl, other.xxl, t) ?? xxl,
      full: lerpDouble(full, other.full, t) ?? full,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is AppRadius &&
        other.none == none &&
        other.xs == xs &&
        other.sm == sm &&
        other.md == md &&
        other.lg == lg &&
        other.xl == xl &&
        other.xxl == xxl &&
        other.full == full;
  }

  @override
  int get hashCode => Object.hash(
        none,
        xs,
        sm,
        md,
        lg,
        xl,
        xxl,
        full,
      );
}
