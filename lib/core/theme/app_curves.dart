import 'package:flutter/material.dart';

/// {@template app_curves}
/// Centralized easing curves for the LEX motion language.
///
/// Curves are not theme-dependent; they are static constants used by the
/// animation system and widgets.
/// {@endtemplate}
abstract final class AppCurves {
  /// Default transition easing.
  static const Curve defaultCurve = Curves.easeInOut;

  /// Enter animations - decelerate for an elegant arrival.
  static const Curve enter = Curves.decelerate;

  /// Exit animations - accelerate for a snappy dismissal.
  static const Curve exit = Curves.easeIn;

  /// Emphasized motion for hero and shared elements.
  static const Curve emphasized = Curves.easeInOutCubicEmphasized;

  /// Bounce effect for playful micro-interactions.
  static const Curve bounce = Curves.elasticOut;

  /// Spring-like curve for sheet transitions.
  static const Curve spring = Curves.fastOutSlowIn;

  /// Linear timing for shimmer and progress indicators.
  static const Curve linear = Curves.linear;

  const AppCurves._();
}
