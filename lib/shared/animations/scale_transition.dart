import 'package:flutter/material.dart';

import '../../core/theme/app_animations.dart';

/// {@template lex_scale_transition}
/// Scale transition wrapper using the LEX animation timing.
/// {@endtemplate}
class LexScaleTransition extends StatelessWidget {
  /// {@macro lex_scale_transition}
  const LexScaleTransition({
    required this.child,
    this.duration = AppAnimations.heroScaleDuration,
    this.curve = AppCurves.emphasized,
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
        return ScaleTransition(
          scale: CurvedAnimation(parent: animation, curve: curve),
          child: FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}
