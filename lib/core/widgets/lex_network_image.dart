import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'lex_error_widget.dart';
import 'lex_shimmer_placeholder.dart';

/// {@template lex_network_image}
/// Network image widget with placeholder, error, and premium fit handling.
/// {@endtemplate}
class LexNetworkImage extends StatelessWidget {
  /// {@macro lex_network_image}
  const LexNetworkImage({
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.placeholder,
    this.errorWidget,
    super.key,
  });

  /// The image URL.
  final String imageUrl;

  /// Optional width.
  final double? width;

  /// Optional height.
  final double? height;

  /// Image fit mode.
  final BoxFit fit;

  /// Optional border radius.
  final BorderRadius? borderRadius;

  /// Optional placeholder widget.
  final Widget? placeholder;

  /// Optional error widget.
  final Widget? errorWidget;

  @override
  Widget build(BuildContext context) {
    final Widget image = CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: fit,
      placeholder: (BuildContext context, String url) =>
          placeholder ?? const LexShimmerPlaceholder(height: double.infinity),
      errorWidget: (BuildContext context, String url, Object error) =>
          errorWidget ??
          const LexErrorWidget(message: 'Could not load image', compact: true),
    );

    if (borderRadius != null) {
      return ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.zero,
        child: image,
      );
    }

    return image;
  }
}
