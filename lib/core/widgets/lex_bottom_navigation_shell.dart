import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../extensions/build_context_extensions.dart';

/// {@template lex_bottom_navigation_shell}
/// TikTok-style bottom navigation shell used for the main app tabs.
///
/// Displays a [NavigationBar] with an animated indicator and keeps the tab
/// state alive via the nested [StatefulNavigationShell].
/// {@endtemplate}
class LexBottomNavigationShell extends StatelessWidget {
  /// {@macro lex_bottom_navigation_shell}
  const LexBottomNavigationShell({required this.navigationShell, super.key});

  /// The navigation shell provided by [StatefulShellRoute.indexedStack].
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = context.colorScheme;
    final AppColors appColors = context.appColors;

    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: DecoratedBox(
        decoration: BoxDecoration(
          color: colorScheme.surface.withAlpha(230),
          border: Border(top: BorderSide(color: appColors.glassBorder)),
        ),
        child: SafeArea(
          child: NavigationBar(
            selectedIndex: navigationShell.currentIndex,
            onDestinationSelected: navigationShell.goBranch,
            backgroundColor: Colors.transparent,
            elevation: 0,
            indicatorColor: colorScheme.primary.withAlpha(40),
            destinations: const <Widget>[
              NavigationDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home),
                label: 'Home',
              ),
              NavigationDestination(
                icon: Icon(Icons.explore_outlined),
                selectedIcon: Icon(Icons.explore),
                label: 'Discover',
              ),
              NavigationDestination(
                icon: Icon(Icons.storefront_outlined),
                selectedIcon: Icon(Icons.storefront),
                label: 'Market',
              ),
              NavigationDestination(
                icon: Icon(Icons.chat_bubble_outline),
                selectedIcon: Icon(Icons.chat_bubble),
                label: 'Messages',
              ),
              NavigationDestination(
                icon: Icon(Icons.person_outline),
                selectedIcon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
