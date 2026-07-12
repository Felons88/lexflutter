import 'package:flutter/material.dart';

import '../extensions/build_context_extensions.dart';

/// {@template lex_loading_button}
/// Primary button that shows a loading indicator when [isLoading] is true.
/// {@endtemplate}
class LexLoadingButton extends StatelessWidget {
  /// {@macro lex_loading_button}
  const LexLoadingButton({
    required this.onPressed,
    required this.label,
    this.isLoading = false,
    this.isExpanded = true,
    super.key,
  });

  /// Called when the button is tapped.
  final VoidCallback? onPressed;

  /// Button text.
  final String label;

  /// Whether the button is currently in a loading state.
  final bool isLoading;

  /// Whether the button expands to the full width.
  final bool isExpanded;

  @override
  Widget build(BuildContext context) {
    final Widget content = AnimatedSwitcher(
      duration: context.appDurations.fast,
      child: isLoading
          ? SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: context.colorScheme.onPrimary,
              ),
            )
          : Text(label),
    );

    final Widget button = ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        textStyle: context.textTheme.labelLarge,
      ),
      child: content,
    );

    return isExpanded ? SizedBox(width: double.infinity, child: button) : button;
  }
}
