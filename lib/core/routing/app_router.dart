import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../widgets/lex_bottom_navigation_shell.dart';
import '../widgets/lex_page.dart';
import 'app_routes.dart';
import 'route_guard.dart';

/// {@template app_router}
/// Configured [GoRouter] instance for the LEX app.
///
/// Includes top-level routes, nested tab navigation, deep-linking support,
/// state restoration, and route guards.
/// {@endtemplate}
final appRouterProvider = Provider<GoRouter>((Ref ref) {
  final RouteGuard routeGuard = ref.watch(routeGuardProvider);

  return GoRouter(
    initialLocation: AppRoutes.home,
    debugLogDiagnostics: kDebugMode,
    restorationScopeId: 'lex_router',
    redirect: (BuildContext context, GoRouterState state) {
      return routeGuard.redirect(context, state);
    },
    routes: <RouteBase>[
      GoRoute(
        path: AppRoutes.splash,
        builder: (BuildContext context, GoRouterState state) => const LexPage(),
      ),
      GoRoute(
        path: AppRoutes.onboarding,
        builder: (BuildContext context, GoRouterState state) => const LexPage(),
      ),
      GoRoute(
        path: AppRoutes.auth,
        builder: (BuildContext context, GoRouterState state) => const LexPage(),
      ),
      StatefulShellRoute.indexedStack(
        builder:
            (
              BuildContext context,
              GoRouterState state,
              StatefulNavigationShell navigationShell,
            ) {
              return LexBottomNavigationShell(navigationShell: navigationShell);
            },
        branches: <StatefulShellBranch>[
          _buildBranch(AppRoutes.home, const LexPage()),
          _buildBranch(AppRoutes.discover, const LexPage()),
          _buildBranch(AppRoutes.marketplace, const LexPage()),
          _buildBranch(AppRoutes.messages, const LexPage()),
          _buildBranch(AppRoutes.profile, const LexPage()),
        ],
      ),
      GoRoute(
        path: AppRoutes.live,
        builder: (BuildContext context, GoRouterState state) => const LexPage(),
      ),
      GoRoute(
        path: AppRoutes.search,
        builder: (BuildContext context, GoRouterState state) => const LexPage(),
      ),
      GoRoute(
        path: AppRoutes.settings,
        builder: (BuildContext context, GoRouterState state) => const LexPage(),
      ),
      GoRoute(
        path: AppRoutes.wallet,
        builder: (BuildContext context, GoRouterState state) => const LexPage(),
      ),
      GoRoute(
        path: AppRoutes.orders,
        builder: (BuildContext context, GoRouterState state) => const LexPage(),
      ),
      GoRoute(
        path: AppRoutes.cart,
        builder: (BuildContext context, GoRouterState state) => const LexPage(),
      ),
      GoRoute(
        path: AppRoutes.seller,
        builder: (BuildContext context, GoRouterState state) => const LexPage(),
      ),
      GoRoute(
        path: AppRoutes.admin,
        builder: (BuildContext context, GoRouterState state) => const LexPage(),
      ),
      GoRoute(
        path: AppRoutes.listing,
        builder: (BuildContext context, GoRouterState state) => const LexPage(),
      ),
      GoRoute(
        path: AppRoutes.reviews,
        builder: (BuildContext context, GoRouterState state) => const LexPage(),
      ),
    ],
  );
}, name: 'appRouterProvider');

StatefulShellBranch _buildBranch(String path, Widget page) {
  return StatefulShellBranch(
    routes: <RouteBase>[
      GoRoute(
        path: path,
        builder: (BuildContext context, GoRouterState state) => page,
      ),
    ],
  );
}
