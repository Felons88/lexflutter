import 'package:flutter/material.dart';

import '../extensions/build_context_extensions.dart';

/// {@template lex_gradient_button}
/// CTA button with a premium purple/magenta gradient background.
/// {@endtemplate}
class LexGradientButton extends StatelessWidget {
  /// {@macro lex_gradient_button}
  const LexGradientButton({
    required this.onPressed,
    required this.label,
    this.isExpanded = true,
    this.padding,
    this.borderRadius,
    super.key,
  });

  /// Called when the button is tapped.
  final VoidCallback? onPressed;

  /// Button text.
  final String label;

  /// Whether the button expands to the full width.
  final bool isExpanded;

  /// Optional padding.
  final EdgeInsets? padding;

  /// Optional border radius.
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.appColors;
    final AppRadius radius = context.appRadius;
    final AppSpacing spacing = context.appSpacing;
    final AppShadows shadows = context.appShadows;

    final Widget button = DecoratedBox(
      decoration: BoxDecoration(
        gradient: colors.primaryGradient,
        borderRadius: borderRadius ?? radius.fullRadius,
        boxShadow: shadows.glow,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: borderRadius ?? radius.fullRadius,
          child: Container(
            padding: padding ??
                EdgeInsets.symmetric(
                  horizontal: spacing.xl,
                  vertical: spacing.md,
                ),
            alignment: Alignment.center,
            child: Text(
              label,
              style: context.textTheme.labelLarge?.copyWith(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );

    return isExpanded ? SizedBox(width: double.infinity, child: button) : button;
  }
}
