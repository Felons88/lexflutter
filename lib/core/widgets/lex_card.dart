import 'package:flutter/material.dart';

import '../extensions/build_context_extensions.dart';

/// {@template lex_card}
/// Primary card surface with consistent LEX rounding and subtle shadow.
/// {@endtemplate}
class LexCard extends StatelessWidget {
  /// {@macro lex_card}
  const LexCard({
    required this.child,
    this.onTap,
    this.margin,
    this.padding,
    this.elevation,
    this.borderRadius,
    this.borderColor,
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

  /// Optional elevation override.
  final double? elevation;

  /// Optional border radius override.
  final BorderRadius? borderRadius;

  /// Optional border color override.
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.appColors;
    final AppRadius radius = context.appRadius;
    final AppShadows shadows = context.appShadows;

    final Widget card = Container(
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: borderRadius ?? radius.lgRadius,
        border: Border.all(color: borderColor ?? colors.glassBorder),
        boxShadow: elevation != null && elevation! > 0
            ? shadows.sm
            : shadows.none,
      ),
      child: child,
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
