import 'package:flutter/material.dart';

import '../extensions/build_context_extensions.dart';

/// {@template lex_error_widget}
/// Reusable error state with icon and message.
/// {@endtemplate}
class LexErrorWidget extends StatelessWidget {
  /// {@macro lex_error_widget}
  const LexErrorWidget({
    this.message = 'Something went wrong',
    this.icon = Icons.error_outline,
    this.onRetry,
    this.compact = false,
    super.key,
  });

  /// Error message to display.
  final String message;

  /// Icon displayed above the message.
  final IconData icon;

  /// Optional retry callback.
  final VoidCallback? onRetry;

  /// Whether to render a compact variant (smaller padding and text).
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = context.colorScheme;
    final AppSpacing spacing = context.appSpacing;

    return Padding(
      padding: EdgeInsets.all(compact ? spacing.sm : spacing.lg),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            icon,
            size: compact ? 24 : 48,
            color: colorScheme.onSurfaceVariant,
          ),
          SizedBox(height: compact ? spacing.xs : spacing.md),
          Text(
            message,
            textAlign: TextAlign.center,
            style: compact
                ? context.textTheme.bodySmall
                : context.textTheme.bodyLarge,
          ),
          if (onRetry != null) ...<Widget>[
            SizedBox(height: spacing.md),
            TextButton(
              onPressed: onRetry,
              child: const Text('Retry'),
            ),
          ],
        ],
      ),
    );
  }
}
