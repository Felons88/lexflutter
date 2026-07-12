import 'package:flutter/material.dart';

import '../extensions/build_context_extensions.dart';

/// {@template lex_app_bar}
/// Consistent app bar with optional gradient title and glass effect.
/// {@endtemplate}
class LexAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// {@macro lex_app_bar}
  const LexAppBar({
    this.title,
    this.centerTitle = true,
    this.leading,
    this.actions,
    this.isGlass = false,
    this.elevation = 0,
    super.key,
  });

  /// Optional title widget.
  final Widget? title;

  /// Whether to center the title.
  final bool centerTitle;

  /// Optional leading widget.
  final Widget? leading;

  /// Optional action widgets.
  final List<Widget>? actions;

  /// Whether to use a glassmorphism background.
  final bool isGlass;

  /// App bar elevation.
  final double elevation;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = context.colorScheme;
    final AppColors colors = context.appColors;

    return AppBar(
      backgroundColor: isGlass ? colors.glassBackground : colorScheme.surface,
      foregroundColor: colorScheme.onSurface,
      elevation: elevation,
      centerTitle: centerTitle,
      title: title,
      leading: leading,
      actions: actions,
      flexibleSpace: isGlass
          ? Container(
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: colors.glassBorder)),
              ),
            )
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
