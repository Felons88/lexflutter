import 'package:flutter/material.dart';

import '../extensions/build_context_extensions.dart';

/// {@template lex_loading_widget}
/// Centered loading indicator with an optional message.
/// {@endtemplate}
class LexLoadingWidget extends StatelessWidget {
  /// {@macro lex_loading_widget}
  const LexLoadingWidget({
    this.message,
    this.color,
    this.size = 48,
    super.key,
  });

  /// Optional loading message.
  final String? message;

  /// Optional indicator color.
  final Color? color;

  /// Indicator size.
  final double size;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = context.colorScheme;
    final AppSpacing spacing = context.appSpacing;

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            width: size,
            height: size,
            child: CircularProgressIndicator(
              color: color ?? colorScheme.secondary,
              strokeWidth: 3,
            ),
          ),
          if (message != null && message!.isNotEmpty) ...<Widget>[
            SizedBox(height: spacing.md),
            Text(
              message!,
              style: context.textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }
}
