import 'package:flutter/material.dart';

import '../extensions/build_context_extensions.dart';

/// {@template lex_search_bar}
/// Search input with clear button and premium styling.
/// {@endtemplate}
class LexSearchBar extends StatelessWidget {
  /// {@macro lex_search_bar}
  const LexSearchBar({
    this.controller,
    this.hintText = 'Search',
    this.onChanged,
    this.onSubmitted,
    this.onClear,
    this.autofocus = false,
    super.key,
  });

  /// Text editing controller.
  final TextEditingController? controller;

  /// Hint text.
  final String hintText;

  /// Called when the query changes.
  final ValueChanged<String>? onChanged;

  /// Called when the user submits the query.
  final ValueChanged<String>? onSubmitted;

  /// Called when the clear button is tapped.
  final VoidCallback? onClear;

  /// Whether the search bar should autofocus.
  final bool autofocus;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = context.colorScheme;
    final AppColors colors = context.appColors;
    final AppRadius radius = context.appRadius;

    return TextField(
      controller: controller,
      autofocus: autofocus,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Icon(Icons.search, color: colorScheme.onSurfaceVariant),
        suffixIcon: ValueListenableBuilder<TextEditingValue>(
          valueListenable: controller ?? TextEditingController(),
          builder:
              (BuildContext context, TextEditingValue value, Widget? child) {
                if (value.text.isEmpty) return const SizedBox.shrink();
                return IconButton(
                  icon: Icon(Icons.clear, color: colorScheme.onSurfaceVariant),
                  onPressed: () {
                    controller?.clear();
                    onClear?.call();
                    onChanged?.call('');
                  },
                );
              },
        ),
        filled: true,
        fillColor: colorScheme.surfaceContainerHighest,
        border: OutlineInputBorder(
          borderRadius: radius.fullRadius,
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: radius.fullRadius,
          borderSide: BorderSide(color: colors.glassBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: radius.fullRadius,
          borderSide: BorderSide(color: colorScheme.primary, width: 1.5),
        ),
        contentPadding: EdgeInsets.zero,
      ),
    );
  }
}
