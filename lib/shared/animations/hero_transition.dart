import 'package:flutter/material.dart';

/// {@template lex_hero_transition}
/// Thin wrapper around Flutter [Hero] with LEX animation defaults.
/// {@endtemplate}
class LexHeroTransition extends StatelessWidget {
  /// {@macro lex_hero_transition}
  const LexHeroTransition({
    required this.tag,
    required this.child,
    this.flightShuttleBuilder,
    this.createRectTween,
    this.placeholderBuilder,
    this.transitionOnUserGestures = false,
    super.key,
  });

  /// Hero tag for the shared element.
  final Object tag;

  /// Child widget to transition.
  final Widget child;

  /// Optional flight shuttle builder.
  final HeroFlightShuttleBuilder? flightShuttleBuilder;

  /// Optional rect tween.
  final CreateRectTween? createRectTween;

  /// Optional placeholder builder.
  final HeroPlaceholderBuilder? placeholderBuilder;

  /// Whether to transition on user gestures.
  final bool transitionOnUserGestures;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: tag,
      flightShuttleBuilder: flightShuttleBuilder,
      createRectTween: createRectTween,
      placeholderBuilder: placeholderBuilder,
      transitionOnUserGestures: transitionOnUserGestures,
      child: child,
    );
  }
}
