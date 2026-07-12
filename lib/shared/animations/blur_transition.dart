import 'dart:ui';

import 'package:flutter/material.dart';

import '../../core/theme/app_animations.dart';

/// {@template lex_blur_transition}
/// Blur transition wrapper using the LEX animation timing.
///
/// Animates a blur filter in and out when the child changes.
/// {@endtemplate}
class LexBlurTransition extends StatelessWidget {
  /// {@macro lex_blur_transition}
  const LexBlurTransition({
    required this.child,
    this.duration = AppAnimations.pageFadeDuration,
    this.curve = AppCurves.defaultCurve,
    this.maxBlur = 12,
    super.key,
  });

  /// Child widget to animate.
  final Widget child;

  /// Animation duration.
  final Duration duration;

  /// Animation curve.
  final Curve curve;

  /// Maximum blur sigma.
  final double maxBlur;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: duration,
      switchInCurve: curve,
      switchOutCurve: curve,
      transitionBuilder: (Widget child, Animation<double> animation) {
        return AnimatedBuilder(
          animation: animation,
          builder: (BuildContext context, Widget? child) {
            final double value = (1 - animation.value) * maxBlur;
            final double sigma = value.clamp(0, maxBlur);
            return ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: sigma, sigmaY: sigma),
              child: child,
            );
          },
          child: child,
        );
      },
      child: child,
    );
  }
}
