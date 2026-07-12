import 'package:flutter/material.dart';

import '../../core/theme/app_animations.dart';

/// {@template lex_shared_axis_transition}
/// Shared axis transition combining fade, scale, and slide for sibling
/// elements.
/// {@endtemplate}
class LexSharedAxisTransition extends StatelessWidget {
  /// {@macro lex_shared_axis_transition}
  const LexSharedAxisTransition({
    required this.child,
    this.duration = AppAnimations.pageSlideDuration,
    this.curve = AppCurves.emphasized,
    this.begin = const Offset(0, 0.05),
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
        final Animation<Offset> offsetAnimation = Tween<Offset>(
          begin: begin,
          end: Offset.zero,
        ).animate(
          CurvedAnimation(parent: animation, curve: curve),
        );

        return SlideTransition(
          position: offsetAnimation,
          child: FadeTransition(
            opacity: animation,
            child: ScaleTransition(
              scale: Tween<double>(begin: 0.95, end: 1.0).animate(
                CurvedAnimation(parent: animation, curve: curve),
              ),
              child: child,
            ),
          ),
        );
      },
      child: child,
    );
  }
}
