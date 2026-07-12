import 'dart:ui';

import 'package:flutter/material.dart';

import '../../core/extensions/build_context_extensions.dart';
import '../../core/theme/app_animations.dart';

/// {@template lex_glass_transition}
/// Glass transition that fades and scales a glassmorphism container.
/// {@endtemplate}
class LexGlassTransition extends StatelessWidget {
  /// {@macro lex_glass_transition}
  const LexGlassTransition({
    required this.child,
    this.duration = AppAnimations.pageFadeDuration,
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
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: CurvedAnimation(parent: animation, curve: curve),
            child: ClipRRect(
              borderRadius: context.appRadius.lgRadius,
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                child: child,
              ),
            ),
          ),
        );
      },
      child: child,
    );
  }
}
