import 'package:flutter/material.dart';

import '../extensions/build_context_extensions.dart';

/// {@template lex_icon_button}
/// Circular icon button with optional glass or gradient background.
/// {@endtemplate}
class LexIconButton extends StatelessWidget {
  /// {@macro lex_icon_button}
  const LexIconButton({
    required this.icon,
    required this.onPressed,
    this.backgroundColor,
    this.foregroundColor,
    this.size = 48,
    this.isGlass = false,
    super.key,
  });

  /// The icon to display.
  final Widget icon;

  /// Called when the button is tapped.
  final VoidCallback? onPressed;

  /// Optional background color override.
  final Color? backgroundColor;

  /// Optional foreground color override.
  final Color? foregroundColor;

  /// Button diameter.
  final double size;

  /// Whether to use a glassmorphism background.
  final bool isGlass;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = context.colorScheme;
    final AppColors colors = context.appColors;
    final AppRadius radius = context.appRadius;

    final Color bg =
        backgroundColor ??
        (isGlass
            ? colors.glassBackground
            : colorScheme.surfaceContainerHighest);
    final Color fg = foregroundColor ?? colorScheme.onSurface;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: radius.fullRadius,
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: bg,
            borderRadius: radius.fullRadius,
            border: isGlass ? Border.all(color: colors.glassBorder) : null,
          ),
          child: IconTheme(
            data: IconThemeData(color: fg, size: size * 0.5),
            child: icon,
          ),
        ),
      ),
    );
  }
}
