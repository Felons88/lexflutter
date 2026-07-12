import 'package:flutter/material.dart';

import '../extensions/build_context_extensions.dart';
import 'lex_shimmer_placeholder.dart';

/// {@template lex_skeleton_loader}
/// A list-friendly skeleton loader composed of shimmer placeholders.
/// {@endtemplate}
class LexSkeletonLoader extends StatelessWidget {
  /// {@macro lex_skeleton_loader}
  const LexSkeletonLoader({
    this.itemCount = 6,
    this.itemHeight = 80,
    this.padding,
    super.key,
  });

  /// Number of placeholder items.
  final int itemCount;

  /// Height of each placeholder item.
  final double itemHeight;

  /// Optional padding around the list.
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    final AppSpacing spacing = context.appSpacing;

    return ListView.separated(
      padding: padding ?? spacing.horizontalLg + spacing.verticalMd,
      itemCount: itemCount,
      separatorBuilder: (BuildContext context, int index) =>
          SizedBox(height: spacing.md),
      itemBuilder: (BuildContext context, int index) {
        return LexShimmerPlaceholder(
          height: itemHeight,
          borderRadius: context.appRadius.lgRadius,
        );
      },
    );
  }
}
