import 'package:flutter/material.dart';

import '../extensions/build_context_extensions.dart';

/// {@template lex_empty_state}
/// Empty state placeholder with icon, title, subtitle, and optional action.
/// {@endtemplate}
class LexEmptyState extends StatelessWidget {
  /// {@macro lex_empty_state}
  const LexEmptyState({
    this.icon,
    this.title,
    this.subtitle,
    this.action,
    super.key,
  });

  /// Optional leading icon.
  final IconData? icon;

  /// Optional title.
  final String? title;

  /// Optional subtitle.
  final String? subtitle;

  /// Optional action button.
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = context.colorScheme;
    final AppSpacing spacing = context.appSpacing;

    return Padding(
      padding: spacing.allLg,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          if (icon != null)
            Icon(
              icon,
              size: 64,
              color: colorScheme.onSurfaceVariant,
            ),
          if (icon != null) SizedBox(height: spacing.md),
          if (title != null)
            Text(
              title!,
              style: context.textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
          if (subtitle != null) ...<Widget>[
            SizedBox(height: spacing.sm),
            Text(
              subtitle!,
              style: context.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
          ],
          if (action != null) ...<Widget>[
            SizedBox(height: spacing.lg),
            action!,
          ],
        ],
      ),
    );
  }
}
