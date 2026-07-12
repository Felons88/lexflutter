import 'dart:ui';

import 'package:flutter/material.dart';

import '../extensions/build_context_extensions.dart';

/// {@template lex_glass_card}
/// Glassmorphism card with backdrop blur and translucent border.
/// {@endtemplate}
class LexGlassCard extends StatelessWidget {
  /// {@macro lex_glass_card}
  const LexGlassCard({
    required this.child,
    this.onTap,
    this.margin,
    this.padding,
    this.borderRadius,
    this.blurSigma = 12,
    super.key,
  });

  /// Card content.
  final Widget child;

  /// Optional tap handler.
  final VoidCallback? onTap;

  /// Optional margin.
  final EdgeInsets? margin;

  /// Optional padding.
  final EdgeInsets? padding;

  /// Optional border radius override.
  final BorderRadius? borderRadius;

  /// Backdrop blur sigma.
  final double blurSigma;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.appColors;
    final AppRadius radius = context.appRadius;

    final Widget card = ClipRRect(
      borderRadius: borderRadius ?? radius.lgRadius,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
        child: Container(
          margin: margin,
          padding: padding,
          decoration: BoxDecoration(
            color: colors.glassBackground,
            borderRadius: borderRadius ?? radius.lgRadius,
            border: Border.all(color: colors.glassBorder),
          ),
          child: child,
        ),
      ),
    );

    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        borderRadius: borderRadius ?? radius.lgRadius,
        child: card,
      );
    }

    return card;
  }
}
