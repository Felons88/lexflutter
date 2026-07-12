import 'package:flutter/material.dart';

import '../extensions/build_context_extensions.dart';
import 'lex_network_image.dart';

/// {@template lex_avatar}
/// Circular avatar with network image or fallback initials.
/// {@endtemplate}
class LexAvatar extends StatelessWidget {
  /// {@macro lex_avatar}
  const LexAvatar({
    this.imageUrl,
    this.name,
    this.size = 48,
    this.borderColor,
    this.borderWidth = 0,
    super.key,
  });

  /// Optional avatar image URL.
  final String? imageUrl;

  /// User display name for fallback initials.
  final String? name;

  /// Avatar diameter.
  final double size;

  /// Optional border color.
  final Color? borderColor;

  /// Border width.
  final double borderWidth;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = context.colorScheme;
    final Color bg = colorScheme.primary;
    final Color fg = colorScheme.onPrimary;

    final Widget fallback = Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: bg,
        shape: BoxShape.circle,
        border: borderColor != null
            ? Border.all(color: borderColor!, width: borderWidth)
            : null,
      ),
      child: Center(
        child: Text(
          _initials,
          style: context.textTheme.titleMedium?.copyWith(
            color: fg,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );

    if (imageUrl == null || imageUrl!.isEmpty) {
      return fallback;
    }

    return SizedBox(
      width: size,
      height: size,
      child: ClipOval(
        child: LexNetworkImage(
          imageUrl: imageUrl!,
          width: size,
          height: size,
          errorWidget: fallback,
        ),
      ),
    );
  }

  String get _initials {
    if (name == null || name!.trim().isEmpty) return '?';
    final List<String> parts = name!
        .trim()
        .split(' ')
        .where((String part) => part.isNotEmpty)
        .toList();
    if (parts.isEmpty) return '?';
    final String first = parts.first[0].toUpperCase();
    final String last = parts.length > 1 ? parts.last[0].toUpperCase() : '';
    return '$first$last';
  }
}
