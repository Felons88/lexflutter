import 'package:flutter/material.dart';

import '../../core/theme/app_animations.dart';

/// {@template lex_fade_transition}
/// Fade transition wrapper using the LEX animation timing.
/// {@endtemplate}
class LexFadeTransition extends StatelessWidget {
  /// {@macro lex_fade_transition}
  const LexFadeTransition({
    required this.child,
    this.duration = AppAnimations.pageFadeDuration,
    this.curve = AppCurves.defaultCurve,
    super.key,
  });

  /// Child widget to animate.
  final Widget child;

  /// Animation duration.
  final Duration duration;

  /// Animation curve.
  final Curve curve;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: duration,
      switchInCurve: curve,
      switchOutCurve: curve,
      transitionBuilder: (Widget child, Animation<double> animation) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
      child: child,
    );
  }
}
