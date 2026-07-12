import 'package:flutter/material.dart';

import '../../core/theme/app_animations.dart';

/// {@template lex_slide_transition}
/// Slide transition wrapper using the LEX animation timing.
/// {@endtemplate}
class LexSlideTransition extends StatelessWidget {
  /// {@macro lex_slide_transition}
  const LexSlideTransition({
    required this.child,
    this.duration = AppAnimations.pageSlideDuration,
    this.curve = AppCurves.enter,
    this.begin = const Offset(0, 0.1),
    super.key,
  });

  /// Child widget to animate.
  final Widget child;

  /// Animation duration.
  final Duration duration;

  /// Animation curve.
  final Curve curve;

  /// Slide start offset.
  final Offset begin;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: duration,
      switchInCurve: curve,
      switchOutCurve: curve,
      transitionBuilder: (Widget child, Animation<double> animation) {
        return SlideTransition(
          position: Tween<Offset>(begin: begin, end: Offset.zero).animate(
            CurvedAnimation(parent: animation, curve: curve),
          ),
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
