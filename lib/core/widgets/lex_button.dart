import 'package:flutter/material.dart';

import '../extensions/build_context_extensions.dart';

/// {@template lex_primary_button}
/// Primary CTA button with the LEX premium style.
/// {@endtemplate}
class LexPrimaryButton extends StatelessWidget {
  /// {@macro lex_primary_button}
  const LexPrimaryButton({
    required this.onPressed,
    required this.label,
    this.icon,
    this.isExpanded = true,
    this.padding,
    super.key,
  });

  /// Called when the button is tapped.
  final VoidCallback? onPressed;

  /// Button text.
  final String label;

  /// Optional leading icon.
  final Widget? icon;

  /// Whether the button expands to the full width.
  final bool isExpanded;

  /// Optional padding override.
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    final Widget content = Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        if (icon != null) ...<Widget>[
          icon!,
          SizedBox(width: context.appSpacing.sm),
        ],
        Text(label),
      ],
    );

    final Widget button = ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: padding,
        textStyle: context.textTheme.labelLarge,
      ),
      child: content,
    );

    return isExpanded ? SizedBox(width: double.infinity, child: button) : button;
  }
}

/// {@template lex_secondary_button}
/// Secondary button with a subtle surface style.
/// {@endtemplate}
class LexSecondaryButton extends StatelessWidget {
  /// {@macro lex_secondary_button}
  const LexSecondaryButton({
    required this.onPressed,
    required this.label,
    this.icon,
    this.isExpanded = true,
    this.padding,
    super.key,
  });

  /// Called when the button is tapped.
  final VoidCallback? onPressed;

  /// Button text.
  final String label;

  /// Optional leading icon.
  final Widget? icon;

  /// Whether the button expands to the full width.
  final bool isExpanded;

  /// Optional padding override.
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    final Widget content = Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        if (icon != null) ...<Widget>[
          icon!,
          SizedBox(width: context.appSpacing.sm),
        ],
        Text(label),
      ],
    );

    final Widget button = OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        padding: padding,
        textStyle: context.textTheme.labelLarge,
      ),
      child: content,
    );

    return isExpanded ? SizedBox(width: double.infinity, child: button) : button;
  }
}
