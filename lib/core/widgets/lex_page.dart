import 'package:flutter/material.dart';

import '../extensions/build_context_extensions.dart';

/// {@template lex_page}
/// A reusable page shell with consistent styling and safe area handling.
///
/// Feature screens will compose this widget with their own body content.
/// {@endtemplate}
class LexPage extends StatelessWidget {
  /// {@macro lex_page}
  const LexPage({
    this.body,
    this.appBar,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.backgroundColor,
    this.extendBody = false,
    this.extendBodyBehindAppBar = false,
    super.key,
  });

  /// The primary content of the page.
  final Widget? body;

  /// Optional app bar.
  final PreferredSizeWidget? appBar;

  /// Optional bottom navigation bar.
  final Widget? bottomNavigationBar;

  /// Optional floating action button.
  final Widget? floatingActionButton;

  /// Optional background color; defaults to theme scaffold background.
  final Color? backgroundColor;

  /// Whether the body extends behind the bottom navigation bar.
  final bool extendBody;

  /// Whether the body extends behind the app bar.
  final bool extendBodyBehindAppBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? context.colorScheme.surface,
      appBar: appBar,
      body: body,
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButton,
      extendBody: extendBody,
      extendBodyBehindAppBar: extendBodyBehindAppBar,
    );
  }
}
