import 'package:flutter/material.dart';

import '../extensions/build_context_extensions.dart';

/// {@template lex_shimmer_placeholder}
/// Shimmer placeholder with the LEX gradient palette.
///
/// Animates a moving highlight over the placeholder to indicate loading state.
/// {@endtemplate}
class LexShimmerPlaceholder extends StatefulWidget {
  /// {@macro lex_shimmer_placeholder}
  const LexShimmerPlaceholder({
    this.width = double.infinity,
    this.height = 16,
    this.borderRadius,
    this.baseColor,
    this.highlightColor,
    super.key,
  });

  /// Width of the placeholder.
  final double width;

  /// Height of the placeholder.
  final double height;

  /// Border radius of the placeholder.
  final BorderRadius? borderRadius;

  /// Optional base color override.
  final Color? baseColor;

  /// Optional highlight color override.
  final Color? highlightColor;

  @override
  State<LexShimmerPlaceholder> createState() => _LexShimmerPlaceholderState();
}

class _LexShimmerPlaceholderState extends State<LexShimmerPlaceholder>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();
    _animation = Tween<double>(begin: -2, end: 2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutSine),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.appColors;
    final AppRadius radius = context.appRadius;
    final Color base = widget.baseColor ?? colors.shimmerBase;
    final Color highlight = widget.highlightColor ?? colors.shimmerHighlight;

    return AnimatedBuilder(
      animation: _animation,
      builder: (BuildContext context, Widget? child) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: widget.borderRadius ?? radius.mdRadius,
            gradient: LinearGradient(
              begin: Alignment(_animation.value, 0),
              end: Alignment(_animation.value + 1, 0),
              colors: <Color>[base, highlight, base],
              stops: const <double>[0.0, 0.5, 1.0],
            ),
          ),
        );
      },
    );
  }
}
