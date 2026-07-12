import 'dart:ui';

import 'package:flutter/material.dart';

/// {@template app_spacing}
/// Spacing design tokens and helper insets for the LEX interface.
///
/// All spacing values are multiples of a 4dp grid.  Use the extension
/// values directly or convert them to [EdgeInsets] with the helpers.
/// {@endtemplate}
@immutable
class AppSpacing extends ThemeExtension<AppSpacing> {
  /// {@macro app_spacing}
  const AppSpacing({
    required this.none,
    required this.xxs,
    required this.xs,
    required this.sm,
    required this.md,
    required this.lg,
    required this.xl,
    required this.xxl,
    required this.xxxl,
    required this.huge,
  });

  /// Zero spacing.
  final double none;

  /// 2dp micro spacing.
  final double xxs;

  /// 4dp extra-small spacing.
  final double xs;

  /// 8dp small spacing.
  final double sm;

  /// 12dp medium spacing.
  final double md;

  /// 16dp large spacing.
  final double lg;

  /// 24dp extra-large spacing.
  final double xl;

  /// 32dp double extra-large spacing.
  final double xxl;

  /// 48dp triple extra-large spacing.
  final double xxxl;

  /// 64dp huge spacing.
  final double huge;

  /// Default LEX spacing scale.
  static const AppSpacing value = AppSpacing(
    none: 0,
    xxs: 2,
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32,
    xxxl: 48,
    huge: 64,
  );

  EdgeInsets get allNone => EdgeInsets.all(none);
  EdgeInsets get allXxs => EdgeInsets.all(xxs);
  EdgeInsets get allXs => EdgeInsets.all(xs);
  EdgeInsets get allSm => EdgeInsets.all(sm);
  EdgeInsets get allMd => EdgeInsets.all(md);
  EdgeInsets get allLg => EdgeInsets.all(lg);
  EdgeInsets get allXl => EdgeInsets.all(xl);
  EdgeInsets get allXxl => EdgeInsets.all(xxl);

  EdgeInsets get horizontalXs => EdgeInsets.symmetric(horizontal: xs);
  EdgeInsets get horizontalSm => EdgeInsets.symmetric(horizontal: sm);
  EdgeInsets get horizontalMd => EdgeInsets.symmetric(horizontal: md);
  EdgeInsets get horizontalLg => EdgeInsets.symmetric(horizontal: lg);
  EdgeInsets get horizontalXl => EdgeInsets.symmetric(horizontal: xl);

  EdgeInsets get verticalXs => EdgeInsets.symmetric(vertical: xs);
  EdgeInsets get verticalSm => EdgeInsets.symmetric(vertical: sm);
  EdgeInsets get verticalMd => EdgeInsets.symmetric(vertical: md);
  EdgeInsets get verticalLg => EdgeInsets.symmetric(vertical: lg);
  EdgeInsets get verticalXl => EdgeInsets.symmetric(vertical: xl);

  @override
  AppSpacing copyWith({
    double? none,
    double? xxs,
    double? xs,
    double? sm,
    double? md,
    double? lg,
    double? xl,
    double? xxl,
    double? xxxl,
    double? huge,
  }) =>
      AppSpacing(
        none: none ?? this.none,
        xxs: xxs ?? this.xxs,
        xs: xs ?? this.xs,
        sm: sm ?? this.sm,
        md: md ?? this.md,
        lg: lg ?? this.lg,
        xl: xl ?? this.xl,
        xxl: xxl ?? this.xxl,
        xxxl: xxxl ?? this.xxxl,
        huge: huge ?? this.huge,
      );

  @override
  AppSpacing lerp(AppSpacing? other, double t) {
    if (other == null) return this;
    return AppSpacing(
      none: lerpDouble(none, other.none, t) ?? none,
      xxs: lerpDouble(xxs, other.xxs, t) ?? xxs,
      xs: lerpDouble(xs, other.xs, t) ?? xs,
      sm: lerpDouble(sm, other.sm, t) ?? sm,
      md: lerpDouble(md, other.md, t) ?? md,
      lg: lerpDouble(lg, other.lg, t) ?? lg,
      xl: lerpDouble(xl, other.xl, t) ?? xl,
      xxl: lerpDouble(xxl, other.xxl, t) ?? xxl,
      xxxl: lerpDouble(xxxl, other.xxxl, t) ?? xxxl,
      huge: lerpDouble(huge, other.huge, t) ?? huge,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is AppSpacing &&
        other.none == none &&
        other.xxs == xxs &&
        other.xs == xs &&
        other.sm == sm &&
        other.md == md &&
        other.lg == lg &&
        other.xl == xl &&
        other.xxl == xxl &&
        other.xxxl == xxxl &&
        other.huge == huge;
  }

  @override
  int get hashCode => Object.hash(
        none,
        xxs,
        xs,
        sm,
        md,
        lg,
        xl,
        xxl,
        xxxl,
        huge,
      );
}
