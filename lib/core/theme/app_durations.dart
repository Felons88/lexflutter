import 'dart:ui';

import 'package:flutter/material.dart';

/// {@template app_durations}
/// Centralized animation duration design tokens.
///
/// Every duration is exposed as a [Duration] so widgets can share timing and
/// keep the interface feeling cohesive.
/// {@endtemplate}
@immutable
class AppDurations extends ThemeExtension<AppDurations> {
  /// {@macro app_durations}
  const AppDurations({
    required this.instant,
    required this.fast,
    required this.normal,
    required this.slow,
    required this.slower,
  });

  /// Instant / micro interactions (0ms).
  final Duration instant;

  /// Fast feedback (150ms).
  final Duration fast;

  /// Standard transitions (250ms).
  final Duration normal;

  /// Slow, premium transitions (400ms).
  final Duration slow;

  /// Slower / page-level transitions (600ms).
  final Duration slower;

  /// Default LEX durations.
  static const AppDurations value = AppDurations(
    instant: Duration.zero,
    fast: Duration(milliseconds: 150),
    normal: Duration(milliseconds: 250),
    slow: Duration(milliseconds: 400),
    slower: Duration(milliseconds: 600),
  );

  @override
  AppDurations copyWith({
    Duration? instant,
    Duration? fast,
    Duration? normal,
    Duration? slow,
    Duration? slower,
  }) =>
      AppDurations(
        instant: instant ?? this.instant,
        fast: fast ?? this.fast,
        normal: normal ?? this.normal,
        slow: slow ?? this.slow,
        slower: slower ?? this.slower,
      );

  @override
  AppDurations lerp(AppDurations? other, double t) {
    if (other == null) return this;
    return AppDurations(
      instant: _lerpDuration(instant, other.instant, t),
      fast: _lerpDuration(fast, other.fast, t),
      normal: _lerpDuration(normal, other.normal, t),
      slow: _lerpDuration(slow, other.slow, t),
      slower: _lerpDuration(slower, other.slower, t),
    );
  }

  Duration _lerpDuration(Duration a, Duration b, double t) {
    final double aMicros = a.inMicroseconds.toDouble();
    final double bMicros = b.inMicroseconds.toDouble();
    final double lerped = lerpDouble(aMicros, bMicros, t) ?? aMicros;
    return Duration(microseconds: lerped.toInt());
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is AppDurations &&
        other.instant == instant &&
        other.fast == fast &&
        other.normal == normal &&
        other.slow == slow &&
        other.slower == slower;
  }

  @override
  int get hashCode => Object.hash(
        instant,
        fast,
        normal,
        slow,
        slower,
      );
}
